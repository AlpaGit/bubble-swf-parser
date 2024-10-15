const LittleEndianReader = @import("io.zig").LittleEndianReader;

const TextGridFit = enum(u2) {
    None = 0,
    Pixel = 1,
    SubPixel = 2,
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
    _,

    pub fn from_u16(tag_code:u16) TagCode {
        return @enumFromInt(tag_code);
    }
};

// DefineBits (74)
pub const DefineBits = struct {
    const Self = @This();

    id: u16,
    jpeg_data: []const u8,

    pub fn read(reader: *LittleEndianReader) !Self {
        const id = try reader.read_u16();
        const data = try reader.read_all();
        return Self {
            .id = id,
            .jpeg_data = data,
        };
    }
};

// DefineBitsJPEG2 (21)
// It differs from DefineBits in that it contains both the
// JPEG encoding table and the JPEG image data. This tag allows multiple JPEG images with differing encoding
// tables to be defined within a single SWF file.
pub const DefineBitsJpeg2 = struct {
    const Self = @This();

    id: u16,
    jpeg_data: []const u8,

    pub fn read(reader: *LittleEndianReader) !Self {
        const id = try reader.read_u16();
        const data = try reader.read_all();
        return Self {
            .id = id,
            .jpeg_data = data,
        };
    }
};

// DefineBinaryData (87)
pub const DefineBinaryData = struct {
    const Self = @This();
    id: u16,
    data: []const u8,

    pub fn read(reader: *LittleEndianReader) !Self {
        const id = try reader.read_u16();
        // Reserved
        try reader.ignore(4);
        const data = try reader.read_all();
        return Self {
            .id = id,
            .data = data,
        };
    }
};

// CsmTextSettings (74)
pub const CsmTextSettings = struct {
    const Self = @This();

    id: u16,
    use_advanced_rendering: bool,
    grid_fit: TextGridFit,
    thickness: f32,
    sharpness: f32,

    pub fn read(reader: *LittleEndianReader) !Self {
        const id = try reader.read_u16();
        const flags = try reader.read_u8();
        const thickness = try reader.read_f32();
        const sharpness = try reader.read_f32();
        // Reserved (0)
        try reader.ignore(1);

        return Self {
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
    const Self = @This();

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

    pub fn read(reader: *LittleEndianReader) !Self {
        const flags = try reader.read_u32();

        return Self {
            .useDirectBlit = (flags & 1 << 6) != 0,
            .useGpu = (flags & 1 << 5) != 0,
            .hasMetadata = (flags & 1 << 4) != 0,
            .isActionScript3 = (flags & 1 << 3) != 0,
            .useNetworkSandbox = (flags & 1 << 0) != 0,
        };
    }
};

pub const Tag = union(TagCode){
    End: struct{},
    ShowFrame: struct{},
    DefineShape: struct{},

    PlaceObject: struct{},
    RemoveObject: struct{},
    DefineBits: DefineBits,
    DefineButton:  struct{},
    JpegTables:  struct{},
    SetBackgroundColor:  struct{},
    DefineFont:  struct{},
    DefineText:  struct{},
    DoAction:  struct{},
    DefineFontInfo:  struct{},
    DefineSound:  struct{},
    StartSound: struct{},

    DefineButtonSound: struct{},
    SoundStreamHead: struct{},
    SoundStreamBlock: struct{},
    DefineBitsLossless: struct{},
    DefineBitsJpeg2: DefineBitsJpeg2,
    DefineShape2: struct{},
    DefineButtonCxform: struct{},
    Protect: struct{},

    PlaceObject2: struct{},

    RemoveObject2: struct{},

    DefineShape3: struct{},
    DefineText2: struct{},
    DefineButton2: struct{},
    DefineBitsJpeg3: struct{},
    DefineBitsLossless2: struct{},
    DefineEditText: struct{},

    DefineSprite: struct{},
    NameCharacter: struct{},
    ProductInfo: struct{},

    FrameLabel: struct{},

    SoundStreamHead2: struct{},
    DefineMorphShape: struct{},

    DefineFont2: struct{},

    ExportAssets: struct{},
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
    PlaceObject3: struct{},
    ImportAssets2: struct{},
    DoAbc: struct{},
    DefineFontAlignZones: struct{},
    CsmTextSettings: CsmTextSettings,
    DefineFont3: struct{},
    SymbolClass: struct{},
    Metadata: struct{},
    DefineScalingGrid: struct{},

    DoAbc2: struct{},
    DefineShape4: struct{},
    DefineMorphShape2: struct{},

    DefineSceneAndFrameLabelData: struct{},
    DefineBinaryData: DefineBinaryData,
    DefineFontName: struct{},
    StartSound2: struct{},
    DefineBitsJpeg4: struct{},
    DefineFont4: struct{},

    EnableTelemetry: struct{},
    PlaceObject4: struct{},

    pub fn read(tag_code: TagCode, reader: *LittleEndianReader) !Tag {
        switch (tag_code) {
            TagCode.DefineBits => return Tag {
                .DefineBits = try DefineBits.read(reader)
            },
            TagCode.DefineBitsJpeg2 => return Tag {
                .DefineBits = try DefineBitsJpeg2.read(reader)
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
            else => return Tag.End,
        }
    }
};

