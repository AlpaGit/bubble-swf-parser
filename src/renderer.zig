const SwfFile = @import("main.zig").SwfFile;
const logger = @import("logger.zig");
const rl = @import("raylib");
const std = @import("std");
const tags = @import("tags.zig");

const ExportedAsset = tags.ExportedAsset;

pub const SwfObject = union(enum) {
    Frame: Frame,
    FrameContainer: FrameContainer,
};

pub const Frame = struct {
    type: []u8,
    display_list: ?std.AutoHashMap(u16, u16),

    pub fn jsonStringify(self: @This(), jws: anytype) !void {
        var allocator = std.heap.ArenaAllocator.init(std.heap.page_allocator);

        try jws.beginObject();
        try jws.objectField("type");
        try jws.write(self.type);

        if(self.display_list != null) {
            try jws.objectField("display_list");
            try jws.beginObject();

            // we have to iterate over the hashmap
            var it = self.display_list.?.iterator();
            while (it.next()) |kv| {
                // we stringify the key since its a u8 and we need a []u8
                const keyBuffer =  std.fmt.allocPrint(allocator.allocator(), "{d}", .{kv.key_ptr.*}) catch return;
                std.log.debug("Key: {any}", .{keyBuffer});

                try jws.objectField(keyBuffer);
                try jws.write(kv.value_ptr.*);
            }

            try jws.endObject();
        }

        try jws.endObject();
    }
};

pub const FrameContainer = struct {
    type: []u8,
    frame_count: i16,
    id: u32,
    timeline: ?std.ArrayList(Frame),
    symbol_classes: ?[]ExportedAsset,

    pub fn jsonStringify(self: @This(), jws: anytype) !void {
        try jws.beginObject();
        try jws.objectField("type");
        try jws.write(self.type);
        try jws.objectField("frame_count");
        try jws.write(self.frame_count);
        try jws.objectField("id");
        try jws.write(self.id);

        if(self.timeline != null) {
            try jws.objectField("timeline");
            try jws.write(self.timeline.?.items);
        }

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
    frame_map: std.AutoHashMap(u16, FrameContainer),

    allocator: std.mem.Allocator,

    pub fn init(swf_file: *SwfFile, allocator: std.mem.Allocator) Renderer {
        return Renderer {
            .swf_file = swf_file,
            .screen_width = swf_file.header.stage_size.x_max.to_pixels() - swf_file.header.stage_size.x_min.to_pixels(),
            .screen_height = swf_file.header.stage_size.y_max.to_pixels() - swf_file.header.stage_size.y_min.to_pixels(),
            .frame_map = std.AutoHashMap(u16, Frame).init(allocator),
            .allocator = allocator,
        };
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
        var main_frame = FrameContainer{
            .type = try self.allocate_string("main"),
            .frame_count = self.swf_file.header.num_frames,
            .id = 0,
            .timeline = std.ArrayList(Frame).init(self.allocator),
            .symbol_classes = null,
        };


        try self.handle_tags(&main_frame, self.swf_file.tags);
        try save_main_frame_as_json(main_frame);
    }

    fn handle_tags(self: *Renderer, frame_container: *FrameContainer, tags_list: []tags.Tag) anyerror!void {
        // We are trying to split at every ShowFrame or End tag
        var end_file = false;

        var num_tags:u32 = 0;
        var remaining_tags = tags_list;
        while(!end_file) {
            var frame = Frame{
                .type = try self.allocate_string("frame"),
                .display_list = std.AutoHashMap(u16, u16).init(self.allocator),
            };

            // we do a while until we get a SHOW_FRAME tag
            for(0.., remaining_tags)|i, tag| {
                if(tag == tags.TagCode.ShowFrame or tag == tags.TagCode.End) {
                    end_file = tag == tags.TagCode.End;
                    remaining_tags = remaining_tags[i+1..];
                    break;
                }

                logger.debug(@src(), "Tag: {}", .{tag});

                num_tags += 1;

                switch(tag){
                    .DefineSprite => {
                        var sprite_container = FrameContainer {
                            .type = try self.allocate_string("sprite"),
                            .frame_count = tag.DefineSprite.frame_count,
                            .id = tag.DefineSprite.id,
                            .timeline = std.ArrayList(Frame).init(self.allocator),
                            .symbol_classes = null,
                        };
                        self.frame_map.put(tag.DefineSprite.id, sprite_container);

                        try self.handle_tags(&sprite_container, tag.DefineSprite.tags);
                        break;
                    },
                    .ExportAssets => {
                        frame.symbol_classes = tag.ExportAssets.assets;
                        break;
                    },
                    .PlaceObject, .PlaceObject2, .PlaceObject3, .PlaceObject4 => {
                        logger.debug(@src(), "PlaceObject: {}", .{tag});

                        const place_object = tag.PlaceObject;
                        const depth = place_object.depth;

                        switch (place_object.action) {
                            .Place => {
                                try frame.display_list.?.put(depth, place_object.action.Place);
                            },
                            .Replace => {
                                try frame.display_list.?.put(depth, place_object.action.Replace);
                            },
                            else => {},
                        }
                        break;
                    },
                    else => { }
                }
            }

            if(num_tags > 0) {
                try frame_container.timeline.?.append(frame);
            }
        }
    }

    fn save_main_frame_as_json(frame: FrameContainer) !void {
        const file = try std.fs.cwd().createFile("main_frame.json", .{.read = true });
        try std.json.stringify(frame, .{ .whitespace = .indent_tab }, file.writer());

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

        }
    }
};