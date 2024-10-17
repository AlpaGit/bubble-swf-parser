const std = @import("std");
const tags = @import("tags.zig");
const Matrix = @import("matrix.zig").Matrix;

const mem = std.mem;
const Endian = std.builtin.Endian;
const testing = std.testing;

pub const TagCode = tags.TagCode;
pub const Tag = tags.Tag;
const TagMetadata = tags.TagMetadata;

const Color = tags.Color;
pub const Rectangle = tags.Rectangle;
pub const Twips = tags.Twips;

pub const Fixed8 = f32;
pub const Fixed16 = f32;

// const BitReader = std.io.BitReader;
// const FixedBufferStreamReader = std.io.Reader(
//     *std.io.FixedBufferStream([]u8),
//     std.io.FixedBufferStream([]u8).ReadError,
//     std.io.FixedBufferStream([]u8).read,
// );

// const MemoryBitReader = std.io.BitReader(
//    std.builtin.Endian.big,
//    FixedBufferStreamReader,
//    );


pub const Error = error{
    EOF,
};



pub const LittleEndianReader = struct {
    buffer: []u8,
    position: usize,

    bit_buffer: u8,
    bit_position: u3 = 0,
    bit_last_position: usize,

    swf_version: u8 = 10,

    pub fn init(buffer: []u8) LittleEndianReader {
        return LittleEndianReader{
            .buffer = buffer,
            .position = 0,
            .bit_buffer = 0,
            .bit_position = 0,
            .bit_last_position = 0,
        };
    }

    pub fn seek(self: *LittleEndianReader, position: usize) void {
        self.position = position;
    }

    pub fn eof(self: *LittleEndianReader) bool {
        return self.position >= self.buffer.len;
    }

    pub fn set_swf_version(self: *LittleEndianReader, version: u8) void {
        self.swf_version = version;
    }

    pub fn bits(self: *LittleEndianReader) u8 {
        return self.bit_buffer;
    }

    pub fn read_utf8(self: *LittleEndianReader, size: u64) Error![]u8 {
        if (self.position + size > self.buffer.len) {
            return Error.EOF;
        }

        const result = self.buffer[self.position .. self.position + size];
        self.position += size;

        return result;
    }

    pub fn read_bytes(self: *LittleEndianReader, size: u64) Error![]u8 {
        return try self.read_utf8(size);
    }

    pub fn read_all(
        self: *LittleEndianReader,
    ) Error![]u8 {
        const result = self.buffer[self.position..];
        self.position = self.buffer.len;

        return result;
    }

    pub fn read_n(self: *LittleEndianReader, size: comptime_int) Error!*[size]u8 {
        if (self.position + size > self.buffer.len) {
            std.log.debug("Buffer is too small to read {d} bytes ({d}/{d})", .{size, self.position, self.buffer.len});
            return Error.EOF;
        }

        const result = self.buffer[self.position..][0..size];
        self.position += size;

        return result;
    }

    pub fn read_u8(self: *LittleEndianReader) Error!u8 {
        if (self.position >= self.buffer.len) {
            return Error.EOF;
        }

        const result = self.buffer[self.position];
        self.position += 1;
        return result;
    }

    pub fn read_u16(self: *LittleEndianReader) Error!u16 {
        return std.mem.readInt(u16, try self.read_n(2), Endian.little);
    }

    pub fn read_i16(self: *LittleEndianReader) Error!i16 {
        return std.mem.readInt(i16, try self.read_n(2), Endian.little);
    }

    pub fn read_u32(self: *LittleEndianReader) Error!u32 {
        return std.mem.readInt(u32, try self.read_n(4), Endian.little);
    }

    pub fn read_i32(self: *LittleEndianReader) Error!i32 {
        return std.mem.readInt(i32, try self.read_n(4), Endian.little);
    }

    pub fn read_f32(self: *LittleEndianReader) Error!f32 {
        const value = std.mem.readInt(i32, try self.read_n(4), Endian.little);

        return @bitCast(value);
    }

    // this is reading until a null byte
    pub fn read_str(self: *LittleEndianReader) Error![]u8 {
        var result = std.mem.zeroes([256]u8);

        var i:u32 = 0;
        while (i < 256) {
            const byte = try self.read_u8();
            if (byte == 0) {
                break;
            }

            result[i] = byte;
            i += 1;
        }

        return result[0..i];
    }

    pub fn read_encoded_u32(self: *LittleEndianReader) Error!u32 {
        var result: u32 = 0;

        var i = 0;

        comptime while (i < 35) |_| {
            const byte = try self.read_u8();
            result |= (byte & 0b01111111) << i;

            if (byte & 0b10000000 == 0) {
                break;
            }

            i += 7;
        };

        return result;
    }

    pub fn read_rectangle(self: *LittleEndianReader) Error!Rectangle {
        return Rectangle.read(self);
    }

    pub fn reset_bits(self: *LittleEndianReader) void {
        self.bit_position = 0;
    }

    pub fn read_ubits(self: *LittleEndianReader, n_bits: u8) Error!u32 {
        var val: u32 = 0;

        for(n_bits) |_| {
            if (self.bit_position == 0) {
                if (self.position >= self.buffer.len) {
                    // Handle end of buffer
                    return val; // Or handle error
                }
                self.bit_buffer = self.buffer[self.position];
                self.position += 1;
            }

            val = (val << 1) | ((self.bit_buffer >> 7 - self.bit_position) & 1);
            self.advance_bit();
        }

        return val;
    }

    pub fn advance_bit(self: *LittleEndianReader) void {
        if (self.bit_position == 7) {
            self.bit_position = 0;
        } else {
            self.bit_position += 1;
        }
    }


    pub fn read_sbits(self: *LittleEndianReader, num_bits: u5) Error!i32 {
        if (num_bits == 0) {
            return 0;
        }

        const val:i32 = @intCast(try self.read_ubits(num_bits));
        const sign_bit = val >> (num_bits - 1) & 1;

        var high_bits: i32 = 0;

        if (sign_bit == 1) {
            high_bits = -1;
        }

        if (num_bits == 64) {
            return val;
        }

        return high_bits << num_bits | val;
    }

    pub fn read_fbits(self: *LittleEndianReader, num_bits: u5) Error!f32 {
        return @bitCast(try self.read_sbits(num_bits));
    }

    pub fn read_fixed8(self: *LittleEndianReader) Error!Fixed8 {
        const val:f32 = @floatFromInt(try self.read_i16());
        return val / 256.0;
    }

    pub fn read_fixed16(self: *LittleEndianReader) Error!Fixed16 {
        const val:f32 = @floatFromInt(try self.read_i32());
        return val / 65536.0;
    }


    pub fn read_tag(self: *LittleEndianReader, allocator: std.mem.Allocator) anyerror!Tag{
        const tag_metadata = try self.read_tag_code_and_length();

        return try self.read_tag_with_code(tag_metadata.code, tag_metadata.length, allocator);
    }


    pub fn read_tag_with_code(self: *LittleEndianReader, tag_code:TagCode, length:u32, allocator: std.mem.Allocator) anyerror!Tag {
        const buffer = try self.read_bytes(length);
        var reader = LittleEndianReader.init(buffer);
        reader.set_swf_version(self.swf_version);

        defer {
            if(reader.position != length) {
                std.log.err("Tag {d} was not fully read", .{tag_code});
            }
        }

        return try Tag.read(tag_code, &reader, allocator, self.swf_version);
    }

    pub fn read_tag_code_and_length(self: *LittleEndianReader) Error!TagMetadata {
        const tag_code_and_length = try self.read_u16();
        const tag_code = tag_code_and_length >> 6;
        var tag_length:u32 = tag_code_and_length & 0b111111;

        if (tag_length == 0b111111) {
            // Extended tag.
            tag_length = try self.read_u32();
        }

        return TagMetadata{
            .code = TagCode.from_u16(tag_code),
            .length = tag_length,
        };
    }



    pub fn read_bit(self: *LittleEndianReader) Error!bool {
        if (self.bit_position == 0) {
            if (self.position >= self.buffer.len) {
                return Error.EOF;
            }
            self.bit_buffer = self.buffer[self.position];
            self.position += 1;
        }

        const bit = (self.bit_buffer >> 7 - self.bit_position) & 1;
        self.advance_bit();

        return bit == 1;
    }

    pub fn read_rgba(self: *LittleEndianReader) Error![]u8 {
        return try Color.read(self);
    }

    pub fn ignore(self: *LittleEndianReader, size: usize) Error!void {
        if (self.position + size > self.buffer.len) {
            return Error.EOF;
        }
        self.position += size;
    }

    pub fn bit_align(self: *LittleEndianReader) void {
        self.bit_last_position = 0;
    }

    pub fn current(self: *LittleEndianReader) []u8 {
        return self.buffer[self.position..];
    }

    pub fn len(self: *LittleEndianReader) usize {
        return self.buffer.len;
    }
};

test "read ubis" {
    var data = [_]u8{
        0b01100111,
    };

    var reader = LittleEndianReader.init(data[0..]);

    const result = try reader.read_ubits(2);
    try testing.expectEqual(
        0b01,
        result,
    );

    const result2 = try reader.read_ubits(4);
    try testing.expectEqual(
        0b1001,
        result2,
    );

    const result3 = try reader.read_ubits(2);
    try testing.expectEqual(0b11, result3);
}

test "read rectangle" {
    var data = [_]u8{ 0b00110_101, 0b100_01010, 0b0_101100_0, 0b10100_000 };

    var reader = LittleEndianReader.init(data[0..]);
    const result = try reader.read_rectangle();

    try testing.expectEqual(
        Rectangle{
            .x_min = Twips{ .value = -1 * 20 },
            .y_min = Twips{ .value = -1 * 20 },
            .x_max = Twips{ .value = 1 * 20 },
            .y_max = Twips{ .value = 1 * 20 },
        },
        result,
    );
}

test "read fixed8 bits" {
    var data = [8]u8{
        0b00000000, 0b00000000,
        0b00000000, 0b00000001,
        0b10000000, 0b00000110,
        0b01000000, 0b11101011
    };

    var reader = LittleEndianReader.init(data[0..]);

    const result = try reader.read_fixed8();
    const result2 = try reader.read_fixed8();
    const result3 = try reader.read_fixed8();
    const result4 = try reader.read_fixed8();

    try testing.expectEqual(
        0,
        result,
    );

    try testing.expectEqual(
        1,
        result2,
    );

    try testing.expectEqual(
        6.5e0,
        result3,
    );

    try testing.expectEqual(
        -20.75,
        result4,
    );
}