const SwfFile = @import("main.zig").SwfFile;
const logger = @import("logger.zig");
const rl = @import("raylib");
const std = @import("std");
const tags = @import("tags.zig");
const io = @import("io.zig");

const LittleEndianReader = io.LittleEndianReader;
const ExportedAsset = tags.ExportedAsset;
const Rectangle = tags.Rectangle;
const ShapeRecord = tags.ShapeRecord;
const Color = tags.Color;
const Matrix = tags.Matrix;
const Point = tags.Point;
const Fixed8 = tags.Fixed8;
const GradientInterpolation = tags.GradientInterpolation;

pub const SwfObject = union(enum) {
    Frame: *Frame,
    FrameContainer: *FrameContainer,
    Image: *Image,
    Shape: *Shape,
};

pub const Style = union(enum) {
    Solid: Color,
    LinearOrRadial: LinearOrRadialStyle,
    Pattern: PatternStyle,
};

pub const StyleStop = struct {
    offset: f32,
    color: Color
};

pub const LinearOrRadialStyle = struct {
    type: []const u8,
    matrix: Matrix,
    spread: u8,
    interpolation: GradientInterpolation,
    stops: []StyleStop,
    focal_point: ?Fixed8,
};

pub const PatternStyle = struct {
    type: []const u8,
    image: []u8,
    matrix: Matrix,
    repeat: bool,
    non_smoothed: bool,
};

pub const Shape = struct {
    type: []const u8,
    id: u16,
    bounds: Rectangle,
    stroke_rect: ?Rectangle,
    edges: []ShapeRecord,
    uses_fill_winding_rule: bool = false,
    uses_non_scaling_strokes: bool = false,
    uses_scaling_strokes: bool = false,

    pub fn jsonStringify(self: @This(), jws: anytype) !void {
        try jws.beginObject();
        try jws.objectField("type");
        try jws.write(self.type);
        try jws.objectField("id");
        try jws.write(self.id);
        try jws.objectField("bounds");
        try jws.write(self.bounds);
        try jws.objectField("stroke_rect");
        try jws.write(self.stroke_rect);
        //try jws.objectField("edges");
        //try jws.write(self.edges);
        try jws.endObject();
    }
};

pub const Image = struct {
    type: []const u8,
    id: u16,
    data: []const u8,
};

pub const Frame = struct {
    type: []const u8,
    display_list: std.AutoHashMap(u16, u16),

    pub fn jsonStringify(self: @This(), jws: anytype) !void {
        var allocator = std.heap.ArenaAllocator.init(std.heap.page_allocator);

        try jws.beginObject();
        try jws.objectField("type");
        try jws.write(self.type);

        try jws.objectField("display_list");
        try jws.beginObject();

        // we have to iterate over the hashmap
        var it = self.display_list.iterator();
        while (it.next()) |kv| {
            // we stringify the key since its a u8 and we need a []u8
            const keyBuffer =  std.fmt.allocPrint(allocator.allocator(), "{d}", .{kv.key_ptr.*}) catch return;

            try jws.objectField(keyBuffer);
            try jws.write(kv.value_ptr.*);
        }

        try jws.endObject();
        try jws.endObject();

        allocator.deinit();
    }
};

pub const FrameContainer = struct {
    type: []const u8,
    frame_count: i16,
    id: u32,
    timeline: std.ArrayList(Frame),
    symbol_classes: ?[]ExportedAsset,

    pub fn jsonStringify(self: @This(), jws: anytype) !void {
        try jws.beginObject();
        try jws.objectField("type");
        try jws.write(self.type);
        try jws.objectField("frame_count");
        try jws.write(self.frame_count);
        try jws.objectField("id");
        try jws.write(self.id);

        try jws.objectField("timeline");
        try jws.write(self.timeline.items);

        if(self.symbol_classes != null) {
            try jws.objectField("symbol_classes");
            try jws.write(self.symbol_classes.?);
        }

        try jws.endObject();
    }
};


pub const Renderer = struct {
    swf_file: *SwfFile,
    screen_width: i32,
    screen_height: i32,
    swf_objects: std.AutoHashMap(u16, *SwfObject),
    curr_shape_rendering: ?*Shape,

    allocator: std.mem.Allocator,

    pub fn init(swf_file: *SwfFile, allocator: std.mem.Allocator) Renderer {
        return Renderer {
            .swf_file = swf_file,
            .screen_width = swf_file.header.stage_size.x_max.to_pixels() - swf_file.header.stage_size.x_min.to_pixels(),
            .screen_height = swf_file.header.stage_size.y_max.to_pixels() - swf_file.header.stage_size.y_min.to_pixels(),
            .swf_objects = std.AutoHashMap(u16, *SwfObject).init(allocator),
            .curr_shape_rendering = null,
            .allocator = allocator,
        };
    }

    pub fn jsonStringify(self: @This(), jws: anytype) !void {
        try jws.beginObject();
        //try jws.objectField("swf_file");
        //try jws.write(self.swf_file);
        try jws.objectField("screen_width");
        try jws.write(self.screen_width);
        try jws.objectField("screen_height");
        try jws.write(self.screen_height);

        if(self.swf_objects.count() > 0) {
            try jws.objectField("swf_objects");
            try jws.beginObject();

            var it = self.swf_objects.iterator();
            while (it.next()) |kv| {
                const keyBuffer =  std.fmt.allocPrint(self.allocator, "{d}", .{kv.key_ptr.*}) catch return;

                try jws.objectField(keyBuffer);
                try jws.write(kv.value_ptr.*);
            }

            try jws.endObject();
        }
        try jws.endObject();
    }

    pub fn pre_render(self: *Renderer) !void {
        logger.info(@src(), "Pre-rendering SWF file {}", .{self});

        try self.parse_main_frame();
    }

    pub fn allocate_string(self: *Renderer, comptime string: []const u8) ![]u8 {
        return try std.fmt.allocPrint(self.allocator, string, .{});
    }

    pub fn parse_main_frame(self: *Renderer) !void {
        logger.debug(@src(), "---------------------------------------------", .{});
        // we need to allocate it in the heap
        const main_frame_ptr = try self.allocator.create(FrameContainer);
        main_frame_ptr.* = FrameContainer{
            .type = "main",
            .frame_count = self.swf_file.header.num_frames,
            .id = 0,
            .timeline = std.ArrayList(Frame).init(self.allocator),
            .symbol_classes = null,
        };

        const swf_object_ptr = try self.allocator.create(SwfObject);
        swf_object_ptr.* = SwfObject {
            .FrameContainer = main_frame_ptr,
        };

        try self.swf_objects.put(0, swf_object_ptr);

        try self.handle_tags(main_frame_ptr, self.swf_file.tags);
        try self.save_as_json();
    }

    fn handle_tags(self: *Renderer, frame_container: *FrameContainer, tags_list: []tags.Tag) anyerror!void {
        // We are trying to split at every ShowFrame or End tag
        var end_file = false;

        var num_tags:u32 = 0;
        var remaining_tags = tags_list;
        while(!end_file) {
            var frame = Frame{
                .type = "frame",
                .display_list = std.AutoHashMap(u16, u16).init(self.allocator),
            };

            // we do a while until we get a SHOW_FRAME tag
            for(0.., remaining_tags)|i, tag| {
                if(tag == tags.TagCode.ShowFrame) {
                    remaining_tags = remaining_tags[i+1..];
                    break;
                }

                if(tag == tags.TagCode.End)
                {
                    end_file = true;
                    break;
                }

                num_tags += 1;

                switch(tag){
                    .DefineBits => {
                        const image = tag.DefineBits;
                        const image_ptr = try self.allocator.create(Image);
                        image_ptr.* = Image{
                            .type = "image",
                            .id = image.id,
                            .data = image.jpeg_data,
                        };

                        const swf_object_ptr = try self.allocator.create(SwfObject);
                        swf_object_ptr.* = SwfObject {
                            .Image = image_ptr,
                        };

                        try self.swf_objects.put(image.id, swf_object_ptr);
                    },
                    .DefineSprite => {
                        // we need to allocate it in the heap
                        const sprite_container_ptr = try self.allocator.create(FrameContainer);
                        sprite_container_ptr.* =  FrameContainer {
                            .type = try self.allocate_string("sprite"),
                            .frame_count = tag.DefineSprite.frame_count,
                            .id = tag.DefineSprite.id,
                            .timeline = std.ArrayList(Frame).init(self.allocator),
                            .symbol_classes = null,
                        };

                        const swf_object_ptr = try self.allocator.create(SwfObject);
                        swf_object_ptr.* =  SwfObject {
                            .FrameContainer = sprite_container_ptr,
                        };

                        try self.swf_objects.put(tag.DefineSprite.id, swf_object_ptr);

                        try self.handle_tags(sprite_container_ptr, tag.DefineSprite.tags);
                    },
                    .DefineShape => {
                        try self.read_shape(&tag.DefineShape);
                    },
                    .DefineShape2 => {
                        try self.read_shape(&tag.DefineShape2);
                    },
                    .DefineShape3 => {
                        try self.read_shape(&tag.DefineShape3);
                    },
                    .DefineShape4 => {
                        try self.read_shape(&tag.DefineShape4);
                    },
                    .ExportAssets => {
                        frame_container.symbol_classes = tag.ExportAssets.assets;
                    },
                    .PlaceObject, .PlaceObject2, .PlaceObject3, .PlaceObject4 => {
                        const place_object = tag.PlaceObject;
                        const depth = place_object.depth;

                        logger.debug(@src(), "PlaceObject: {}", .{place_object});

                        switch (place_object.action) {
                            .Place => {
                                try frame.display_list.put(depth, place_object.action.Place);
                            },
                            .Replace => {
                                try frame.display_list.put(depth, place_object.action.Replace);
                            },
                            else => {},
                        }
                    },
                    else => { }
                }
            }

            if(num_tags > 0) {
                try frame_container.timeline.append(frame);
            }
        }
    }

    fn read_shape(self: *Renderer, shape: *const tags.DefineShape) !void {
        const shape_object = Shape{
            .type = "shape",
            .id = shape.id,
            .bounds = shape.shape_bounds,
            .stroke_rect = shape.edge_bounds,
            .edges = shape.shapes
        };

        const shape_ptr = try self.allocator.create(Shape);
        shape_ptr.* = shape_object;

        const swf_object_ptr = try self.allocator.create(SwfObject);
        swf_object_ptr.* = SwfObject {
            .Shape = shape_ptr,
        };

        if(shape_object.id == 1){
            self.curr_shape_rendering = shape_ptr;
        }

        try self.swf_objects.put(shape.id, swf_object_ptr);
    }

    fn save_as_json(self: *Renderer) !void {
        logger.info(@src(), "Saving Renderer as JSON", .{});

        const file = try std.fs.cwd().createFile("renderer.json", .{.read = true });
        try std.json.stringify(self, .{ .whitespace = .indent_tab }, file.writer());

        file.close();
    }


    pub fn render(self: *Renderer) !void {
        try self.pre_render();

        logger.debug(@src(), "Initializing render window at {} FPS of {}/{}",
            .{
                @as(u32,@intFromFloat(self.swf_file.header.frame_rate)),
                self.screen_width,
                self.screen_height,
            });

        rl.setTraceLogLevel(.log_error);

        rl.initWindow(self.screen_width, self.screen_height, "Rendering SWF");
        defer rl.closeWindow(); // Close window and OpenGL context
        rl.setTargetFPS(@intFromFloat(self.swf_file.header.frame_rate));

        _ = self.swf_file;
        logger.info(@src(), "Rendering SWF file", .{});
        const background_color = rl.Color.init(self.swf_file.background_color.r,
            self.swf_file.background_color.g,
            self.swf_file.background_color.b,
            self.swf_file.background_color.a);

        while (!rl.windowShouldClose()) {
            rl.beginDrawing();
            defer rl.endDrawing();

            rl.clearBackground(background_color);
            rl.drawFPS(1, 1);

            // lets render the shape !
            if(self.curr_shape_rendering == null)
            {
                continue;
            }

            var points = std.ArrayList(rl.Vector2).init(self.allocator);
            var curr_point = rl.Vector2{ .x = 0, .y = 0 };

            const shape:Shape = self.curr_shape_rendering.?.*;

            for(shape.edges)|edge|{
                switch (edge) {
                    .StyleChange => {
                        //logger.debug(@src(), "StyleChange", .{});

                        // we draw the last points
                        if(points.items.len > 0){
                            logger.debug(@src(), "Drawing points: {}", .{points.items.len});
                            for(points.items)|point|{
                                logger.debug(@src(), "Point: {}", .{point});
                            }
                            points.clearAndFree();
                        }

                        if(edge.StyleChange.move_to != null){
                            curr_point = rl.Vector2 {
                                .x = edge.StyleChange.move_to.?.x.to_pixels_f32(),
                                .y = edge.StyleChange.move_to.?.y.to_pixels_f32(),
                            };

                            try points.append(curr_point);
                        }
                    },
                    .CurvedEdge => {
                        //logger.debug(@src(), "CurvedEdge", .{});
                    },
                    .StraightEdge => {
                        //logger.debug(@src(), "StraightEdge", .{});
                        curr_point = rl.Vector2 {
                            .x = curr_point.x + edge.StraightEdge.delta.dx.to_pixels_f32(),
                            .y = curr_point.x + edge.StraightEdge.delta.dy.to_pixels_f32(),
                        };

                        try points.append(curr_point);
                    },
                }
            }
        }
    }
};