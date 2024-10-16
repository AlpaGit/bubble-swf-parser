const std = @import("std");
const io = @import("io.zig");
const logger = @import("logger.zig");
const ArrayList = std.ArrayList;
const Renderer = @import("renderer.zig").Renderer;
const tags = @import("tags.zig");

pub const Rectangle = io.Rectangle;
const LittleEndianReader = io.LittleEndianReader;

const Compression = enum(u8) {
    UNCOMPRESSED = 'F',
    ZLIB = 'C',
    LZMA = 'Z',
};

const SwfHeader = struct {
    compression: Compression,
    version: u8,
    stage_size: Rectangle,
    frame_rate: f32,
    num_frames: i16,
};

pub const SwfFile = struct {
    header: SwfHeader,
    file_attributes: tags.FileAttributes,
    background_color: tags.Color,
    tags: []io.Tag,
};

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

    const compression: Compression = @enumFromInt(try reader.read_u8());
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
            n_read = try lzma_stream.reader().readAll(decompressed_stream);

            // We can deinit it right after reading it
            lzma_stream.deinit();
        },
    }

    if (n_read != uncompressed_length - 8) {
        logger.err(@src(), "Failed to decompress the file.", .{});
        return error.DecompressionError;
    }

    try read_swf_uncompressed(compression, version, decompressed_stream);
}


pub fn read_swf_uncompressed(compression: Compression, version: u8, decompressed_stream:[]u8) !void {
    // We make a stream of the decompressed data
    var reader = LittleEndianReader.init(decompressed_stream);

    logger.debug(@src(), "Decompressed {s}{d} bytes", .{ logger.Yellow, reader.buffer.len });
    logger.debug(@src(), "Reading SWF tags of decompressed_stream[0]: {s}{d}", .{ logger.Yellow, decompressed_stream[0] });

    const stage_size = try reader.read_rectangle();
    const frame_rate = try reader.read_fixed8();
    const num_frames = try reader.read_i16();


    logger.debug(@src(), "Rectangle: {s}{}", .{ logger.Yellow, stage_size });
    logger.debug(@src(), "Frame rate: {s}{d}", .{ logger.Yellow, frame_rate });
    logger.debug(@src(), "Number of frames: {s}{d}", .{ logger.Yellow, num_frames });

    const header = SwfHeader{
        .compression = compression,
        .version = version,
        .stage_size = stage_size,
        .frame_rate = frame_rate,
        .num_frames = num_frames,
    };

    var arena_allocator = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena_allocator.deinit();

    const allocator = arena_allocator.allocator();

    logger.debug(@src(), "SWF Header: {}", .{ header });

    reader.set_swf_version(version);

    // Parse the first two tags, searching for the FileAttributes and SetBackgroundColor tags.
    // This metadata is useful, so we want to return it along with the header.
    // In SWF8+, FileAttributes should be the first tag in the SWF.
    // FileAttributes anywhere else in the SWF are ignored.
    const file_attribute_tag = try reader.read_tag(allocator);

    if (file_attribute_tag != io.TagCode.FileAttributes) {
        logger.err(@src(), "First tag is not FileAttributes: {}", .{file_attribute_tag});
        return error.InvalidTag;
    }

    // In most SWFs, SetBackgroundColor will be the second or third tag after FileAttributes + Metadata.
    // It's possible for the SetBackgroundColor tag to be missing or appear later in wacky SWFs, so let's
    // return `None` in this case.
    var set_background_tag:io.Tag = undefined;

    for(0..2) |_| {
        set_background_tag = try reader.read_tag(allocator);

        if (set_background_tag == io.TagCode.SetBackgroundColor) {
            break;
        }
    }

    if(set_background_tag != io.TagCode.SetBackgroundColor) {
        logger.err(@src(), "SetBackgroundColor tag not found", .{});
        return error.InvalidTag;
    }

    logger.debug(@src(), "FileAttributes: {}", .{ file_attribute_tag });
    logger.debug(@src(), "SetBackgroundColor: {}", .{ set_background_tag });

    var tags_list:ArrayList(io.Tag) = ArrayList(io.Tag).init(allocator);

    // Read all the tags
    while (reader.position < reader.len()) {
        const tag = try reader.read_tag(allocator);
        try tags_list.append(tag);

        if (tag == io.TagCode.End) {
            logger.debug(@src(), "End tag found, stopping {}", .{tag});
            break;
        }
    }

    var swf_file = SwfFile{
        .header = header,
        .file_attributes = file_attribute_tag.FileAttributes,
        .background_color = set_background_tag.SetBackgroundColor,
        .tags = tags_list.items,
    };

    var renderer = Renderer.init(&swf_file);
    try renderer.render();
}


pub fn read_version(reader: *LittleEndianReader) !u8 {
    const version = try reader.read_u8();
    logger.debug(@src(), "SWF version: {s}{d}", .{ logger.Yellow, version });

    return version;
}

pub fn read_uncompressed_length(reader: *LittleEndianReader) !u32 {
    const length = try reader.read_u32();
    logger.debug(@src(), "Uncompressed File length: {s}{d}", .{ logger.Yellow, length });

    return length;
}








