const std = @import("std");
const mem = std.mem;
const Endian = std.builtin.Endian;
const testing = std.testing;

pub const Error = error{
    EOF,
};

const Rectangle = struct {
    x_min: Twips,
    x_max: Twips,
    y_min: Twips,
    y_max: Twips,
};

pub const TWIPS_PER_PIXEL: i32 = 20;
const Twips = struct {
    value: i32,

    pub fn to_pixels(self: Twips) f32 {
        return f32(self.value) / TWIPS_PER_PIXEL;
    }
};

pub const LittleEndianReader = struct {
    buffer: []u8,
    position: usize,

    bit_buffer: u8,
    bit_position: u3 = 0,
    bit_last_position: usize,

    pub fn init(buffer: []u8) LittleEndianReader {
        return LittleEndianReader{
            .buffer = buffer,
            .position = 0,
            .bit_buffer = 0,
            .bit_position = 0,
            .bit_last_position = 0,
        };
    }

    pub fn bits(self: *LittleEndianReader) u8 {
        return self.bit_buffer;
    }

    pub fn read_utf8(self: *LittleEndianReader, size: usize) []u8 {
        const result = self.buffer[self.position .. self.position + size];
        self.position += size;

        return result;
    }

    pub fn read_bytes(self: *LittleEndianReader, size: usize) [size]u8 {
        return self.read_utf8(size);
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
            return Error.EOF;
        }

        const result = self.buffer[self.position..][0..size];
        self.position += size;

        return result;
    }

    pub fn read_u8(self: *LittleEndianReader) u8 {
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

    pub fn read_rectangle(self: *LittleEndianReader) !Rectangle {
        const num_bits:u5 = @intCast(try self.read_ubits(5));

        const rect = Rectangle{
            .x_min = Twips { .value = self.read_sbits(num_bits) },
            .x_max = Twips { .value = self.read_sbits(num_bits) },
            .y_min = Twips { .value = self.read_sbits(num_bits) },
            .y_max = Twips { .value = self.read_sbits(num_bits) },
        };

        return rect;
    }

    pub fn read_ubits(self: *LittleEndianReader, n_bits: u8) !u32 {
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


    pub fn read_sbits(self: *LittleEndianReader, num_bits: u5) i32 {
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


    pub fn read_fixed8(self: *LittleEndianReader) !f32 {
        const val:f32 = @floatFromInt(try self.read_i16());
        return val / 256.0;
    }

    pub fn ignore(self: *LittleEndianReader, size: usize) void {
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