const std = @import("std");

pub const BinaryError = error {
    EndOfFile,
};

pub const BinaryReader = struct {
    buffer: []u8,
    offset: usize,

    pub fn init(buffer: []u8) BinaryReader {
        return BinaryReader{ .buffer = buffer, .offset = 0 };
    }

    pub fn len(self: *BinaryReader) usize {
        return self.buffer.len;
    }

    pub fn pos(self: *BinaryReader) usize {
        return self.offset;
    }

    pub fn remaining(self: *BinaryReader) usize {
        return self.buffer.len - self.offset;
    }

    pub fn skip(self: *BinaryReader, comptime size: usize) BinaryError!void {
        if (self.offset + size > self.buffer.len) {
            return BinaryError.EndOfFile;
        }
        self.offset += size;
    }

    pub fn seek(self: *BinaryReader, comptime offset: usize) BinaryError!void {
        if (offset > self.buffer.len) {
            return BinaryError.EndOfFile;
        }
        self.offset = offset;
    }

    pub fn read(self: *BinaryReader, comptime T: type) BinaryError!T {
        const info = @typeInfo(T);
        const bytes = try self.readBytes(@divExact(info.int.bits, 8));
        return std.mem.readInt(T, &bytes, .big);
    }

    pub fn readBytes(self: *BinaryReader, comptime size: usize) BinaryError!*[size]u8 {
        if (self.offset + size > self.buffer.len) {
            return BinaryError.EndOfFile;
        }

        const result = self.buffer[self.offset..self.offset + size];
        const b = result[0..size];
        self.offset += size;
        return b;
    }

    pub fn readUtfBytes(self: *BinaryReader, comptime size: usize) BinaryError![]const u8 {
        return try self.readBytes(size);
    }

    pub fn readUtf(self: *BinaryReader) BinaryError![]const u8 {
        const size = @as(usize, try self.read(u16));
        return try self.readUtfBytes(size);
    }

    pub fn readBigUtf(self: *BinaryReader) BinaryError![]const u8 {
        const size = try self.read(u32);
        return try self.readUtfBytes(size);
    }
};