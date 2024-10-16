const Twips = @import("io.zig").Twips;
const LittleEndianReader = @import("io.zig").LittleEndianReader;

/// The transformation matrix used by Flash display objects.
///
/// The matrix is a 2x3 affine transformation matrix. A point (x, y) is transformed by the matrix
/// in the following way:
/// ```text
///  [a c tx] *  [x] = [a*x + c*y + tx]
///  [b d ty]    [y]   [b*x + d*y + ty]
///  [0 0 1 ]    [1]   [1             ]
/// ```
///
/// The SWF format uses 16.16 format for `a`, `b`, `c`, `d`. Twips are used for `tx` and `ty`.
/// This means that objects in Flash can only move in units of twips, or 1/20 pixels.

pub const Matrix = struct{
    /// The matrix element at `[0, 0]`. Labeled `ScaleX` in SWF19.
    a: f32,
    /// The matrix element at `[1, 0]`. Labeled `RotateSkew0` in SWF19.
    b: f32,
    /// The matrix element at `[0, 1]`. Labeled `RotateSkew1` in SWF19.
    c: f32,
    /// The matrix element at `[1, 1]`. Labeled `ScaleY` in SWF19.
    d: f32,
    /// The X translation in twips. Labeled `TranslateX` in SWF19.
    tx: Twips,
    /// The Y translation in twips. Labeled `TranslateX` in SWF19.
    ty: Twips,

    pub fn identity() Matrix {
        return Matrix{
            .a = 1.0,
            .b = 0.0,
            .c = 0.0,
            .d = 1.0,
            .tx = Twips{ .value = 0 },
            .ty = Twips{ .value = 0 },
        };
    }

    pub fn read(reader: *LittleEndianReader) !Matrix {
        var m = Matrix.identity();

        // Scale
        if (try reader.read_ubits(1) == 1) {
            const num_bits:u5 = @intCast(try reader.read_ubits(5));

            m.a = try reader.read_fbits(num_bits);
            m.d = try reader.read_fbits(num_bits);
        }

        // Rotate/Skew
        if (try reader.read_ubits(1) == 1) {
            const num_bits:u5 = @intCast(try reader.read_ubits(5));

            m.b = try reader.read_fbits(num_bits);
            m.c = try reader.read_fbits(num_bits);
        }

        // Translate (always present)
        const num_bits:u5 = @intCast(try reader.read_ubits(5));
        m.tx = Twips{ .value = try reader.read_sbits(num_bits) };
        m.ty = Twips{ .value = try reader.read_sbits(num_bits) };

        return m;
    }
};