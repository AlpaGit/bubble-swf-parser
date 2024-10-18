const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "bubble-swf-parser",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const mach_glfw_dep = b.dependency("mach-glfw", .{
        .target = target,
        .optimize = optimize,
    });
    exe.linkLibC();
    exe.addLibraryPath(b.path("deps/skia/lib/win-x86_64"));
    exe.linkSystemLibrary("skia");
    // Import the generated module.
    exe.root_module.addImport("glfw", mach_glfw_dep.module("mach-glfw"));

    b.installArtifact(exe);


    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const copy_gl = b.addUpdateSourceFiles();
    copy_gl.addCopyFileToSource(@import("zigglgen").generateBindingsSourceFile(b, .{
        .api = .gl,
        .version = .@"4.6",
        .profile = .core,
        .extensions = &.{ .ARB_clip_control, .NV_scissor_exclusive },
    }), "gl.zig");

    const update_gl = b.step("update-gl-bindings", "Update 'gl.zig'");
    update_gl.dependOn(&copy_gl.step);

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
