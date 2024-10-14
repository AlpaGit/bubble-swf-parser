const std = @import("std");
const ctime = @cImport(@cInclude("time.h"));

pub const Gray: []const u8 = "\x1b[90m";
pub const Reset: []const u8 = "\x1b[0m";
pub const Yellow: []const u8 = "\x1b[33m";

const LogLevel = enum {
    Debug,
    Info,
    Warning,
    Error,

    pub fn to_color(self: LogLevel) []const u8 {
        switch (self) {
            LogLevel.Debug => return "\x1b[36m",
            LogLevel.Info => return "\x1b[32m",
            LogLevel.Warning => return "\x1b[33m",
            LogLevel.Error => return "\x1b[31m",
        }
    }

    pub fn to_str(self: LogLevel) []const u8 {
        switch (self) {
            LogLevel.Debug => return "DEBUG",
            LogLevel.Info => return "INFO",
            LogLevel.Warning => return "WARNING",
            LogLevel.Error => return "ERROR",
        }
    }
};

pub fn get_current_tiime() anyerror![]const u8 {
    var dt_str_buf: [15]u8 = undefined;
    const t = ctime.time(null);
    const lt = ctime.localtime(&t);
    const format = "%H:%M:%S";
    const dt_str_len = ctime.strftime(&dt_str_buf, dt_str_buf.len, format, lt);

    if (dt_str_len == 0) {
        return error.UnexpectedError;
    }

    return dt_str_buf[0..dt_str_len];
}

pub fn info(src: std.builtin.SourceLocation, comptime fmt: []const u8, args: anytype) void {
    log(src, LogLevel.Info, fmt, args);
}

pub fn err(src: std.builtin.SourceLocation, comptime fmt: []const u8, args: anytype) void {
    log(src, LogLevel.Error, fmt, args);
}

pub fn warning(src: std.builtin.SourceLocation, comptime fmt: []const u8, args: anytype) void {
    log(src, LogLevel.Warning, fmt, args);
}

pub fn debug(src: std.builtin.SourceLocation, comptime fmt: []const u8, args: anytype) void {
    log(src, LogLevel.Debug, fmt, args);
}

pub fn log(src: std.builtin.SourceLocation, log_level: LogLevel, comptime fmt: []const u8, args: anytype) void {
    const stdout = std.io.getStdOut().writer();
    const time = get_current_tiime() catch unreachable;

    stdout.print("{s}{s} {s}{s}{s} ", .{ Gray, time, log_level.to_color(), log_level.to_str(), Reset }) catch unreachable;
    stdout.print("{s}{s}:{d}{s} ", .{ Gray, src.file, src.line, Reset }) catch unreachable;

    // we want to make the arguments in color

    stdout.print(fmt, args) catch unreachable;
    stdout.print("{s}\n", .{Reset}) catch unreachable;
}
