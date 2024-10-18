const SwfFile = @import("main.zig").SwfFile;
const logger = @import("logger.zig");
const std = @import("std");
const tags = @import("tags.zig");
const io = @import("io.zig");
const gl = @import("gl.zig");
const glfw = @import("glfw");
const skia = @import("skia_bindings.zig");


const LittleEndianReader = io.LittleEndianReader;
const ExportedAsset = tags.ExportedAsset;
const Rectangle = tags.Rectangle;
const ShapeRecord = tags.ShapeRecord;
const ShapeStyles = tags.ShapeStyles;
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


pub const Shape = struct {
    type: []const u8,
    id: u16,
    bounds: Rectangle,
    stroke_rect: ?Rectangle,
    edges: []ShapeRecord,
    styles: ShapeStyles,
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
            const keyBuffer = std.fmt.allocPrint(allocator.allocator(), "{d}", .{kv.key_ptr.*}) catch return;

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

        if (self.symbol_classes != null) {
            try jws.objectField("symbol_classes");
            try jws.write(self.symbol_classes.?);
        }

        try jws.endObject();
    }
};

pub const Renderer = struct {
    swf_file: *SwfFile,
    screen_size: Point(u32),
    swf_objects: std.AutoHashMap(u16, *SwfObject),
    curr_shape_rendering: ?*Shape,

    allocator: std.mem.Allocator,

    pub fn init(swf_file: *SwfFile, allocator: std.mem.Allocator) Renderer {
        return Renderer{
            .swf_file = swf_file,
            .screen_size = Point(u32) {
                .x = swf_file.header.stage_size.x_max.to_pixels_u32() - swf_file.header.stage_size.x_min.to_pixels_u32(),
                .y = swf_file.header.stage_size.y_max.to_pixels_u32() - swf_file.header.stage_size.y_min.to_pixels_u32(),
            },
            .swf_objects = std.AutoHashMap(u16, *SwfObject).init(allocator),
            .curr_shape_rendering = null,
            .allocator = allocator,
        };
    }

    pub fn jsonStringify(self: @This(), jws: anytype) !void {
        try jws.beginObject();
        //try jws.objectField("swf_file");
        //try jws.write(self.swf_file);
        try jws.objectField("screen_size");
        try jws.write(self.screen_size);

        if (self.swf_objects.count() > 0) {
            try jws.objectField("swf_objects");
            try jws.beginObject();

            var it = self.swf_objects.iterator();
            while (it.next()) |kv| {
                const keyBuffer = std.fmt.allocPrint(self.allocator, "{d}", .{kv.key_ptr.*}) catch return;

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
        swf_object_ptr.* = SwfObject{
            .FrameContainer = main_frame_ptr,
        };

        try self.swf_objects.put(0, swf_object_ptr);

        try self.handle_tags(main_frame_ptr, self.swf_file.tags);
        try self.save_as_json();
    }

    fn handle_tags(self: *Renderer, frame_container: *FrameContainer, tags_list: []tags.Tag) anyerror!void {
        // We are trying to split at every ShowFrame or End tag
        var end_file = false;

        var num_tags: u32 = 0;
        var remaining_tags = tags_list;
        while (!end_file) {
            var frame = Frame{
                .type = "frame",
                .display_list = std.AutoHashMap(u16, u16).init(self.allocator),
            };

            // we do a while until we get a SHOW_FRAME tag
            for (0.., remaining_tags) |i, tag| {
                if (tag == tags.TagCode.ShowFrame) {
                    remaining_tags = remaining_tags[i + 1 ..];
                    break;
                }

                if (tag == tags.TagCode.End) {
                    end_file = true;
                    break;
                }

                num_tags += 1;

                switch (tag) {
                    .DefineBits => {
                        const image = tag.DefineBits;
                        const image_ptr = try self.allocator.create(Image);
                        image_ptr.* = Image{
                            .type = "image",
                            .id = image.id,
                            .data = image.jpeg_data,
                        };

                        const swf_object_ptr = try self.allocator.create(SwfObject);
                        swf_object_ptr.* = SwfObject{
                            .Image = image_ptr,
                        };

                        try self.swf_objects.put(image.id, swf_object_ptr);
                    },
                    .DefineSprite => {
                        // we need to allocate it in the heap
                        const sprite_container_ptr = try self.allocator.create(FrameContainer);
                        sprite_container_ptr.* = FrameContainer{
                            .type = try self.allocate_string("sprite"),
                            .frame_count = tag.DefineSprite.frame_count,
                            .id = tag.DefineSprite.id,
                            .timeline = std.ArrayList(Frame).init(self.allocator),
                            .symbol_classes = null,
                        };

                        const swf_object_ptr = try self.allocator.create(SwfObject);
                        swf_object_ptr.* = SwfObject{
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
                    else => {},
                }
            }

            if (num_tags > 0) {
                try frame_container.timeline.append(frame);
            }
        }
    }

    fn read_shape(self: *Renderer, shape: *const tags.DefineShape) !void {
        const shape_object = Shape
        {
            .type = "shape",
            .id = shape.id,
            .bounds = shape.shape_bounds,
            .stroke_rect = shape.edge_bounds,
            .edges = shape.shapes,
            .styles = shape.styles
        };

        const shape_ptr = try self.allocator.create(Shape);
        shape_ptr.* = shape_object;

        const swf_object_ptr = try self.allocator.create(SwfObject);
        swf_object_ptr.* = SwfObject{
            .Shape = shape_ptr,
        };

        if (shape_object.id == 1) {
            self.curr_shape_rendering = shape_ptr;
        }

        try self.swf_objects.put(shape.id, swf_object_ptr);
    }

    fn save_as_json(self: *Renderer) !void {
        logger.info(@src(), "Saving Renderer as JSON", .{});

        const file = try std.fs.cwd().createFile("renderer.json", .{ .read = true });
        try std.json.stringify(self, .{ .whitespace = .indent_tab }, file.writer());

        file.close();
    }

    var gl_procs: gl.ProcTable = undefined;


    fn errorCallback(code: glfw.ErrorCode, description: [:0]const u8) void {
        logger.warning(@src(),"GLFW error 0x{}: {s}\n", .{code, description});
    }


    pub fn render(self: *Renderer) !void {
        try self.pre_render();

        if (!glfw.init(.{})) return error.InitFailed;
        defer glfw.terminate();

        _ = glfw.setErrorCallback(errorCallback);

        const width:u32 = self.screen_size.x;
        const height:u32 = self.screen_size.y;

        const window = glfw.Window.create(width, height, "Rendering !", null, null, .{
            .context_version_major = gl.info.version_major,
            .context_version_minor = gl.info.version_minor,
            .opengl_profile = .opengl_core_profile,
            .opengl_forward_compat = true,
            .resizable = false
        }) orelse return error.InitFailed;
        defer window.destroy();

        glfw.makeContextCurrent(window);
        defer glfw.makeContextCurrent(null);

        // Enable VSync to avoid drawing more often than necessary.
        glfw.swapInterval(1);

        // Initialize the OpenGL procedure table.
        if (!gl_procs.init(glfw.getProcAddress)) return error.InitFailed;

        // Make the OpenGL procedure table current.
        gl.makeProcTableCurrent(&gl_procs);
        defer gl.makeProcTableCurrent(null);

        // The window and OpenGL are now both fully initialized.
        const gr_glinterface = skia.gr_glinterface_create_native_interface() orelse return error.SkiaCreateGLInterfaceFailed;
        defer skia.gr_glinterface_unref(gr_glinterface);
        const gr_context = skia.gr_direct_context_make_gl(gr_glinterface) orelse return error.SkiaCreateContextFailed;
        defer skia.gr_direct_context_free_gpu_resources(gr_context);

        const gl_info = skia.gr_gl_framebufferinfo_t {
            .fFBOID = 0,
            .fFormat = gl.RGBA8,
        };

        const rendertarget = skia.gr_backendrendertarget_new_gl(
            @intCast(width),
            @intCast(height),
            0,
            0,
            &gl_info,
        );

        const color_type = skia.RGBA_8888_SK_COLORTYPE;
        const colorspace = null;
        const props = null;

        const surface = skia.sk_surface_new_backend_render_target(
            @ptrCast(gr_context),
            rendertarget,
            1,
            color_type,
            colorspace,
            props,
        ) orelse return error.SkiaCreateSurfaceFailed;
        defer skia.sk_surface_unref(surface);

        const canvas = skia.sk_surface_get_canvas(surface) orelse unreachable;

        while (!window.shouldClose()) {
            try self.draw(window, canvas);
        }

        glfw.terminate();

        logger.debug(@src(), "Initializing render window at {} FPS of {}", .{
            @as(u32, @intFromFloat(self.swf_file.header.frame_rate)),
            self.screen_size,
        });

        _ = self.swf_file;
        logger.info(@src(), "Rendering SWF file", .{});
    }

    fn draw(self: *Renderer, window: glfw.Window, canvas: *skia.sk_canvas_t) !void {
        glfw.pollEvents();

        {
            skia.sk_canvas_clear(canvas, 0xffffffff);
            const fill = skia.sk_paint_new() orelse return error.SkiaCreatePaintFailed;
            defer skia.sk_paint_delete(fill);
            const color =  self.swf_file.background_color.to_hex();

            skia.sk_paint_set_color(fill, color);
            skia.sk_canvas_draw_paint(canvas, fill);


            try self.render_shape(canvas, self.curr_shape_rendering.?);
            // lets render the shape !
            //if (self.curr_shape_rendering == null) {
            //    continue;
            //}

            skia.sk_canvas_flush(canvas);
        }

        const w_size = window.getSize();

        self.screen_size = Point(u32) {
            .x = w_size.width,
            .y = w_size.height,
        };
        window.swapBuffers();
    }

    fn normalize(point: Point(f32), window: Point(u32), bounds: Rectangle) Point(f32) {
        const bound_x_total = bounds.x_max.to_pixels_f32() - bounds.x_min.to_pixels_f32();
        const bound_y_total = bounds.y_max.to_pixels_f32() - bounds.y_min.to_pixels_f32();

        const ratio_x:f32 = @as(f32, @floatFromInt(window.x)) / bound_x_total;
        const ratio_y:f32 = @as(f32, @floatFromInt(window.y)) / bound_y_total;

        // we get the smaller value and use ratio
        const ratio = if(ratio_x < ratio_y)  ratio_x else ratio_y;

        const x:f32 = point.x * ratio;
        const y:f32 = point.y * ratio;

        //logger.debug(@src(), "r{d},{d} & b{d},{d} & w{d},{d} & f{d},{d}", .{
        //    ratio_x, ratio_y, bound_x_total, bound_y_total, window.x, window.y, x, y,
        //});

        return Point(f32){ .x = x, .y =  y };
    }

    fn render_points(self: *Renderer, canvas: *skia.sk_canvas_t, bounds: Rectangle,  points: []Point(f32), color: Color) !void {
        logger.debug(@src(), "Drawing points: {}", .{points.len});

        const path = skia.sk_path_new() orelse return error.SkiaCreatePathFailed;
        const fill = skia.sk_paint_new() orelse return error.SkiaCreatePaintFailed;
        defer skia.sk_paint_delete(fill);
        defer skia.sk_path_delete(path);

        logger.debug(@src(), "Color: {}", .{color.to_hex()});
        skia.sk_paint_set_color(fill, color.to_hex());

        var real_coord = normalize(points[0], self.screen_size, bounds);

        skia.sk_path_move_to(path,  real_coord.x, real_coord.y);

        for(points) | point| {
            real_coord = normalize(point, self.screen_size, bounds);

            skia.sk_path_line_to(path, real_coord.x, real_coord.y);
            //skia.sk_path_move_to(path, real_coord.x, real_coord.y);
            logger.debug(@src(), "Drawing point: {d},{d}", .{real_coord.x, real_coord.y});
        }

        skia.sk_path_close(path);
        skia.sk_canvas_draw_path(canvas, path, fill);
    }

    fn render_shape(self: *Renderer, canvas: *skia.sk_canvas_t, shape: *Shape) !void {
        logger.debug(@src(), "Rendering shape", .{});

        var points = std.ArrayList(Point(f32)).init(self.allocator);
        var curr_point = Point(f32){ .x = 0, .y = 0 };
        var curr_color = Color{ .r = 0, .g = 0, .b = 0, .a = 0 };

        for (shape.edges) |edge| {
            switch (edge) {
                .StyleChange => {
                    logger.debug(@src(), "StyleChange", .{});

                    if(edge.StyleChange.move_to != null) {
                        curr_point = Point(f32){
                            .x = edge.StyleChange.move_to.?.x.to_pixels_f32(),
                            .y = edge.StyleChange.move_to.?.y.to_pixels_f32()
                        };

                        // we draw the last points
                        if (points.items.len > 0) {
                            try self.render_points(canvas, shape.bounds, points.items, curr_color);
                            points.clearAndFree();
                        }
                    }

                    if(edge.StyleChange.fill_style_1 != null) {
                        const style = shape.styles.fill_styles[edge.StyleChange.fill_style_1.? - 1];

                        logger.debug(@src(), "StyleChange fill_style_1: {}", .{style.Color.to_hex()});
                        curr_color = style.Color;
                    }
                },
                .CurvedEdge => {
                    //logger.debug(@src(), "CurvedEdge", .{});
                },
                .StraightEdge => {
                    curr_point = Point(f32){
                        .x = curr_point.x + edge.StraightEdge.delta.dx.to_pixels_f32(),
                        .y = curr_point.y + edge.StraightEdge.delta.dy.to_pixels_f32(),
                    };
                    logger.debug(@src(), "StraightEdge {d},{d}", .{edge.StraightEdge.delta.dx.value, edge.StraightEdge.delta.dy.value});

                    try points.append(curr_point);
                },
            }
        }

        try self.render_points(canvas, shape.bounds, points.items, curr_color);
    }
};
