const io = @import("io.zig");
const Matrix = @import("matrix.zig").Matrix;
const std = @import("std");

const LittleEndianReader = io.LittleEndianReader;
const ArrayList = std.ArrayList;
const Fixed8 = io.Fixed8;
const Fixed16 = io.Fixed16;

pub const TagError = error{
    InvalidData,
};

pub const TagMetadata = struct {
    code: TagCode,
    length: u32,
};

pub const TagCode = enum(u32) {
    End = 0,
    ShowFrame = 1,
    DefineShape = 2,

    PlaceObject = 4,
    RemoveObject = 5,
    DefineBits = 6,
    DefineButton = 7,
    JpegTables = 8,
    SetBackgroundColor = 9,
    DefineFont = 10,
    DefineText = 11,
    DoAction = 12,
    DefineFontInfo = 13,
    DefineSound = 14,
    StartSound = 15,

    DefineButtonSound = 17,
    SoundStreamHead = 18,
    SoundStreamBlock = 19,
    DefineBitsLossless = 20,
    DefineBitsJpeg2 = 21,
    DefineShape2 = 22,
    DefineButtonCxform = 23,
    Protect = 24,

    PlaceObject2 = 26,

    RemoveObject2 = 28,

    DefineShape3 = 32,
    DefineText2 = 33,
    DefineButton2 = 34,
    DefineBitsJpeg3 = 35,
    DefineBitsLossless2 = 36,
    DefineEditText = 37,

    DefineSprite = 39,
    NameCharacter = 40,
    ProductInfo = 41,

    FrameLabel = 43,

    SoundStreamHead2 = 45,
    DefineMorphShape = 46,

    DefineFont2 = 48,

    ExportAssets = 56,
    ImportAssets = 57,
    EnableDebugger = 58,
    DoInitAction = 59,
    DefineVideoStream = 60,
    VideoFrame = 61,
    DefineFontInfo2 = 62,

    DebugId = 63,
    EnableDebugger2 = 64,
    ScriptLimits = 65,
    SetTabIndex = 66,

    FileAttributes = 69,

    PlaceObject3 = 70,
    ImportAssets2 = 71,
    DoAbc = 72,
    DefineFontAlignZones = 73,
    CsmTextSettings = 74,
    DefineFont3 = 75,
    SymbolClass = 76,
    Metadata = 77,
    DefineScalingGrid = 78,

    DoAbc2 = 82,
    DefineShape4 = 83,
    DefineMorphShape2 = 84,

    DefineSceneAndFrameLabelData = 86,
    DefineBinaryData = 87,
    DefineFontName = 88,
    StartSound2 = 89,
    DefineBitsJpeg4 = 90,
    DefineFont4 = 91,

    EnableTelemetry = 93,
    PlaceObject4 = 94,
    Undefined = 0xFFFF_FFFF,
    _,

    pub fn from_u16(tag_code:u16) TagCode {
        return @enumFromInt(tag_code);
    }
};

pub fn Point(comptime T: type) type {
    return struct {
        const Self = @This();

        x: T,
        y: T,

        pub fn debug(self: Self) void {
            @import("std").debug.print("{s}({d}, {d})\n", .{ @typeName(T), self.x, self.y });
        }
    };
}

pub fn PointDelta(comptime T: type) type {
    return struct {
        dx: T,
        dy: T,
    };
}

pub const Color = struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8,

    pub fn to_hex(self: Color) u32 {
        return (@as(u32, self.a) << 24) | (@as(u32, self.r) << 16) | (@as(u32, self.g) << 8) | @as(u32, self.b);
    }

    pub fn read_no_alpha(reader: *LittleEndianReader) !Color {
        return Color {
            .r = try reader.read_u8(),
            .g = try reader.read_u8(),
            .b = try reader.read_u8(),
            .a = 0xFF,
        };
    }

    pub fn read(reader: *LittleEndianReader) !Color {
        return Color {
            .r = try reader.read_u8(),
            .g = try reader.read_u8(),
            .b = try reader.read_u8(),
            .a = try reader.read_u8(),
        };
    }

    pub fn Black() Color {
        return Color {
            .r = 0,
            .g = 0,
            .b = 0,
            .a = 0xFF,
        };
    }


};

// ColorTransform
pub const ColorTransform = struct {
    r_multiply: Fixed8,
    g_multiply: Fixed8,
    b_multiply: Fixed8,
    a_multiply: Fixed8,
    r_add: i16,
    g_add: i16,
    b_add: i16,
    a_add: i16,

    pub fn read(reader: *LittleEndianReader, has_alpha: bool) !ColorTransform {
        const has_add = try reader.read_bit();
        const has_mult = try reader.read_bit();
        const num_bits:u5 = @intCast(try reader.read_ubits(4));

        var color_transformation = ColorTransform.identity();
        if (has_mult) {
            color_transformation.r_multiply = try reader.read_fixed8();
            color_transformation.g_multiply = try reader.read_fixed8();
            color_transformation.b_multiply = try reader.read_fixed8();

            if(has_alpha) {
                color_transformation.a_multiply = try reader.read_fixed8();
            }
        }

        if (has_add) {
            color_transformation.r_add = @intCast(try reader.read_sbits(num_bits));
            color_transformation.g_add = @intCast(try reader.read_sbits(num_bits));
            color_transformation.b_add = @intCast(try reader.read_sbits(num_bits));

            if(has_alpha) {
                color_transformation.a_add = @intCast(try reader.read_sbits(num_bits));
            }
        }

        return color_transformation;
    }

    pub fn identity() ColorTransform {
        return ColorTransform {
            .r_multiply = 1.0,
            .g_multiply = 1.0,
            .b_multiply = 1.0,
            .a_multiply = 1.0,
            .r_add = 0,
            .g_add = 0,
            .b_add = 0,
            .a_add = 0,
        };
    }
};

pub const DropShadowFlags = struct {
    //1 << 7
    InnerShadow: bool = false,
    //1 << 6
    Knockout: bool = false,
    //1 << 5
    CompositeSource: bool = false,
    // 0b11111
    Passes: u5 = 0,

    pub fn read_from_u8(flags: u8) DropShadowFlags {
        return DropShadowFlags{
            .InnerShadow = flags & 1 << 7 != 0,
            .Knockout = flags & 1 << 6 != 0,
            .CompositeSource = flags & 1 << 5 != 0,
            .Passes = flags & 0b11111,
        };
    }
};

pub const DropShadow = struct {
    color: Color,
    blur_x: Fixed16,
    blur_y: Fixed16,
    angle: Fixed16,
    distance: Fixed16,
    strength: Fixed8,

    pub fn read(reader: *LittleEndianReader) !DropShadow {
        return DropShadow {
            .color = try Color.read(reader),
            .blur_x = try reader.read_fixed16(),
            .blur_y = try reader.read_fixed16(),
            .angle = try reader.read_fixed16(),
            .distance = try reader.read_fixed16(),
            .strength = try reader.read_fixed8(),

        };
    }
};

pub const BlurFlags = struct {
    // 0b11111 << 3
    Passes: u8 = 0,

    pub fn read_from_u8(flags: u8) BlurFlags {
        return BlurFlags{
            .Passes = flags >> 3,
        };
    }
};

pub const Blur = struct {
    blur_x: Fixed16,
    blur_y: Fixed16,
    flags: BlurFlags,

    pub fn read(reader: *LittleEndianReader) !Blur {
        const blur_x = try reader.read_fixed16();
        const blur_y = try reader.read_fixed16();
        const flags = try reader.read_u8();

        return Blur {
            .blur_x = blur_x,
            .blur_y = blur_y,
            .flags = BlurFlags.read_from_u8(flags),
        };
    }
};

pub const GlowFlags = struct {
    // 1 << 7
    InnerGlow: bool = false,
    // 1 << 6
    Knockout: bool = false,
    // 1 << 5
    CompositeSource: bool = false,
    // 0b11111
    Passes: u8 = 0,

    pub fn read_from_u8(flags: u8) GlowFlags {
        return GlowFlags{
            .InnerGlow = flags & 1 << 7 != 0,
            .Knockout = flags & 1 << 6 != 0,
            .CompositeSource = flags & 1 << 5 != 0,
            .Passes = flags & 0b11111,
        };
    }
};

pub const Glow = struct {
    color: Color,
    blur_x: Fixed16,
    blur_y: Fixed16,
    strength: Fixed8,
    flags: GlowFlags,

    pub fn read(reader: *LittleEndianReader) !Glow {
        const color = try Color.read(reader);
        const blur_x = try reader.read_fixed16();
        const blur_y = try reader.read_fixed16();
        const strength = try reader.read_fixed8();
        const flags = try reader.read_u8();

        return Glow {
            .color = color,
            .blur_x = blur_x,
            .blur_y = blur_y,
            .strength = strength,
            .flags = GlowFlags.read_from_u8(flags),
        };
    }
};

pub const BevelFlags = struct {
    // 1 << 7
    InnerBevel: bool = false,
    // 1 << 6
    Knockout: bool = false,
    // 1 << 5
    CompositeSource: bool = false,
    //1 << 4
    OnTop: bool = false,
    // 0b11111
    Passes: u8 = 0,

    pub fn read_from_u8(flags: u8) BevelFlags {
        return BevelFlags{
            .InnerBevel = flags & 1 << 7 != 0,
            .Knockout = flags & 1 << 6 != 0,
            .CompositeSource = flags & 1 << 5 != 0,
            .OnTop = flags & 1 << 4 != 0,
            .Passes = flags & 0b1111,
        };
    }
};

pub const Bevel = struct {
    highlight_color: Color,
    shadow_color: Color,
    blur_x: Fixed16,
    blur_y: Fixed16,
    angle: Fixed16,
    distance: Fixed16,
    strength: Fixed8,
    flags: BevelFlags,

    pub fn read(reader: *LittleEndianReader) !Bevel {
        const highlight_color = try Color.read(reader);
        const shadow_color = try Color.read(reader);
        const blur_x = try reader.read_fixed16();
        const blur_y = try reader.read_fixed16();
        const angle = try reader.read_fixed16();
        const distance = try reader.read_fixed16();
        const strength = try reader.read_fixed8();
        const flags = try reader.read_u8();

        return Bevel {
            .highlight_color = highlight_color,
            .shadow_color = shadow_color,
            .blur_x = blur_x,
            .blur_y = blur_y,
            .angle = angle,
            .distance = distance,
            .strength = strength,
            .flags = BevelFlags.read_from_u8(flags),
        };
    }
};

pub const GradienGlowFlags = struct {
    // 1 << 7
    InnerShadow: bool = false,
    // 1 << 6
    Knockout: bool = false,
    // 1 << 5
    CompositeSource: bool = false,
    // 1 << 4
    OnTop: bool = false,
    // 0b1111
    Passes: u8 = 0,

    pub fn read_from_u8(flags: u8) GradienGlowFlags {
        return GradienGlowFlags{
            .InnerShadow = flags & 1 << 7 != 0,
            .Knockout = flags & 1 << 6 != 0,
            .CompositeSource = flags & 1 << 5 != 0,
            .OnTop = flags & 1 << 4 != 0,
            .Passes = flags & 0b1111,
        };
    }
};

pub const GradienGlow = struct {
    colors:[]Color,
    blur_x: Fixed16,
    blur_y: Fixed16,
    angle: Fixed16,
    distance: Fixed16,
    strength: Fixed8,
    flags: GradienGlowFlags,

    pub fn read(reader: *LittleEndianReader, allocator: std.mem.Allocator) !GradienGlow {
        const num_colors = try reader.read_u8();
        var colors: ArrayList(Color) = ArrayList(Color).init(allocator);
        for(0..num_colors) |_| {
            const color = try Color.read(reader);
            try colors.append(color);
        }

        const blur_x = try reader.read_fixed16();
        const blur_y = try reader.read_fixed16();
        const angle = try reader.read_fixed16();
        const distance = try reader.read_fixed16();
        const strength = try reader.read_fixed8();
        const flags = try reader.read_u8();

        return GradienGlow {
            .colors = colors.items,
            .blur_x = blur_x,
            .blur_y = blur_y,
            .angle = angle,
            .distance = distance,
            .strength = strength,
            .flags = GradienGlowFlags.read_from_u8(flags),
        };
    }
};


pub const ConvolutionFlags = struct {
    // 1 << 1
    Clamp: bool = false,
    // 1 << 0
    PreserveAlpha: bool = false,

    pub fn read_from_u8(flags: u8) ConvolutionFlags {
        return ConvolutionFlags{
            .Clamp = flags & 1 << 1 != 0,
            .PreserveAlpha = flags & 1 << 0 != 0,
        };
    }
};

pub const Convolution = struct {
    num_matrix_cols: u8,
    num_matrix_rows: u8,
    divisor: f32,
    bias: f32,
    matrix: []f32,
    default_color: Color,
    flags: ConvolutionFlags,

    pub fn read(reader: *LittleEndianReader, allocator: std.mem.Allocator) !Convolution {
        const num_matrix_cols = try reader.read_u8();
        const num_matrix_rows = try reader.read_u8();
        const divisor = try reader.read_f32();
        const bias = try reader.read_f32();

        const matrix_size = num_matrix_cols * num_matrix_rows;
        var matrixes:ArrayList(f32) = ArrayList(f32).init(allocator);
        for(0..matrix_size) |_| {
            const value = try reader.read_f32();
            try matrixes.append(value);
        }

        const default_color = try Color.read(reader);
        const flags = try reader.read_u8();

        return Convolution {
            .num_matrix_cols = num_matrix_cols,
            .num_matrix_rows = num_matrix_rows,
            .divisor = divisor,
            .bias = bias,
            .matrix = matrixes.items,
            .default_color = default_color,
            .flags = ConvolutionFlags.read_from_u8(flags),
        };
    }
};

pub const ColorMatrix = struct {
    matrix: [20]f32,

    pub fn read(reader: *LittleEndianReader) !ColorMatrix {
        var matrix:[20]f32 = undefined;
        for(0..20) |i| {
            const value = try reader.read_f32();
            matrix[i] = value;
        }

        return ColorMatrix {
            .matrix = matrix,
        };
    }
};

pub const GradientBevel = GradienGlow;

// Filter
pub const Filter = union{
    DropShadow: DropShadow,
    Blur: Blur,
    Glow: Glow,
    Bevel: Bevel,
    GradienGlow: GradienGlow,
    Convolution: Convolution,
    ColorMatrix: ColorMatrix,
    GradientBevel: GradientBevel,

    pub fn read(reader: *LittleEndianReader, allocator: std.mem.Allocator) !Filter {
        const filter_id = try reader.read_u8();
        switch (filter_id) {
            0 => return Filter{
                .DropShadow = try DropShadow.read(reader),
            },
            1 => return Filter{
                .Blur = try Blur.read(reader),
            },
            2 => return Filter{
                .Glow = try Glow.read(reader),
            },
            3 => return Filter{
                .Bevel = try Bevel.read(reader),
            },
            4 => return Filter{
                .GradienGlow = try GradienGlow.read(reader, allocator),
            },
            5 => return Filter{
                .Convolution = try Convolution.read(reader, allocator),
            },
            6 => return Filter{
                .ColorMatrix = try ColorMatrix.read(reader),
            },
            7 => return Filter{
                .GradientBevel = try GradientBevel.read(reader, allocator),
            },
            else => unreachable
        }
    }
};

pub const BlendMode = enum(u8) {
    Normal = 0,
    Layer = 2,
    Multiply = 3,
    Screen = 4,
    Lighten = 5,
    Darken = 6,
    Difference = 7,
    Add = 8,
    Subtract = 9,
    Invert = 10,
    Alpha = 11,
    Erase = 12,
    Overlay = 13,
    HardLight = 14,

    pub fn from_u8(value: u8) BlendMode {
        return @enumFromInt(value);
    }
};


// ButtonState
pub const ButtonState = struct {
    // 1 << 0
    Up: bool = false,
    // 1 << 1
    Over: bool = false,
    // 1 << 2
    Down: bool = false,
    // 1 << 3
    HitTest: bool = false,

    pub fn read_from_u8(flags: u8) ButtonState {
        return ButtonState{
            .Up = flags & 1 << 0 != 0,
            .Over = flags & 1 << 1 != 0,
            .Down = flags & 1 << 2 != 0,
            .HitTest = flags & 1 << 3 != 0,
        };
    }
};

// ButtonRecord
pub const ButtonRecord = struct {
    states: ButtonState,
    id: u16,
    depth: u16,
    matrix: Matrix,
    color_transform: ColorTransform,
    filters: []Filter,
    blend_mode: BlendMode,

    pub fn read(reader: *LittleEndianReader, version: u8, allocator: std.mem.Allocator) !?ButtonRecord {
        const flags = try reader.read_u8();

        if (flags == 0) {
            return null;
        }

        const states:ButtonState = ButtonState.read_from_u8(flags);
        const id = try reader.read_u16();
        const depth = try reader.read_u16();
        const matrix = try Matrix.read(reader);

        var color_transform = ColorTransform.identity();
        if (version >= 2) {
            color_transform = try ColorTransform.read(reader, true);
        }

        var filters: ArrayList(Filter) = ArrayList(Filter).init(allocator);
        if((flags & 0b1_0000) != 0) {
            const num_filters = try reader.read_u8();
            for(0..num_filters) |_| {
                const filter = try Filter.read(reader, allocator);
                try filters.append(filter);
            }
        }

        var blend_mode = BlendMode.Normal;

        if((flags & 0b10_0000) != 0){
            blend_mode = @enumFromInt(try reader.read_u8());
        }

        return ButtonRecord {
            .states = states,
            .id = id,
            .depth = depth,
            .matrix = matrix,
            .color_transform = color_transform,
            .filters = filters.items,
            .blend_mode = blend_mode,
        };
    }

    pub fn read_button_records(reader: *LittleEndianReader, version: u8, allocator: std.mem.Allocator) ![]ButtonRecord {
        var button_records: ArrayList(ButtonRecord) = ArrayList(ButtonRecord).init(allocator);
        while (true) {
            const record = try ButtonRecord.read(reader, version, allocator);
            if (record == null) {
                break;
            }
            try button_records.append(record.?);
        }
        return button_records.items;
    }
};

// ButtonActionCondition
pub const ButtonActionCondition = struct {
    // 1 << 0
    IdleToOverUp: bool = false,
    // 1 << 1
    OverUpToIdle: bool = false,
    // 1 << 2
    OverUpToOverDown: bool = false,
    // 1 << 3
    OverDownToOverUp: bool = false,
    // 1 << 4
    OverDownToOutDown: bool = false,
    // 1 << 5
    OutDownToOverDown: bool = false,
    // 1 << 6
    OutDownToIdle: bool = false,
    // 1 << 7
    IdleToOverDown: bool = false,
    // 1 << 8
    OverDownToIdle: bool = false,
    // 0b1111111 << 9
    KeyPress: u16 = 0,

    pub fn read_from_u16(flags: u16) ButtonActionCondition {
        return ButtonActionCondition{
            .IdleToOverUp = flags & 1 << 0 != 0,
            .OverUpToIdle = flags & 1 << 1 != 0,
            .OverUpToOverDown = flags & 1 << 2 != 0,
            .OverDownToOverUp = flags & 1 << 3 != 0,
            .OverDownToOutDown = flags & 1 << 4 != 0,
            .OutDownToOverDown = flags & 1 << 5 != 0,
            .OutDownToIdle = flags & 1 << 6 != 0,
            .IdleToOverDown = flags & 1 << 7 != 0,
            .OverDownToIdle = flags & 1 << 8 != 0,
            // we only care about the first 7 bits
            .KeyPress = @shrExact(flags, 9),
        };
    }
};

pub const ButtonActionResult = struct {
    button_action: ButtonAction,
    has_more: bool,
};

// ButtonAction
pub const ButtonAction = struct {
    conditions: ButtonActionCondition,
    action_data: []u8,

    pub fn read(reader: *LittleEndianReader) !ButtonActionResult {
        const length = try reader.read_u16();
        const flags = try reader.read_u16();

        const conditions:ButtonActionCondition = ButtonActionCondition.read_from_u16(flags);
        var action_data:[]u8 = undefined;

        if(length >= 4){
            action_data = try reader.read_bytes(length - 4);
        }
        else if(length == 0){
            // Last action, read to end.
            action_data = try reader.read_all();
        } else{
            return error.InvalidButtonAction;
        }

        return ButtonActionResult{
            .button_action = ButtonAction {
                .conditions = conditions,
                .action_data = action_data,
            },
            .has_more = length != 0,
        };
    }
};

// DefineButton (7)
pub const DefineButton = struct {
    id: u16,
    // Button records
    records: []const ButtonRecord,
    // Button actions
    actions: []const ButtonAction,
    is_track_as_menu: bool = false,

    pub fn read_v1(reader: *LittleEndianReader, allocator: std.mem.Allocator) !DefineButton {
        const id = try reader.read_u16();
        const records = try ButtonRecord.read_button_records(reader, 1, allocator);
        const action_data = try reader.read_all();

        const actions:[1]ButtonAction = .{
            ButtonAction {
                .conditions = ButtonActionCondition { .OverDownToOverUp = true },
                .action_data = action_data,
            }
        };

        return DefineButton {
            .id = id,
            .records = records,
            .actions = &actions,
        };
    }

    pub fn read_v2(reader: *LittleEndianReader, allocator: std.mem.Allocator) !DefineButton {
        const id = try reader.read_u16();
        const flags = try reader.read_u8();
        const is_track_as_menu = (flags & 0b1) != 0;
        const action_offset = try reader.read_u16();

        const records = try ButtonRecord.read_button_records(reader, 2, allocator);
        var actions:ArrayList(ButtonAction) = ArrayList(ButtonAction).init(allocator);

        if (action_offset != 0) {
            while (true) {
                const action_result = try ButtonAction.read(reader);
                try actions.append(action_result.button_action);

                if (!action_result.has_more) {
                    break;
                }
            }
        }

        return DefineButton {
            .id = id,
            .records = records,
            .actions = actions.items,
            .is_track_as_menu = is_track_as_menu,
        };
    }
};

// DefineBits (6)
pub const DefineBits = struct {
    id: u16,
    // JPEG compressed image
    jpeg_data: []const u8,

    pub fn read(reader: *LittleEndianReader) !DefineBits {
        const id = try reader.read_u16();
        const data = try reader.read_all();
        return DefineBits {
            .id = id,
            .jpeg_data = data,
        };
    }
};

// DefineBitsJPEG2 (21)
// It differs from DefineBits in that it contains both the JPEG encoding table and the JPEG image data.
// This tag allows multiple JPEG images with differing encoding tables to be defined within a single SWF file.
pub const DefineBitsJpeg2 = struct {
    id: u16,
    // Compressed image data in either JPEG, PNG, or GIF89a format
    jpeg_data: []const u8,
    pub fn read(reader: *LittleEndianReader) !DefineBitsJpeg2 {
        const id = try reader.read_u16();
        const data = try reader.read_all();
        return DefineBitsJpeg2 {
            .id = id,
            .jpeg_data = data,
        };
    }
};

// DefineBitsJPEG3 (35) and DefineBitsJPEG4 (90)
// It extends DefineBitsJPEG2 by adding an alpha channel to the JPEG image.
pub const DefineBitsJpeg3 = struct {
    id: u16,
    // Parameter to be fed into the deblocking filter. The
    // parameter describes a relative strength of the
    // deblocking filter from 0-100% expressed in a normalized
    // 8.8 fixed point format.
    deblocking: Fixed8,
    // Compressed image data in either JPEG, PNG, or GIF89a format.
    jpeg_data: []const u8,
    // ZLIB compressed array of alpha data
    // One byte per pixel. Total
    // size after decompression must equal (width * height) of
    // JPEG image.
    alpha_data: []const u8,

    pub fn read(reader: *LittleEndianReader, version:u8) !DefineBitsJpeg3 {
        const id = try reader.read_u16();
        const data_size = try reader.read_u32();
        var deblocking:Fixed8 = 0;

        if (version >= 4) {
            deblocking = try reader.read_fixed8();
        }

        const jpeg_data = try reader.read_bytes(data_size);
        const alpha_data = try reader.read_all();

        return DefineBitsJpeg3 {
            .id = id,
            .deblocking = deblocking,
            .jpeg_data = jpeg_data,
            .alpha_data = alpha_data,
        };
    }
};

// DefineBinaryData (87)
pub const DefineBinaryData = struct {
    id: u16,
    data: []const u8,

    pub fn read(reader: *LittleEndianReader) !DefineBinaryData {
        const id = try reader.read_u16();
        // Reserved
        try reader.ignore(4);
        const data = try reader.read_all();
        return DefineBinaryData {
            .id = id,
            .data = data,
        };
    }
};

const TextGridFit = enum(u2) {
    None = 0,
    Pixel = 1,
    SubPixel = 2,
};

// CsmTextSettings (74)
pub const CsmTextSettings = struct {
    id: u16,
    use_advanced_rendering: bool,
    grid_fit: TextGridFit,
    thickness: f32,
    sharpness: f32,

    pub fn read(reader: *LittleEndianReader) !CsmTextSettings {
        const id = try reader.read_u16();
        const flags = try reader.read_u8();
        const thickness = try reader.read_f32();
        const sharpness = try reader.read_f32();
        // Reserved (0)
        try reader.ignore(1);

        return CsmTextSettings {
            .id = id,
            .use_advanced_rendering = flags & 0b01000000 != 0,
            .grid_fit = @enumFromInt((flags >> 3) & 0b11),
            .thickness = thickness,
            .sharpness = sharpness,
        };
    }
};

// FileAttributes (69)
pub const FileAttributes = struct {
    /// 1 << 6
    /// Whether this SWF requests hardware acceleration to blit to the screen.
    useDirectBlit: bool,
    /// 1 << 5
    /// Whether this SWF requests hardware acceleration for compositing.
    useGpu: bool,
    /// 1 << 4
    /// Whether this SWF contains XMP metadata in a Metadata tag.
    hasMetadata: bool,
    /// 1 << 3
    /// Whether this SWF uses ActionScript 3 (AVM2).
    isActionScript3: bool,
    /// 1 << 0
    /// Whether this SWF should be placed in the network sandbox when run locally.
    ///
    /// SWFs in the network sandbox can only access network resources, not local resources.
    /// SWFs in the local sandbox can only access local resources, not network resources.
    useNetworkSandbox: bool,

    pub fn read(reader: *LittleEndianReader) !FileAttributes {
        const flags = try reader.read_u32();

        return FileAttributes {
            .useDirectBlit = (flags & 1 << 6) != 0,
            .useGpu = (flags & 1 << 5) != 0,
            .hasMetadata = (flags & 1 << 4) != 0,
            .isActionScript3 = (flags & 1 << 3) != 0,
            .useNetworkSandbox = (flags & 1 << 0) != 0,
        };
    }
};

pub const FrameLabelData = struct {
    frame_num: u32,
    label: []u8,

    pub fn read(reader: *LittleEndianReader) !FrameLabelData {
        const frame_num = try reader.read_u32();
        const label = try reader.read_str();
        return FrameLabelData {
            .frame_num = frame_num,
            .label = label,
        };
    }
};

// DefineSceneAndFrameLabelData (86)
pub const DefineSceneAndFrameLabelData = struct {
    scenes: []FrameLabelData,
    frame_labels: []FrameLabelData,

    pub fn read(reader: *LittleEndianReader, allocator: std.mem.Allocator) !DefineSceneAndFrameLabelData {
        const scene_count = try reader.read_u8();
        var scenes: ArrayList(FrameLabelData) = ArrayList(FrameLabelData).init(allocator);
        for(0..scene_count) |_| {
            const scene = try FrameLabelData.read(reader);
            try scenes.append(scene);
        }

        const frame_label_count = try reader.read_u8();
        var frame_labels: ArrayList(FrameLabelData) = ArrayList(FrameLabelData).init(allocator);
        for(0..frame_label_count) |_| {
            const frame_label = try FrameLabelData.read(reader);
            try frame_labels.append(frame_label);
        }

        return DefineSceneAndFrameLabelData {
            .scenes = scenes.items,
            .frame_labels = frame_labels.items,
        };
    }
};

pub const Rectangle = struct {
    x_min: Twips,
    x_max: Twips,
    y_min: Twips,
    y_max: Twips,

    pub fn read(reader: *LittleEndianReader) !Rectangle {
        const num_bits:u5 = @intCast(try reader.read_ubits(5));
        defer reader.reset_bits();

        return Rectangle{
            .x_min = Twips { .value = try reader.read_sbits(num_bits) },
            .x_max = Twips { .value = try reader.read_sbits(num_bits) },
            .y_min = Twips { .value = try reader.read_sbits(num_bits) },
            .y_max = Twips { .value = try reader.read_sbits(num_bits) },
        };
    }

    pub fn clone(self: Rectangle) Rectangle {
        return Rectangle{
            .x_min = self.x_min,
            .x_max = self.x_max,
            .y_min = self.y_min,
            .y_max = self.y_max,
        };
    }

};

pub const TWIPS_PER_PIXEL: i32 = 20;

pub const Twips = struct {
    value: i32,

    pub fn to_pixels(self: Twips) i32 {
        return @divExact(self.value, TWIPS_PER_PIXEL);
    }

    pub fn to_pixels_u32(self: Twips) u32 {
        return @intCast(self.to_pixels());
    }

    pub fn to_pixels_f32(self: Twips) f32 {
        return @divExact(@as(f32, @floatFromInt(self.value)),  @as(f32, @floatFromInt(TWIPS_PER_PIXEL)));
    }
};

pub const GradientFlags = struct {
    num_record: u8,
    spread: GradientSpread,
    interpolation: GradientInterpolation,

    pub fn read(reader: *LittleEndianReader) !GradientFlags {
        const flags = try reader.read_u8();
        return GradientFlags {
            .num_record = flags & 0b1111,
            .spread = @enumFromInt((flags >> 4) & 0b11),
            .interpolation = @enumFromInt((flags >> 6) & 0b11),
        };
    }
};

pub const Gradient = struct {
    matrix: Matrix,
    spread: GradientSpread,
    interpolation: GradientInterpolation,
    records: []GradientRecord,

    pub fn read(reader: *LittleEndianReader, allocator: std.mem.Allocator, version: u8) !?Gradient {
        const matrix = try Matrix.read(reader);
        const flags = try GradientFlags.read(reader);

        if(flags.num_record == 0){
            return null;
        }

        var records:ArrayList(GradientRecord) = try ArrayList(GradientRecord).initCapacity(allocator, flags.num_record);
        for(0..flags.num_record) |_| {
            const ratio = try reader.read_u8();
            var color:Color = undefined;

            if(version >= 3){
                color = try Color.read(reader);
            }
            else{
                color = try Color.read_no_alpha(reader);
            }

            const record = GradientRecord{
                .ratio = ratio,
                .color = color,
            };

            try records.append(record);
        }

        return Gradient {
            .matrix = matrix,
            .spread = flags.spread,
            .interpolation = flags.interpolation,
            .records = records.items,
        };
    }
};



pub const GradientSpread = enum(u8) {
    Pad = 0,
    Reflect = 1,
    Repeat = 2,
};

pub const GradientInterpolation = enum(u8) {
    Normal = 0,
    LinearRGB = 1,
};

pub const GradientRecord = struct {
    ratio: u8,
    color: Color,
};

pub const FocalGradient = struct {
    gradient: Gradient,
    focal_point: Fixed8,
};

pub const BitmapFill = struct {
    bitmap_id: u16,
    matrix: Matrix,
    is_smoothed: bool,
    is_repeating: bool,

    pub fn read(reader: *LittleEndianReader, fill_style_type:u8, swf_version: u8) !BitmapFill {
        const bitmap_id = try reader.read_u16();
        const matrix = try Matrix.read(reader);

        const is_smoothed = swf_version >= 8 and (fill_style_type & 0b10) == 0;
        const is_repeating = (fill_style_type & 0b01) == 0;

        return BitmapFill {
            .bitmap_id = bitmap_id,
            .matrix = matrix,
            // Bitmap smoothing only occurs in SWF version 8+.
            .is_smoothed = is_smoothed,
            .is_repeating = is_repeating,
        };
    }
};

pub const FillStyle = union {
    Color: Color,
    LinearGradient: Gradient,
    RadialGradient: Gradient,
    FocalGradient: FocalGradient,
    Bitmap: BitmapFill,

    pub fn read(reader: *LittleEndianReader, allocator: std.mem.Allocator, version: u8, swf_version: u8) !FillStyle {
        const shape_type = try reader.read_u8();
        switch (shape_type) {
            0x00 => {
                if(version >= 3){
                    return FillStyle{
                        .Color = try Color.read(reader),
                    };
                } else {
                    return FillStyle{
                        .Color = try Color.read_no_alpha(reader),
                    };
                }
            },
            0x10 => {
                const gradient = try Gradient.read(reader, allocator, version);

                if(gradient != null) {
                    return FillStyle{
                        .LinearGradient = gradient.?,
                    };
                } else {
                    return FillStyle{
                        .Color = Color.Black()
                    };
                }
            },
            0x12 => {
                const gradient = try Gradient.read(reader, allocator, version);

                if(gradient != null){
                    return FillStyle{
                        .RadialGradient = gradient.?,
                    };
                } else {
                    return FillStyle{
                        .Color = Color.Black()
                    };
                }
            },
            0x13 => {
                // SWF19 says focal gradients are only allowed in SWFv8+ and DefineShape4,
                // but it works even in earlier tags (#2730).
                const gradient = try Gradient.read(reader, allocator, version);
                const focal_point = try reader.read_fixed8();

                if(gradient != null){
                    return FillStyle{
                        .FocalGradient = FocalGradient{
                            .gradient = gradient.?,
                            .focal_point = focal_point,
                        },
                    };
                } else {
                    return FillStyle{
                        .Color = Color.Black()
                    };
                }
            },
            0x40, 0x41, 0x42, 0x43 => return FillStyle{
                .Bitmap = try BitmapFill.read(reader, shape_type, swf_version),
            },
            else => unreachable,
        }
    }
};

pub const LineStyleFlags = struct {
    // First byte.
    // 1 << 0
    pixel_hinting: bool = false,
    // 1 << 1
    no_v_scale: bool = false,
    // 1 << 2
    no_h_scale: bool = false,
    // 1 << 3
    has_fill: bool = false,
    // 0b11 << 4
    join_style: u16 = 0,
    // 0b11 << 6
    start_cap_style: u16 = 0,

    // Second byte.
    // 0b11 << 8
    end_cap_style: u16 = 0,
    // 1 << 10
    no_close: bool = false,

    pub fn read_from_u16(flags: u16) LineStyleFlags {
        return LineStyleFlags{
            .pixel_hinting = flags & 1 << 0 != 0,
            .no_v_scale = flags & 1 << 1 != 0,
            .no_h_scale = flags & 1 << 2 != 0,
            .has_fill = flags & 1 << 3 != 0,
            .join_style = flags & 0b11 << 4,
            .start_cap_style = flags & 0b11 << 6,
            .end_cap_style = flags & 0b11 << 8,
            .no_close = flags & 1 << 10 != 0,
        };
    }
};

pub const LineStyle = struct {
    width: Twips = .{ .value = 0 },
    fill_style: FillStyle = FillStyle { .Color = Color.Black() },
    flags: LineStyleFlags = .{},
    miter_limit: Fixed8 = 0,


    pub fn read(reader: *LittleEndianReader, allocator: std.mem.Allocator, version: u8, swf_version: u8) !LineStyle {
        const width = Twips { .value = try reader.read_i16() };

        if (version < 4){
            // LineStyle1
            const color = if (version >= 3) try Color.read(reader) else try Color.read_no_alpha(reader);

            return LineStyle {
                .width = width,
                .fill_style = FillStyle {
                    .Color = color,
                }
            };
        } else {
            // LineStyle2 in DefineShape4
            var flags = LineStyleFlags.read_from_u16(try reader.read_u16());

            // Verify valid cap and join styles.
            if(flags.join_style != 0){
                std.log.warn("Invalid line join style", .{});
                flags.join_style = 0;
            }

            if(flags.start_cap_style != 0){
                std.log.warn("Invalid line start cap style", .{});
                flags.start_cap_style = 0;
            }

            if(flags.end_cap_style != 0){
                std.log.warn("Invalid line end cap style", .{});
                flags.end_cap_style = 0;
            }

            const miter_limit:Fixed8 = if(flags.join_style & 0b10 << 4 != 0) try reader.read_fixed8() else 0;
            var fill_style:FillStyle = undefined;

            if(flags.has_fill)
                fill_style = try FillStyle.read(reader, allocator, version, swf_version)
            else
                fill_style = FillStyle {
                    .Color = try Color.read(reader)
                };

            return LineStyle {
                .width = width,
                .fill_style = fill_style,
                .flags = flags,
                .miter_limit = miter_limit,
            };
        }
    }
};

pub const ShapeStylesResult = struct {
    shape_style: ShapeStyles,
    num_fill_bits: u8,
    num_line_bits: u8,
};

// ShapeStyles
pub const ShapeStyles = struct {
    fill_styles: []FillStyle,
    line_styles: []LineStyle,

    pub fn read(reader: *LittleEndianReader, allocator: std.mem.Allocator, version: u8, swf_version: u8) !ShapeStylesResult {
        const num_fill_styles_type = try reader.read_u8();
        var num_fill_styles:u16 = undefined;

        if(num_fill_styles_type == 0xFF and version >= 2){
            num_fill_styles = try reader.read_u16();
        }
        else{
            num_fill_styles = num_fill_styles_type;
        }

        var fill_styles: ArrayList(FillStyle) = ArrayList(FillStyle).init(allocator);
        for(0..num_fill_styles) |_| {
            const fill_style = try FillStyle.read(reader, allocator, version, swf_version);
            try fill_styles.append(fill_style);
        }

        const num_line_styles_type = try reader.read_u8();
        var num_line_styles:u16 = undefined;

        if(num_line_styles_type == 0xFF and version >= 2){
            // TODO: is this true for linestyles too? SWF19 says not.
            num_line_styles = try reader.read_u16();
        }
        else{
            num_line_styles = num_line_styles_type;
        }

        var line_styles: ArrayList(LineStyle) = ArrayList(LineStyle).init(allocator);
        for(0..num_line_styles) |_| {
            const line_style = try LineStyle.read(reader, allocator, version, swf_version);
            try line_styles.append(line_style);
        }

        const num_bits = try reader.read_u8();

        return ShapeStylesResult{
            .shape_style = ShapeStyles {
                .fill_styles = fill_styles.items,
                .line_styles = line_styles.items,
            },
            .num_fill_bits = num_bits >> 4,
            .num_line_bits = num_bits & 0b1111,
        };
    }
};

pub const ShapeContext = struct {
    swf_version: u8,
    shape_version: u8,
    num_fill_bits: u8,
    num_line_bits: u8,
};



pub const StyleChangeData = struct {
    move_to: ?Point(Twips),
    fill_style_0: ?u8,
    fill_style_1: ?u8,
    line_style: ?u8,
    new_styles: ?ShapeStyles,
};

pub const StraightEdge = struct {
    delta: PointDelta(Twips)
};

pub const CurvedEdge = struct {
    control_delta: PointDelta(Twips),
    anchor_delta: PointDelta(Twips),
};

pub const ShapeRecordFlags = struct {
    // 1 << 0
    move_to: bool,
    // 1 << 1
    fill_style_0: bool,
    // 1 << 2
    fill_style_1: bool,
    // 1 << 3
    line_style: bool,
    // 1 << 4
    new_styles: bool,

    pub fn read_from_u8(flags: u8) ShapeRecordFlags {
        return ShapeRecordFlags{
            .move_to = flags & 1 << 0 != 0,
            .fill_style_0 = flags & 1 << 1 != 0,
            .fill_style_1 = flags & 1 << 2 != 0,
            .line_style = flags & 1 << 3 != 0,
            .new_styles = flags & 1 << 4 != 0,
        };
    }

    pub fn is_empty(self: ShapeRecordFlags) bool {
        return !self.move_to and
               !self.fill_style_0 and
               !self.fill_style_1 and
               !self.line_style and
               !self.new_styles;
    }
};


pub const ShapeRecord = union(enum) {
    StyleChange: StyleChangeData,
    StraightEdge: StraightEdge,
    CurvedEdge: CurvedEdge,

    pub fn read(reader: *LittleEndianReader, context: *ShapeContext, allocator: std.mem.Allocator) !?ShapeRecord {
        const is_edge_record = try reader.read_bit();

        if(is_edge_record){
            return read_edge_record(reader);
        } else {
            return read_style_change_record(reader, context, allocator);
        }
    }

    pub fn read_edge_record(reader: *LittleEndianReader) !?ShapeRecord {
        const is_straight_edge = try reader.read_bit();
        const num_bits:u5 =  @intCast(try reader.read_ubits(4) + 2);
        
        if(is_straight_edge){
            // StraightEdge
            const is_axis_aligned = try reader.read_bit() != true;
            const is_vertical = is_axis_aligned and try reader.read_bit();
            const delta_x = Twips {
                .value = if(!is_axis_aligned or !is_vertical) try reader.read_sbits(num_bits) else 0
            };

            const delta_y = Twips {
                .value = if(!is_axis_aligned or is_vertical) try reader.read_sbits(num_bits) else 0
            };

            return ShapeRecord {
                .StraightEdge = StraightEdge {
                    .delta = PointDelta(Twips) {
                        .dx = delta_x,
                        .dy = delta_y,
                    },
                },
            };
        } else {
            // CurvedEdge
            const control_delta_x = Twips{.value = try reader.read_sbits(num_bits)};
            const control_delta_y = Twips{.value = try reader.read_sbits(num_bits)};
            const anchor_delta_x = Twips{.value = try reader.read_sbits(num_bits)};
            const anchor_delta_y = Twips{.value = try reader.read_sbits(num_bits)};

            return ShapeRecord {
                .CurvedEdge = CurvedEdge {
                    .control_delta = PointDelta(Twips) {
                        .dx = control_delta_x,
                        .dy = control_delta_y,
                    },
                    .anchor_delta = PointDelta(Twips) {
                        .dx = anchor_delta_x,
                        .dy = anchor_delta_y,
                    },
                },
            };
        }
    }

    pub fn read_style_change_record(reader: *LittleEndianReader, context: *ShapeContext, allocator: std.mem.Allocator) !? ShapeRecord {
        const flags_bits = try reader.read_ubits(5);
        const flags = ShapeRecordFlags.read_from_u8(@intCast(flags_bits));

        if(flags.is_empty()){
            return null;
        }

        // StyleChange
        const num_fill_bits = context.num_fill_bits;
        const num_line_bits = context.num_line_bits;

        var move_to:?Point(Twips) = null;
        var fill_style_0:?u8 = null;
        var fill_style_1:?u8 = null;
        var line_style:?u8 = null;
        var new_styles:?ShapeStyles = null;

        if(flags.move_to){
            const num_bits:u5 = @intCast(try reader.read_ubits(5));
            const move_x = try reader.read_sbits(num_bits);
            const move_y = try reader.read_sbits(num_bits);
            move_to = Point(Twips){
                .x = Twips{.value = move_x},
                .y = Twips{.value = move_y},
            };
        }

        if(flags.fill_style_0){
            fill_style_0 = @intCast(try reader.read_ubits(num_fill_bits));
        }

        if(flags.fill_style_1){
            fill_style_1 = @intCast(try reader.read_ubits(num_fill_bits));
        }

        if(flags.line_style){
            line_style =  @intCast(try reader.read_ubits(num_line_bits));
        }

        // The spec says that StyleChangeRecord can only occur in DefineShape2+,
        // but SWFs in the wild exist with them in DefineShape1 (generated by third party tools),
        // and these run correctly in the Flash Player.
        if(flags.new_styles){
            const new_styles_result = try ShapeStyles.read(reader, allocator, context.shape_version, context.swf_version);
            new_styles = new_styles_result.shape_style;
            context.num_fill_bits = new_styles_result.num_fill_bits;
            context.num_line_bits = new_styles_result.num_line_bits;
        }

        return ShapeRecord {
            .StyleChange = StyleChangeData {
                .move_to = move_to,
                .fill_style_0 = fill_style_0,
                .fill_style_1 = fill_style_1,
                .line_style = line_style,
                .new_styles = new_styles,
            },
        };
    }
};

pub const ShapeFlags = struct {
    // 1 << 0
    has_scaling_strokes: bool,
    // 1 << 1
    has_non_scaling_strokes: bool,
    // 1 << 2
    non_zero_winding_rules: bool,

    pub fn read_from_u8(flags: u8) ShapeFlags {
        return ShapeFlags{
            .has_scaling_strokes = flags & 1 << 0 != 0,
            .has_non_scaling_strokes = flags & 1 << 1 != 0,
            .non_zero_winding_rules = flags & 1 << 2 != 0,
        };
    }
};

// DefineShape4 (83)
pub const DefineShape = struct {
    version: u8,
    id: u16,
    shape_bounds: Rectangle,
    edge_bounds: Rectangle,
    flags: ShapeFlags,
    styles: ShapeStyles,
    shapes: []ShapeRecord,

    pub fn read(reader: *LittleEndianReader, allocator: std.mem.Allocator, version: u8, swf_version: u8) !DefineShape {
        const id = try reader.read_u16();
        const shape_bounds = try Rectangle.read(reader);

        var edge_bounds:Rectangle = undefined;
        var flags:ShapeFlags = undefined;

        if(version >= 4) {
            edge_bounds = try Rectangle.read(reader);
            flags = ShapeFlags.read_from_u8(try reader.read_u8());
        } else{
            edge_bounds = shape_bounds.clone();
            flags = ShapeFlags {
                .has_non_scaling_strokes = false,
                .has_scaling_strokes = true,
                .non_zero_winding_rules = false,
            };
        }

        const shape_style_result = try ShapeStyles.read(reader, allocator, version, swf_version);
        var records = ArrayList(ShapeRecord).init(allocator);
        var shape_context = ShapeContext {
            .swf_version = swf_version,
            .shape_version = version,
            .num_fill_bits = shape_style_result.num_fill_bits,
            .num_line_bits = shape_style_result.num_line_bits,
        };

        while(true){
            const record = try ShapeRecord.read(reader, &shape_context, allocator);
            if(record == null){
                break;
            }
            try records.append(record.?);
        }

        return DefineShape {
            .version = version,
            .id = id,
            .shape_bounds = shape_bounds,
            .edge_bounds = edge_bounds,
            .flags = flags,
            .styles = shape_style_result.shape_style,
            .shapes = records.items,
        };

    }
};

pub const DefineSprite = struct {
    id: u16,
    frame_count: i16,
    tags: []Tag,

    pub fn read(reader: *LittleEndianReader, allocator: std.mem.Allocator) anyerror!DefineSprite {
        const id = try reader.read_u16();
        const frame_count = try reader.read_i16();
        var control_tags:ArrayList(Tag) = ArrayList(Tag).init(allocator);

        while(true and !reader.eof()){
            const tag = try reader.read_tag(allocator);
            try control_tags.append(tag);
        }

        return DefineSprite {
            .id = id,
            .frame_count = frame_count,
            .tags = control_tags.items,
        };
    }
};


pub const PlaceObjectAction = union(enum) {
    Place: u16,
    Modify: bool,
    Replace: u16,
};

/// An event that can be attached to a MovieClip instance using an `onClipEvent` or `on` block.
pub const ClipEventFlag = struct {
    // 1 << 0
    load: bool,
    // 1 << 1
    enter_frame: bool,
    // 1 << 2
    unload: bool,
    // 1 << 3
    mouse_move: bool,
    // 1 << 4
    mouse_down: bool,
    // 1 << 5
    mouse_up: bool,
    // 1 << 6
    key_down: bool,
    // 1 << 7
    key_up: bool,

    // Added in SWF6, but not version-gated.
    // 1 << 8
    data: bool,
    // 1 << 9
    initialize: bool,
    // 1 << 10
    press: bool,
    // 1 << 11
    release: bool,
    // 1 << 12
    release_outside: bool,
    // 1 << 13
    roll_over: bool,
    // 1 << 14
    roll_out: bool,
    // 1 << 15
    drag_over: bool,
    // 1 << 16
    drag_out: bool,
    // 1 << 17
    key_press: bool,

    // Construct was only added in SWF7, but it's not version-gated;
    // Construct events will still fire in SWF6 in a v7+ player.
    // 1 << 18
    construct: bool,

    pub fn read_from_u32(flags:u32) ClipEventFlag {
        return ClipEventFlag{
            .load = flags & 1 << 0 != 0,
            .enter_frame = flags & 1 << 1 != 0,
            .unload = flags & 1 << 2 != 0,
            .mouse_move = flags & 1 << 3 != 0,
            .mouse_down = flags & 1 << 4 != 0,
            .mouse_up = flags & 1 << 5 != 0,
            .key_down = flags & 1 << 6 != 0,
            .key_up = flags & 1 << 7 != 0,
            .data = flags & 1 << 8 != 0,
            .initialize = flags & 1 << 9 != 0,
            .press = flags & 1 << 10 != 0,
            .release = flags & 1 << 11 != 0,
            .release_outside = flags & 1 << 12 != 0,
            .roll_over = flags & 1 << 13 != 0,
            .roll_out = flags & 1 << 14 != 0,
            .drag_over = flags & 1 << 15 != 0,
            .drag_out = flags & 1 << 16 != 0,
            .key_press = flags & 1 << 17 != 0,
            .construct = flags & 1 << 18 != 0,
        };
    }

    pub fn read_from_u16(flags:u16) ClipEventFlag {
        return ClipEventFlag{
            .load = flags & 1 << 0 != 0,
            .enter_frame = flags & 1 << 1 != 0,
            .unload = flags & 1 << 2 != 0,
            .mouse_move = flags & 1 << 3 != 0,
            .mouse_down = flags & 1 << 4 != 0,
            .mouse_up = flags & 1 << 5 != 0,
            .key_down = flags & 1 << 6 != 0,
            .key_up = flags & 1 << 7 != 0,
            .data = false,
            .initialize = false,
            .press = false,
            .release = false,
            .release_outside = false,
            .roll_over = false,
            .roll_out = false,
            .drag_over = false,
            .drag_out = false,
            .key_press = false,
            .construct = false,
        };
    }

    pub fn is_empty(self: ClipEventFlag) bool {
        return !self.load and
               !self.enter_frame and
               !self.unload and
               !self.mouse_move and
               !self.mouse_down and
               !self.mouse_up and
               !self.key_down and
               !self.key_up and
               !self.data and
               !self.initialize and
               !self.press and
               !self.release and
               !self.release_outside and
               !self.roll_over and
               !self.roll_out and
               !self.drag_over and
               !self.drag_out and
               !self.key_press and
               !self.construct;
    }
};

pub const ClipAction = struct {
    events: ClipEventFlag,
    key_code: ?u8,
    action_data: []u8,

    pub fn read(reader: *LittleEndianReader, swf_version: u8) !?ClipAction {
        // There are SWFs in the wild with malformed final ClipActions that is only 2 bytes
        // instead of 4 bytes (#2899). Handle this gracefully to allow the tag to run.
        // TODO: We may need a more general way to handle truncated tags, since this has
        // occurred in a few different places.
        const event_flags = if(swf_version >= 6)
            ClipEventFlag.read_from_u32(try reader.read_u32())
        else
            ClipEventFlag.read_from_u16(try reader.read_u16());

        if(event_flags.is_empty()){
            return null;
        }

        var length = try reader.read_u32();

        var key_code:?u8 = null;
        if(event_flags.key_press)
        {
            length -= 1;
            key_code = try reader.read_u8();
        }

        const action_data = try reader.read_all();

        return ClipAction {
            .events = (event_flags),
            .key_code = key_code,
            .action_data = action_data,
        };
    }
};

pub const PlaceFlag = struct {
    // 1 << 0
    move: bool,
    // 1 << 1
    has_character: bool,
    // 1 << 2
    has_matrix: bool,
    // 1 << 3
    has_color_transform: bool,
    // 1 << 4
    has_ratio: bool,
    // 1 << 5
    has_name: bool,
    // 1 << 6
    has_clip_depth: bool,
    // 1 << 7
    has_clip_actions: bool,

    // PlaceObject3
    // 1 << 8
    has_filter_list: bool,
    // 1 << 9
    has_blend_mode: bool,
    // 1 << 10
    has_cache_as_bitmap: bool,
    // 1 << 11
    has_class_name: bool,
    // 1 << 12
    has_image: bool,
    // 1 << 13
    has_visible: bool,
    // 1 << 14
    opaque_background: bool,

    pub fn read_from_u16(flags: u16) PlaceFlag {
        return PlaceFlag{
            .move = flags & 1 << 0 != 0,
            .has_character = flags & 1 << 1 != 0,
            .has_matrix = flags & 1 << 2 != 0,
            .has_color_transform = flags & 1 << 3 != 0,
            .has_ratio = flags & 1 << 4 != 0,
            .has_name = flags & 1 << 5 != 0,
            .has_clip_depth = flags & 1 << 6 != 0,
            .has_clip_actions = flags & 1 << 7 != 0,
            .has_filter_list = flags & 1 << 8 != 0,
            .has_blend_mode = flags & 1 << 9 != 0,
            .has_cache_as_bitmap = flags & 1 << 10 != 0,
            .has_class_name = flags & 1 << 11 != 0,
            .has_image = flags & 1 << 12 != 0,
            .has_visible = flags & 1 << 13 != 0,
            .opaque_background = flags & 1 << 14 != 0,
        };
    }

    pub fn read_from_u8(flags: u8) PlaceFlag {
        return PlaceFlag{
            .move = flags & 1 << 0 != 0,
            .has_character = flags & 1 << 1 != 0,
            .has_matrix = flags & 1 << 2 != 0,
            .has_color_transform = flags & 1 << 3 != 0,
            .has_ratio = flags & 1 << 4 != 0,
            .has_name = flags & 1 << 5 != 0,
            .has_clip_depth = flags & 1 << 6 != 0,
            .has_clip_actions = flags & 1 << 7 != 0,
            .has_filter_list = false,
            .has_blend_mode = false,
            .has_cache_as_bitmap = false,
            .has_class_name = false,
            .has_image = false,
            .has_visible = false,
            .opaque_background = false,
        };
    }
};

pub const PlaceObject = struct {
    version: u8,
    action: PlaceObjectAction,
    depth: u16,
    matrix: ?Matrix,
    color_transform: ?ColorTransform,
    ratio: ?u16,
    name: ?[]u8,
    clip_depth: ?u16,
    class_name: ?[]u8,
    filters: ?[]Filter,
    background_color: ?Color,
    blend_mode: ?BlendMode,
    clip_actions: ?[]ClipAction,
    has_image: bool,
    is_bitmap_cached: ?bool,
    is_visible: ?bool,
    amf_data: ?[]u8,

    pub fn read_v1(reader: *LittleEndianReader) !PlaceObject {
        return PlaceObject {
            .version = 1,
            .action = PlaceObjectAction { .Place = try reader.read_u16() },
            .depth = try reader.read_u16(),
            .matrix = try Matrix.read(reader),
            .color_transform = if(reader.eof()) null else  try ColorTransform.read(reader, true),
            .ratio = null,
            .name = null,
            .clip_depth = null,
            .class_name = null,
            .filters = null,
            .background_color = null,
            .blend_mode = null,
            .clip_actions = null,
            .has_image = false,
            .is_bitmap_cached = null,
            .is_visible = null,
            .amf_data = null,
        };
    }

    pub fn read_v2_or_v3(reader: *LittleEndianReader, allocator: std.mem.Allocator, version: u8, swf_version: u8) !PlaceObject {
        const flags = if(version >= 3)
            PlaceFlag.read_from_u16(try reader.read_u16())
        else
            PlaceFlag.read_from_u8(try reader.read_u8());

        const depth = try reader.read_u16();

        // PlaceObject3
        // SWF19 p.40 incorrectly says class name if (HasClassNameFlag || (HasImage && HasCharacterID))
        // I think this should be if (HasClassNameFlag || (HasImage && !HasCharacterID)),
        // you use the class name only if a character ID isn't present.
        // But what is the case where we'd have an image without either HasCharacterID or HasClassName set?
        const has_image = flags.has_image;
        const has_character = flags.has_character;
        const has_class_name = flags.has_class_name or (has_image and !has_character);

        const class_name:?[]u8 = if(has_class_name)
            try reader.read_str()
        else
            null;

        var action: PlaceObjectAction = undefined;

        if(flags.move and !has_character) {
            action = PlaceObjectAction {
                .Modify = true,
            };
        }
        else if(!flags.move and has_character) {
            action = PlaceObjectAction {
                .Place = try reader.read_u16(),
            };
        }
        else if(flags.move and has_character) {
            action = PlaceObjectAction {
                .Replace = try reader.read_u16(),
            };
        }
        else {
            std.log.warn("Invalid PlaceObject action", .{});
            @panic("Invalid PlaceObject action");
        }

        const matrix:?Matrix = if(flags.has_matrix)
            try Matrix.read(reader)
        else null;

        const color_transform:?ColorTransform = if(flags.has_color_transform)
            try ColorTransform.read(reader, true)
        else null;

        const ratio:?u16 = if(flags.has_ratio)
            try reader.read_u16()
        else null;

        const name:?[]u8 = if(flags.has_name)
            try reader.read_str()
        else null;

        const clip_depth:?u16 = if(flags.has_clip_depth)
            try reader.read_u16()
        else null;

        // PlaceObject3
        var filters:?[]Filter = null;

        if(flags.has_filter_list)
        {
            const filter_count = try reader.read_u8();
            var filter_list = try ArrayList(Filter).initCapacity(allocator, filter_count);

            for(0..filter_count) |_| {
                const filter = try Filter.read(reader, allocator);
                try filter_list.append(filter);
            }

            filters = filter_list.items;
        }

        const blend_mode:?BlendMode = if(flags.has_blend_mode)
            BlendMode.from_u8(try reader.read_u8())
        else null;

        var is_bitmap_cached:?bool = null;

        if(flags.has_cache_as_bitmap)
        {
           // Some incorrect SWFs appear to end the tag here, without
           // the expected 'u8'.
           if (reader.eof()) {
               is_bitmap_cached = true;
           } else {
               is_bitmap_cached = try reader.read_u8() != 0;
           }
        }

        const is_visible:?bool = if(flags.has_visible)
            try reader.read_u8() != 0
        else null;

        const background_color:?Color = if(flags.opaque_background)
            try Color.read(reader)
        else null;

        var clip_actions:?[]ClipAction = null;
        if(flags.has_clip_actions)
        {
            var actions = ArrayList(ClipAction).init(allocator);
            while(true){
                const clip_action = try ClipAction.read(reader, swf_version);
                if(clip_action == null){
                    break;
                }
                try actions.append(clip_action.?);
            }
            clip_actions = actions.items;
        }

        // PlaceObject4
        const amf_data:?[]u8 = if(version >= 4)
            try reader.read_all()
        else null;

        return PlaceObject {
            .version = version,
            .action = action,
            .depth = depth,
            .matrix = matrix,
            .color_transform = color_transform,
            .ratio = ratio,
            .name = name,
            .clip_depth = clip_depth,
            .class_name = class_name,
            .filters = filters,
            .background_color = background_color,
            .blend_mode = blend_mode,
            .clip_actions = clip_actions,
            .has_image = has_image,
            .is_bitmap_cached = is_bitmap_cached,
            .is_visible = is_visible,
            .amf_data = amf_data,
        };
    }
};

pub const DoAbc2Flag = struct {
    // 1 << 0
    lazy_initialize: bool,

    pub fn read_from_u32(flags: u32) DoAbc2Flag {
        return DoAbc2Flag{
            .lazy_initialize = flags & 1 << 0 != 0,
        };
    }
};

pub const DoAbc2 = struct {
    flags: DoAbc2Flag,
    name: []u8,
    abc_data: []u8,

    pub fn read_from_u32(reader: *LittleEndianReader) !DoAbc2 {
        const flags = DoAbc2Flag.read_from_u32(try reader.read_u32());
        const name = try reader.read_str();
        const abc_data = try reader.read_all();

        return DoAbc2 {
            .flags = flags,
            .name = name,
            .abc_data = abc_data,
        };
    }
};

pub const SymbolClassLink = struct {
    id: u16,
    name: []u8,

    pub fn read(reader: *LittleEndianReader) !SymbolClassLink {
        const id = try reader.read_u16();
        const name = try reader.read_str();
        return SymbolClassLink {
            .id = id,
            .name = name,
        };
    }
};

pub const SymbolClass = struct {
    symbols: []SymbolClassLink,

    pub fn read(reader: *LittleEndianReader, allocator: std.mem.Allocator) !SymbolClass {
        const num_symbols = try reader.read_u16();
        var symbols = try ArrayList(SymbolClassLink).initCapacity(allocator, num_symbols);

        for(0..num_symbols) |_| {
            const symbol = try SymbolClassLink.read(reader);
            try symbols.append(symbol);
        }

        return SymbolClass {
            .symbols = symbols.items,
        };
    }
};

pub const ExportedAsset = struct {
    id: u16,
    name: []u8,

    pub fn read(reader: *LittleEndianReader) !ExportedAsset {
        const id = try reader.read_u16();
        const name = try reader.read_str();
        return ExportedAsset {
            .id = id,
            .name = name,
        };
    }
};

pub const ExportAssets = struct {
    assets: []ExportedAsset,

    pub fn read(reader: *LittleEndianReader, allocator: std.mem.Allocator) !ExportAssets {
        const num_assets = try reader.read_u16();
        var assets = try ArrayList(ExportedAsset).initCapacity(allocator, num_assets);

        for(0..num_assets) |_| {
            const asset = try ExportedAsset.read(reader);
            try assets.append(asset);
        }

        return ExportAssets {
            .assets = assets.items,
        };
    }
};

pub const FrameLabel = struct {
    label: []u8,
    is_anchor: bool,

    pub fn read(reader: *LittleEndianReader, swf_version: u8) !FrameLabel {
        const label = try reader.read_str();
        const is_anchor = swf_version >= 6 and try reader.read_u8() != 0;

        return FrameLabel {
            .label = label,
            .is_anchor = is_anchor,
        };
    }
};

pub const Tag = union(TagCode){
    End: struct{},
    ShowFrame: struct{},
    DefineShape: DefineShape,

    PlaceObject: PlaceObject,
    RemoveObject: struct{},
    DefineBits: DefineBits,
    DefineButton: DefineButton,
    JpegTables: struct{},
    SetBackgroundColor: Color,
    DefineFont: struct{},
    DefineText: struct{},
    DoAction: struct{},
    DefineFontInfo: struct{},
    DefineSound: struct{},
    StartSound: struct{},

    DefineButtonSound: struct{},
    SoundStreamHead: struct{},
    SoundStreamBlock: struct{},
    DefineBitsLossless: struct{},
    DefineBitsJpeg2: DefineBitsJpeg2,
    DefineShape2: DefineShape,
    DefineButtonCxform: struct{},
    Protect: struct{},

    PlaceObject2: PlaceObject,

    RemoveObject2: struct{},

    DefineShape3: DefineShape,
    DefineText2: struct{},
    DefineButton2: DefineButton,
    DefineBitsJpeg3: DefineBitsJpeg3,
    DefineBitsLossless2: struct{},
    DefineEditText: struct{},

    DefineSprite: DefineSprite,
    NameCharacter: struct{},
    ProductInfo: struct{},

    FrameLabel: FrameLabel,

    SoundStreamHead2: struct{},
    DefineMorphShape: struct{},

    DefineFont2: struct{},

    ExportAssets: ExportAssets,
    ImportAssets: struct{},
    EnableDebugger: struct{},
    DoInitAction: struct{},
    DefineVideoStream: struct{},
    VideoFrame: struct{},
    DefineFontInfo2: struct{},

    DebugId: struct{},
    EnableDebugger2: struct{},
    ScriptLimits: struct{},
    SetTabIndex: struct{},
    FileAttributes : FileAttributes,
    PlaceObject3: PlaceObject,
    ImportAssets2: struct{},
    DoAbc: struct{},
    DefineFontAlignZones: struct{},
    CsmTextSettings: CsmTextSettings,
    DefineFont3: struct{},
    SymbolClass: SymbolClass,
    Metadata: struct{},
    DefineScalingGrid: struct{},

    DoAbc2: DoAbc2,
    DefineShape4: DefineShape,
    DefineMorphShape2: struct{},

    DefineSceneAndFrameLabelData: DefineSceneAndFrameLabelData,
    DefineBinaryData: DefineBinaryData,
    DefineFontName: struct{},
    StartSound2: struct{},
    DefineBitsJpeg4: DefineBitsJpeg3,
    DefineFont4: struct{},

    EnableTelemetry: struct{},
    PlaceObject4: PlaceObject,
    Undefined: struct{},

    pub fn read(tag_code: TagCode, reader: *LittleEndianReader, allocator: std.mem.Allocator, swf_version: u8) !Tag {
        switch (tag_code) {
            TagCode.DefineBits => return Tag {
                .DefineBits = try DefineBits.read(reader)
            },
            TagCode.DefineBitsJpeg2 => return Tag {
                .DefineBitsJpeg2 = try DefineBitsJpeg2.read(reader)
            },
            TagCode.DefineBitsJpeg3 => return Tag {
                .DefineBitsJpeg3 = try DefineBitsJpeg3.read(reader, 3)
            },
            TagCode.DefineBitsJpeg4 => return Tag {
                .DefineBitsJpeg3 = try DefineBitsJpeg3.read(reader, 4)
            },
            TagCode.DefineButton => return Tag {
                .DefineButton = try DefineButton.read_v1(reader, allocator)
            },
            TagCode.DefineButton2 => return Tag {
                .DefineButton2 = try DefineButton.read_v2(reader, allocator)
            },
            TagCode.SetBackgroundColor => return Tag {
                .SetBackgroundColor = try Color.read_no_alpha(reader)
            },
            TagCode.CsmTextSettings => return Tag {
                .CsmTextSettings = try CsmTextSettings.read(reader)
            },
            TagCode.DefineBinaryData => return Tag {
                .DefineBinaryData = try DefineBinaryData.read(reader)
            },
            TagCode.FileAttributes => return Tag {
                .FileAttributes = try FileAttributes.read(reader)
            },
            TagCode.DefineSceneAndFrameLabelData => return Tag {
                .DefineSceneAndFrameLabelData = try DefineSceneAndFrameLabelData.read(reader, allocator)
            },
            TagCode.PlaceObject => return Tag {
                .PlaceObject = try PlaceObject.read_v1(reader)
            },
            TagCode.PlaceObject2 => return Tag {
                .PlaceObject = try PlaceObject.read_v2_or_v3(reader, allocator, 2, swf_version)
            },
            TagCode.PlaceObject3 => return Tag {
                .PlaceObject = try PlaceObject.read_v2_or_v3(reader, allocator, 3, swf_version)
            },
            TagCode.PlaceObject4 => return Tag {
                .PlaceObject = try PlaceObject.read_v2_or_v3(reader, allocator, 4, swf_version)
            },
            TagCode.DefineShape => return Tag {
                .DefineShape = try DefineShape.read(reader, allocator, 1, swf_version)
            },
            TagCode.DefineShape2 => return Tag {
                .DefineShape2 = try DefineShape.read(reader, allocator, 2, swf_version)
            },
            TagCode.DefineShape3 => return Tag {
                .DefineShape3 = try DefineShape.read(reader, allocator, 3, swf_version)
            },
            TagCode.DefineShape4 => return Tag {
                .DefineShape4 = try DefineShape.read(reader, allocator, 4, swf_version)
            },
            TagCode.DefineSprite => return Tag {
                .DefineSprite = try DefineSprite.read(reader, allocator)
            },
            TagCode.DoAbc2 => return Tag {
                .DoAbc2 = try DoAbc2.read_from_u32(reader)
            },
            TagCode.SymbolClass => return Tag {
                .SymbolClass = try SymbolClass.read(reader, allocator)
            },
            TagCode.ExportAssets => return Tag {
                .ExportAssets = try ExportAssets.read(reader, allocator)
            },
            TagCode.FrameLabel => return Tag {
                .FrameLabel = try FrameLabel.read(reader, swf_version)
            },
            TagCode.End => return Tag.End,
            TagCode.ShowFrame => return Tag.ShowFrame,
            else => {
                std.log.warn("Unsupported tag code {}", .{tag_code});
                return Tag.Undefined;
            }
        }
    }
};

