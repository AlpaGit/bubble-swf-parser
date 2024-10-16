const SwfFile = @import("main.zig").SwfFile;
const logger = @import("logger.zig");
const rl = @import("raylib");

pub const Renderer = struct {
    swf_file: *SwfFile,
    screen_width: i32,
    screen_height: i32,

    pub fn init(swf_file: *SwfFile) Renderer {
        return Renderer {
            .swf_file = swf_file,
            .screen_width = swf_file.header.stage_size.x_max.to_pixels() - swf_file.header.stage_size.x_min.to_pixels(),
            .screen_height = swf_file.header.stage_size.y_max.to_pixels() - swf_file.header.stage_size.y_min.to_pixels(),
        };
    }

    pub fn pre_render(self: *Renderer) !void {
        logger.info(@src(), "Pre-rendering SWF file {}", .{self});

    }

    pub fn render(self: *Renderer) !void {
        logger.debug(@src(), "Initializing render window at {} FPS of {}/{}",
            .{
                @as(u32,@intFromFloat(self.swf_file.header.frame_rate)),
                self.screen_width,
                self.screen_height,
            });

        rl.initWindow(self.screen_width, self.screen_height, "Rendering SWF");
        defer rl.closeWindow(); // Close window and OpenGL context
        rl.setTargetFPS(@intFromFloat(self.swf_file.header.frame_rate));

        _ = self.swf_file;
        logger.info(@src(), "Rendering SWF file", .{});
        //const raylib_zig = rl.Color.init(0, 0, 0, 255);

        while (!rl.windowShouldClose()) {
            rl.beginDrawing();
            defer rl.endDrawing();

            rl.clearBackground(rl.Color.ray_white);
            rl.drawFPS(10, 10);


        }
    }
};