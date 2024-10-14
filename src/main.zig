const std = @import("std");
const LittleEndianReader = @import("io.zig").LittleEndianReader;
const logger = @import("logger.zig");
const BitReader = std.io.BitReader;


const Compression = enum(u8) {
    UNCOMPRESSED = 'F',
    ZLIB = 'C',
    LZMA = 'Z',
};

const FixedBufferStreamReader = std.io.Reader(
    *std.io.FixedBufferStream([]u8),
    std.io.FixedBufferStream([]u8).ReadError,
    std.io.FixedBufferStream([]u8).read,
);

const MemoryBitReader = std.io.BitReader(
    std.builtin.Endian.big,
    FixedBufferStreamReader,
);

pub fn main() !void {
    //var argsIterator = try std.process.ArgIterator.initWithAllocator(allocator);
    //defer argsIterator.deinit();

    // skip executable name
    //_ = argsIterator.next();
    //const swf_path = argsIterator.next() orelse {
    //    return logger.info("Usage: bubble-swf-parser <swf-file>\n", .{});
    //};
    const swf_path = "./assets/test.swf";

    logger.info(@src(), "Parsing SWF file: {s}{s}", .{ logger.Yellow, swf_path });

    const buffer = try read_file(swf_path);

    var reader = LittleEndianReader.init(buffer);
    try read_swf_file(&reader);
}

pub fn read_file(file_path: []const u8) ![]u8 {
    defer logger.info(@src(), "Finished reading the file.", .{});

    const file = try std.fs.cwd().openFile(file_path, std.fs.File.OpenFlags{ .mode = std.fs.File.OpenMode.read_only });
    defer file.close();

    const file_metadata = try file.metadata();
    const file_len = file_metadata.size();

    const buffer = try std.heap.c_allocator.alloc(u8, file_len);
    const read_result = try file.read(buffer);

    if (read_result != file_len) {
        logger.info(@src(), "Failed to read the file.", .{});
        std.heap.c_allocator.free(buffer);
        return error.FileReadError;
    }

    return buffer;
}

pub fn read_swf_file(reader: *LittleEndianReader) !void {
    // Now directly operate on `buffer`
    if (reader.len() < 3) {
        return error.InsufficientData;
    }

    const compression: Compression = @enumFromInt(reader.read_u8());
    // always 'WS' for SWF files
    _ = try reader.read_u16();
    const version = try read_version(reader);
    const uncompressed_length = try reader.read_u32();

    // Check whether the SWF version is 0.
    // Note that the behavior should actually vary, depending on the player version:
    // - Flash Player 9 and later bail out (the behavior we implement).
    // - Flash Player 8 loops through all the frames, without running any AS code.
    // - Flash Player 7 and older don't fail and use the player version instead: a
    // function like `getSWFVersion()` in AVM1 will then return the player version.
    if (version == 0) {
        logger.err(@src(), "Invalid SWF version: 0.", .{});
        return error.InvalidVersion;
    }

    logger.debug(@src(), "Compression: {s}{any}", .{ logger.Yellow, compression });
    logger.debug(@src(), "Uncompressed File length: {s}{d}", .{ logger.Yellow, uncompressed_length });

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();

    const compressed_data = try reader.read_all();
    var compressed_stream = std.io.fixedBufferStream(compressed_data);
    const decompressed_stream = try allocator.alloc(u8, uncompressed_length);
    var n_read: usize = 0;

    switch (compression) {
        Compression.UNCOMPRESSED => {},
        Compression.ZLIB => {
            if (version < 6) {
                logger.warning(@src(), "Zlib compressed SWF is version {d} but minimum version is 6", .{version});
            }

            var zlib_stream = std.compress.zlib.decompressor(compressed_stream.reader());
            n_read = try zlib_stream.reader().readAll(decompressed_stream);
        },
        Compression.LZMA => {
            var lzma_stream = try std.compress.lzma.decompress(allocator, compressed_stream.reader());
            defer lzma_stream.deinit();
            n_read = try lzma_stream.reader().readAll(decompressed_stream);
        },
    }

    if (n_read != uncompressed_length - 8) {
        logger.err(@src(), "Failed to decompress the file.", .{});
        return error.DecompressionError;
    }

    // We make a stream of the decompressed data
    var reader_decompressed = LittleEndianReader.init(decompressed_stream);

    logger.debug(@src(), "Decompressed {s}{d} bytes", .{ logger.Yellow, n_read });
    logger.debug(@src(), "Reading SWF tags of decompressed_stream[0]: {s}{d}", .{ logger.Yellow, decompressed_stream[0] });
    const stage_size = try reader_decompressed.read_rectangle();
    logger.debug(@src(), "Rectangle: {s}{}", .{ logger.Yellow, stage_size });

    const frame_rate = try reader_decompressed.read_fixed8();

    logger.debug(@src(), "Frame rate: {s}{d}", .{ logger.Yellow, frame_rate });
}

pub fn read_version(reader: *LittleEndianReader) !u8 {
    const version = reader.read_u8();
    logger.debug(@src(), "SWF version: {s}{d}", .{ logger.Yellow, version });

    return version;
}

pub fn read_uncompressed_length(reader: *LittleEndianReader) !u32 {
    const length = reader.read_u32();
    logger.debug(@src(), "Uncompressed File length: {s}{d}", .{ logger.Yellow, length });

    return length;
}



