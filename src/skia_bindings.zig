pub const __builtin_bswap16 = @import("std").zig.c_builtins.__builtin_bswap16;
pub const __builtin_bswap32 = @import("std").zig.c_builtins.__builtin_bswap32;
pub const __builtin_bswap64 = @import("std").zig.c_builtins.__builtin_bswap64;
pub const __builtin_signbit = @import("std").zig.c_builtins.__builtin_signbit;
pub const __builtin_signbitf = @import("std").zig.c_builtins.__builtin_signbitf;
pub const __builtin_popcount = @import("std").zig.c_builtins.__builtin_popcount;
pub const __builtin_ctz = @import("std").zig.c_builtins.__builtin_ctz;
pub const __builtin_clz = @import("std").zig.c_builtins.__builtin_clz;
pub const __builtin_sqrt = @import("std").zig.c_builtins.__builtin_sqrt;
pub const __builtin_sqrtf = @import("std").zig.c_builtins.__builtin_sqrtf;
pub const __builtin_sin = @import("std").zig.c_builtins.__builtin_sin;
pub const __builtin_sinf = @import("std").zig.c_builtins.__builtin_sinf;
pub const __builtin_cos = @import("std").zig.c_builtins.__builtin_cos;
pub const __builtin_cosf = @import("std").zig.c_builtins.__builtin_cosf;
pub const __builtin_exp = @import("std").zig.c_builtins.__builtin_exp;
pub const __builtin_expf = @import("std").zig.c_builtins.__builtin_expf;
pub const __builtin_exp2 = @import("std").zig.c_builtins.__builtin_exp2;
pub const __builtin_exp2f = @import("std").zig.c_builtins.__builtin_exp2f;
pub const __builtin_log = @import("std").zig.c_builtins.__builtin_log;
pub const __builtin_logf = @import("std").zig.c_builtins.__builtin_logf;
pub const __builtin_log2 = @import("std").zig.c_builtins.__builtin_log2;
pub const __builtin_log2f = @import("std").zig.c_builtins.__builtin_log2f;
pub const __builtin_log10 = @import("std").zig.c_builtins.__builtin_log10;
pub const __builtin_log10f = @import("std").zig.c_builtins.__builtin_log10f;
pub const __builtin_abs = @import("std").zig.c_builtins.__builtin_abs;
pub const __builtin_labs = @import("std").zig.c_builtins.__builtin_labs;
pub const __builtin_llabs = @import("std").zig.c_builtins.__builtin_llabs;
pub const __builtin_fabs = @import("std").zig.c_builtins.__builtin_fabs;
pub const __builtin_fabsf = @import("std").zig.c_builtins.__builtin_fabsf;
pub const __builtin_floor = @import("std").zig.c_builtins.__builtin_floor;
pub const __builtin_floorf = @import("std").zig.c_builtins.__builtin_floorf;
pub const __builtin_ceil = @import("std").zig.c_builtins.__builtin_ceil;
pub const __builtin_ceilf = @import("std").zig.c_builtins.__builtin_ceilf;
pub const __builtin_trunc = @import("std").zig.c_builtins.__builtin_trunc;
pub const __builtin_truncf = @import("std").zig.c_builtins.__builtin_truncf;
pub const __builtin_round = @import("std").zig.c_builtins.__builtin_round;
pub const __builtin_roundf = @import("std").zig.c_builtins.__builtin_roundf;
pub const __builtin_strlen = @import("std").zig.c_builtins.__builtin_strlen;
pub const __builtin_strcmp = @import("std").zig.c_builtins.__builtin_strcmp;
pub const __builtin_object_size = @import("std").zig.c_builtins.__builtin_object_size;
pub const __builtin___memset_chk = @import("std").zig.c_builtins.__builtin___memset_chk;
pub const __builtin_memset = @import("std").zig.c_builtins.__builtin_memset;
pub const __builtin___memcpy_chk = @import("std").zig.c_builtins.__builtin___memcpy_chk;
pub const __builtin_memcpy = @import("std").zig.c_builtins.__builtin_memcpy;
pub const __builtin_expect = @import("std").zig.c_builtins.__builtin_expect;
pub const __builtin_nanf = @import("std").zig.c_builtins.__builtin_nanf;
pub const __builtin_huge_valf = @import("std").zig.c_builtins.__builtin_huge_valf;
pub const __builtin_inff = @import("std").zig.c_builtins.__builtin_inff;
pub const __builtin_isnan = @import("std").zig.c_builtins.__builtin_isnan;
pub const __builtin_isinf = @import("std").zig.c_builtins.__builtin_isinf;
pub const __builtin_isinf_sign = @import("std").zig.c_builtins.__builtin_isinf_sign;
pub const __has_builtin = @import("std").zig.c_builtins.__has_builtin;
pub const __builtin_assume = @import("std").zig.c_builtins.__builtin_assume;
pub const __builtin_unreachable = @import("std").zig.c_builtins.__builtin_unreachable;
pub const __builtin_constant_p = @import("std").zig.c_builtins.__builtin_constant_p;
pub const __builtin_mul_overflow = @import("std").zig.c_builtins.__builtin_mul_overflow;
pub const int_least64_t = i64;
pub const uint_least64_t = u64;
pub const int_fast64_t = i64;
pub const uint_fast64_t = u64;
pub const int_least32_t = i32;
pub const uint_least32_t = u32;
pub const int_fast32_t = i32;
pub const uint_fast32_t = u32;
pub const int_least16_t = i16;
pub const uint_least16_t = u16;
pub const int_fast16_t = i16;
pub const uint_fast16_t = u16;
pub const int_least8_t = i8;
pub const uint_least8_t = u8;
pub const int_fast8_t = i8;
pub const uint_fast8_t = u8;
pub const intmax_t = c_longlong;
pub const uintmax_t = c_ulonglong;
pub const ptrdiff_t = c_longlong;
pub const wchar_t = c_ushort;
pub const max_align_t = extern struct {
    __clang_max_align_nonce1: c_longlong align(8) = @import("std").mem.zeroes(c_longlong),
    __clang_max_align_nonce2: c_longdouble align(16) = @import("std").mem.zeroes(c_longdouble),
};
pub const struct_sk_refcnt_t = opaque {};
pub const sk_refcnt_t = struct_sk_refcnt_t;
pub const struct_sk_nvrefcnt_t = opaque {};
pub const sk_nvrefcnt_t = struct_sk_nvrefcnt_t;
pub const struct_sk_flattenable_t = opaque {};
pub const sk_flattenable_t = struct_sk_flattenable_t;
pub const sk_color_t = u32;
pub const sk_pmcolor_t = u32;
pub const struct_sk_color4f_t = extern struct {
    fR: f32 = @import("std").mem.zeroes(f32),
    fG: f32 = @import("std").mem.zeroes(f32),
    fB: f32 = @import("std").mem.zeroes(f32),
    fA: f32 = @import("std").mem.zeroes(f32),
};
pub const sk_color4f_t = struct_sk_color4f_t;
pub const UNKNOWN_SK_COLORTYPE: c_int = 0;
pub const ALPHA_8_SK_COLORTYPE: c_int = 1;
pub const RGB_565_SK_COLORTYPE: c_int = 2;
pub const ARGB_4444_SK_COLORTYPE: c_int = 3;
pub const RGBA_8888_SK_COLORTYPE: c_int = 4;
pub const RGB_888X_SK_COLORTYPE: c_int = 5;
pub const BGRA_8888_SK_COLORTYPE: c_int = 6;
pub const RGBA_1010102_SK_COLORTYPE: c_int = 7;
pub const BGRA_1010102_SK_COLORTYPE: c_int = 8;
pub const RGB_101010X_SK_COLORTYPE: c_int = 9;
pub const BGR_101010X_SK_COLORTYPE: c_int = 10;
pub const BGR_101010X_XR_SK_COLORTYPE: c_int = 11;
pub const GRAY_8_SK_COLORTYPE: c_int = 12;
pub const RGBA_F16_NORM_SK_COLORTYPE: c_int = 13;
pub const RGBA_F16_SK_COLORTYPE: c_int = 14;
pub const RGBA_F32_SK_COLORTYPE: c_int = 15;
pub const R8G8_UNORM_SK_COLORTYPE: c_int = 16;
pub const A16_FLOAT_SK_COLORTYPE: c_int = 17;
pub const R16G16_FLOAT_SK_COLORTYPE: c_int = 18;
pub const A16_UNORM_SK_COLORTYPE: c_int = 19;
pub const R16G16_UNORM_SK_COLORTYPE: c_int = 20;
pub const R16G16B16A16_UNORM_SK_COLORTYPE: c_int = 21;
pub const SRGBA_8888_SK_COLORTYPE: c_int = 22;
pub const R8_UNORM_SK_COLORTYPE: c_int = 23;
pub const sk_colortype_t = c_uint;
pub const UNKNOWN_SK_ALPHATYPE: c_int = 0;
pub const OPAQUE_SK_ALPHATYPE: c_int = 1;
pub const PREMUL_SK_ALPHATYPE: c_int = 2;
pub const UNPREMUL_SK_ALPHATYPE: c_int = 3;
pub const sk_alphatype_t = c_uint;
pub const UNKNOWN_SK_PIXELGEOMETRY: c_int = 0;
pub const RGB_H_SK_PIXELGEOMETRY: c_int = 1;
pub const BGR_H_SK_PIXELGEOMETRY: c_int = 2;
pub const RGB_V_SK_PIXELGEOMETRY: c_int = 3;
pub const BGR_V_SK_PIXELGEOMETRY: c_int = 4;
pub const sk_pixelgeometry_t = c_uint;
pub const NONE_SK_SURFACE_PROPS_FLAGS: c_int = 0;
pub const USE_DEVICE_INDEPENDENT_FONTS_SK_SURFACE_PROPS_FLAGS: c_int = 1;
pub const sk_surfaceprops_flags_t = c_uint;
pub const struct_sk_surfaceprops_t = opaque {};
pub const sk_surfaceprops_t = struct_sk_surfaceprops_t;
pub const sk_point_t = extern struct {
    x: f32 = @import("std").mem.zeroes(f32),
    y: f32 = @import("std").mem.zeroes(f32),
};
pub const sk_vector_t = sk_point_t;
pub const sk_irect_t = extern struct {
    left: i32 = @import("std").mem.zeroes(i32),
    top: i32 = @import("std").mem.zeroes(i32),
    right: i32 = @import("std").mem.zeroes(i32),
    bottom: i32 = @import("std").mem.zeroes(i32),
};
pub const sk_rect_t = extern struct {
    left: f32 = @import("std").mem.zeroes(f32),
    top: f32 = @import("std").mem.zeroes(f32),
    right: f32 = @import("std").mem.zeroes(f32),
    bottom: f32 = @import("std").mem.zeroes(f32),
};
pub const sk_matrix_t = extern struct {
    scaleX: f32 = @import("std").mem.zeroes(f32),
    skewX: f32 = @import("std").mem.zeroes(f32),
    transX: f32 = @import("std").mem.zeroes(f32),
    skewY: f32 = @import("std").mem.zeroes(f32),
    scaleY: f32 = @import("std").mem.zeroes(f32),
    transY: f32 = @import("std").mem.zeroes(f32),
    persp0: f32 = @import("std").mem.zeroes(f32),
    persp1: f32 = @import("std").mem.zeroes(f32),
    persp2: f32 = @import("std").mem.zeroes(f32),
};
pub const sk_matrix44_t = extern struct {
    m00: f32 = @import("std").mem.zeroes(f32),
    m01: f32 = @import("std").mem.zeroes(f32),
    m02: f32 = @import("std").mem.zeroes(f32),
    m03: f32 = @import("std").mem.zeroes(f32),
    m10: f32 = @import("std").mem.zeroes(f32),
    m11: f32 = @import("std").mem.zeroes(f32),
    m12: f32 = @import("std").mem.zeroes(f32),
    m13: f32 = @import("std").mem.zeroes(f32),
    m20: f32 = @import("std").mem.zeroes(f32),
    m21: f32 = @import("std").mem.zeroes(f32),
    m22: f32 = @import("std").mem.zeroes(f32),
    m23: f32 = @import("std").mem.zeroes(f32),
    m30: f32 = @import("std").mem.zeroes(f32),
    m31: f32 = @import("std").mem.zeroes(f32),
    m32: f32 = @import("std").mem.zeroes(f32),
    m33: f32 = @import("std").mem.zeroes(f32),
};
pub const struct_sk_canvas_t = opaque {};
pub const sk_canvas_t = struct_sk_canvas_t;
pub const struct_sk_nodraw_canvas_t = opaque {};
pub const sk_nodraw_canvas_t = struct_sk_nodraw_canvas_t;
pub const struct_sk_nway_canvas_t = opaque {};
pub const sk_nway_canvas_t = struct_sk_nway_canvas_t;
pub const struct_sk_overdraw_canvas_t = opaque {};
pub const sk_overdraw_canvas_t = struct_sk_overdraw_canvas_t;
pub const struct_sk_data_t = opaque {};
pub const sk_data_t = struct_sk_data_t;
pub const struct_sk_drawable_t = opaque {};
pub const sk_drawable_t = struct_sk_drawable_t;
pub const struct_sk_image_t = opaque {};
pub const sk_image_t = struct_sk_image_t;
pub const struct_sk_maskfilter_t = opaque {};
pub const sk_maskfilter_t = struct_sk_maskfilter_t;
pub const struct_sk_paint_t = opaque {};
pub const sk_paint_t = struct_sk_paint_t;
pub const struct_sk_font_t = opaque {};
pub const sk_font_t = struct_sk_font_t;
pub const struct_sk_path_t = opaque {};
pub const sk_path_t = struct_sk_path_t;
pub const struct_sk_picture_t = opaque {};
pub const sk_picture_t = struct_sk_picture_t;
pub const struct_sk_picture_recorder_t = opaque {};
pub const sk_picture_recorder_t = struct_sk_picture_recorder_t;
pub const struct_sk_bbh_factory_t = opaque {};
pub const sk_bbh_factory_t = struct_sk_bbh_factory_t;
pub const struct_sk_rtree_factory_t = opaque {};
pub const sk_rtree_factory_t = struct_sk_rtree_factory_t;
pub const struct_sk_shader_t = opaque {};
pub const sk_shader_t = struct_sk_shader_t;
pub const struct_sk_surface_t = opaque {};
pub const sk_surface_t = struct_sk_surface_t;
pub const struct_sk_region_t = opaque {};
pub const sk_region_t = struct_sk_region_t;
pub const struct_sk_region_iterator_t = opaque {};
pub const sk_region_iterator_t = struct_sk_region_iterator_t;
pub const struct_sk_region_cliperator_t = opaque {};
pub const sk_region_cliperator_t = struct_sk_region_cliperator_t;
pub const struct_sk_region_spanerator_t = opaque {};
pub const sk_region_spanerator_t = struct_sk_region_spanerator_t;
pub const CLEAR_SK_BLENDMODE: c_int = 0;
pub const SRC_SK_BLENDMODE: c_int = 1;
pub const DST_SK_BLENDMODE: c_int = 2;
pub const SRCOVER_SK_BLENDMODE: c_int = 3;
pub const DSTOVER_SK_BLENDMODE: c_int = 4;
pub const SRCIN_SK_BLENDMODE: c_int = 5;
pub const DSTIN_SK_BLENDMODE: c_int = 6;
pub const SRCOUT_SK_BLENDMODE: c_int = 7;
pub const DSTOUT_SK_BLENDMODE: c_int = 8;
pub const SRCATOP_SK_BLENDMODE: c_int = 9;
pub const DSTATOP_SK_BLENDMODE: c_int = 10;
pub const XOR_SK_BLENDMODE: c_int = 11;
pub const PLUS_SK_BLENDMODE: c_int = 12;
pub const MODULATE_SK_BLENDMODE: c_int = 13;
pub const SCREEN_SK_BLENDMODE: c_int = 14;
pub const OVERLAY_SK_BLENDMODE: c_int = 15;
pub const DARKEN_SK_BLENDMODE: c_int = 16;
pub const LIGHTEN_SK_BLENDMODE: c_int = 17;
pub const COLORDODGE_SK_BLENDMODE: c_int = 18;
pub const COLORBURN_SK_BLENDMODE: c_int = 19;
pub const HARDLIGHT_SK_BLENDMODE: c_int = 20;
pub const SOFTLIGHT_SK_BLENDMODE: c_int = 21;
pub const DIFFERENCE_SK_BLENDMODE: c_int = 22;
pub const EXCLUSION_SK_BLENDMODE: c_int = 23;
pub const MULTIPLY_SK_BLENDMODE: c_int = 24;
pub const HUE_SK_BLENDMODE: c_int = 25;
pub const SATURATION_SK_BLENDMODE: c_int = 26;
pub const COLOR_SK_BLENDMODE: c_int = 27;
pub const LUMINOSITY_SK_BLENDMODE: c_int = 28;
pub const sk_blendmode_t = c_uint;
pub const sk_point3_t = extern struct {
    x: f32 = @import("std").mem.zeroes(f32),
    y: f32 = @import("std").mem.zeroes(f32),
    z: f32 = @import("std").mem.zeroes(f32),
};
pub const sk_ipoint_t = extern struct {
    x: i32 = @import("std").mem.zeroes(i32),
    y: i32 = @import("std").mem.zeroes(i32),
};
pub const sk_size_t = extern struct {
    w: f32 = @import("std").mem.zeroes(f32),
    h: f32 = @import("std").mem.zeroes(f32),
};
pub const sk_isize_t = extern struct {
    w: i32 = @import("std").mem.zeroes(i32),
    h: i32 = @import("std").mem.zeroes(i32),
};
pub const sk_fontmetrics_t = extern struct {
    fFlags: u32 = @import("std").mem.zeroes(u32),
    fTop: f32 = @import("std").mem.zeroes(f32),
    fAscent: f32 = @import("std").mem.zeroes(f32),
    fDescent: f32 = @import("std").mem.zeroes(f32),
    fBottom: f32 = @import("std").mem.zeroes(f32),
    fLeading: f32 = @import("std").mem.zeroes(f32),
    fAvgCharWidth: f32 = @import("std").mem.zeroes(f32),
    fMaxCharWidth: f32 = @import("std").mem.zeroes(f32),
    fXMin: f32 = @import("std").mem.zeroes(f32),
    fXMax: f32 = @import("std").mem.zeroes(f32),
    fXHeight: f32 = @import("std").mem.zeroes(f32),
    fCapHeight: f32 = @import("std").mem.zeroes(f32),
    fUnderlineThickness: f32 = @import("std").mem.zeroes(f32),
    fUnderlinePosition: f32 = @import("std").mem.zeroes(f32),
    fStrikeoutThickness: f32 = @import("std").mem.zeroes(f32),
    fStrikeoutPosition: f32 = @import("std").mem.zeroes(f32),
};
pub const struct_sk_string_t = opaque {};
pub const sk_string_t = struct_sk_string_t;
pub const struct_sk_bitmap_t = opaque {};
pub const sk_bitmap_t = struct_sk_bitmap_t;
pub const struct_sk_pixmap_t = opaque {};
pub const sk_pixmap_t = struct_sk_pixmap_t;
pub const struct_sk_colorfilter_t = opaque {};
pub const sk_colorfilter_t = struct_sk_colorfilter_t;
pub const struct_sk_imagefilter_t = opaque {};
pub const sk_imagefilter_t = struct_sk_imagefilter_t;
pub const struct_sk_blender_t = opaque {};
pub const sk_blender_t = struct_sk_blender_t;
pub const struct_sk_typeface_t = opaque {};
pub const sk_typeface_t = struct_sk_typeface_t;
pub const sk_font_table_tag_t = u32;
pub const struct_sk_fontmgr_t = opaque {};
pub const sk_fontmgr_t = struct_sk_fontmgr_t;
pub const struct_sk_fontstyle_t = opaque {};
pub const sk_fontstyle_t = struct_sk_fontstyle_t;
pub const struct_sk_fontstyleset_t = opaque {};
pub const sk_fontstyleset_t = struct_sk_fontstyleset_t;
pub const struct_sk_codec_t = opaque {};
pub const sk_codec_t = struct_sk_codec_t;
pub const struct_sk_colorspace_t = opaque {};
pub const sk_colorspace_t = struct_sk_colorspace_t;
pub const struct_sk_stream_t = opaque {};
pub const sk_stream_t = struct_sk_stream_t;
pub const struct_sk_stream_filestream_t = opaque {};
pub const sk_stream_filestream_t = struct_sk_stream_filestream_t;
pub const struct_sk_stream_asset_t = opaque {};
pub const sk_stream_asset_t = struct_sk_stream_asset_t;
pub const struct_sk_stream_memorystream_t = opaque {};
pub const sk_stream_memorystream_t = struct_sk_stream_memorystream_t;
pub const struct_sk_stream_streamrewindable_t = opaque {};
pub const sk_stream_streamrewindable_t = struct_sk_stream_streamrewindable_t;
pub const struct_sk_wstream_t = opaque {};
pub const sk_wstream_t = struct_sk_wstream_t;
pub const struct_sk_wstream_filestream_t = opaque {};
pub const sk_wstream_filestream_t = struct_sk_wstream_filestream_t;
pub const struct_sk_wstream_dynamicmemorystream_t = opaque {};
pub const sk_wstream_dynamicmemorystream_t = struct_sk_wstream_dynamicmemorystream_t;
pub const struct_sk_document_t = opaque {};
pub const sk_document_t = struct_sk_document_t;
pub const POINTS_SK_POINT_MODE: c_int = 0;
pub const LINES_SK_POINT_MODE: c_int = 1;
pub const POLYGON_SK_POINT_MODE: c_int = 2;
pub const sk_point_mode_t = c_uint;
pub const LEFT_SK_TEXT_ALIGN: c_int = 0;
pub const CENTER_SK_TEXT_ALIGN: c_int = 1;
pub const RIGHT_SK_TEXT_ALIGN: c_int = 2;
pub const sk_text_align_t = c_uint;
pub const UTF8_SK_TEXT_ENCODING: c_int = 0;
pub const UTF16_SK_TEXT_ENCODING: c_int = 1;
pub const UTF32_SK_TEXT_ENCODING: c_int = 2;
pub const GLYPH_ID_SK_TEXT_ENCODING: c_int = 3;
pub const sk_text_encoding_t = c_uint;
pub const WINDING_SK_PATH_FILLTYPE: c_int = 0;
pub const EVENODD_SK_PATH_FILLTYPE: c_int = 1;
pub const INVERSE_WINDING_SK_PATH_FILLTYPE: c_int = 2;
pub const INVERSE_EVENODD_SK_PATH_FILLTYPE: c_int = 3;
pub const sk_path_filltype_t = c_uint;
pub const UPRIGHT_SK_FONT_STYLE_SLANT: c_int = 0;
pub const ITALIC_SK_FONT_STYLE_SLANT: c_int = 1;
pub const OBLIQUE_SK_FONT_STYLE_SLANT: c_int = 2;
pub const sk_font_style_slant_t = c_uint;
pub const R_SK_COLOR_CHANNEL: c_int = 0;
pub const G_SK_COLOR_CHANNEL: c_int = 1;
pub const B_SK_COLOR_CHANNEL: c_int = 2;
pub const A_SK_COLOR_CHANNEL: c_int = 3;
pub const sk_color_channel_t = c_uint;
pub const DIFFERENCE_SK_REGION_OP: c_int = 0;
pub const INTERSECT_SK_REGION_OP: c_int = 1;
pub const UNION_SK_REGION_OP: c_int = 2;
pub const XOR_SK_REGION_OP: c_int = 3;
pub const REVERSE_DIFFERENCE_SK_REGION_OP: c_int = 4;
pub const REPLACE_SK_REGION_OP: c_int = 5;
pub const sk_region_op_t = c_uint;
pub const DIFFERENCE_SK_CLIPOP: c_int = 0;
pub const INTERSECT_SK_CLIPOP: c_int = 1;
pub const sk_clipop_t = c_uint;
pub const BMP_SK_ENCODED_FORMAT: c_int = 0;
pub const GIF_SK_ENCODED_FORMAT: c_int = 1;
pub const ICO_SK_ENCODED_FORMAT: c_int = 2;
pub const JPEG_SK_ENCODED_FORMAT: c_int = 3;
pub const PNG_SK_ENCODED_FORMAT: c_int = 4;
pub const WBMP_SK_ENCODED_FORMAT: c_int = 5;
pub const WEBP_SK_ENCODED_FORMAT: c_int = 6;
pub const PKM_SK_ENCODED_FORMAT: c_int = 7;
pub const KTX_SK_ENCODED_FORMAT: c_int = 8;
pub const ASTC_SK_ENCODED_FORMAT: c_int = 9;
pub const DNG_SK_ENCODED_FORMAT: c_int = 10;
pub const HEIF_SK_ENCODED_FORMAT: c_int = 11;
pub const AVIF_SK_ENCODED_FORMAT: c_int = 12;
pub const JPEGXL_SK_ENCODED_FORMAT: c_int = 13;
pub const sk_encoded_image_format_t = c_uint;
pub const TOP_LEFT_SK_ENCODED_ORIGIN: c_int = 1;
pub const TOP_RIGHT_SK_ENCODED_ORIGIN: c_int = 2;
pub const BOTTOM_RIGHT_SK_ENCODED_ORIGIN: c_int = 3;
pub const BOTTOM_LEFT_SK_ENCODED_ORIGIN: c_int = 4;
pub const LEFT_TOP_SK_ENCODED_ORIGIN: c_int = 5;
pub const RIGHT_TOP_SK_ENCODED_ORIGIN: c_int = 6;
pub const RIGHT_BOTTOM_SK_ENCODED_ORIGIN: c_int = 7;
pub const LEFT_BOTTOM_SK_ENCODED_ORIGIN: c_int = 8;
pub const DEFAULT_SK_ENCODED_ORIGIN: c_int = 1;
pub const sk_encodedorigin_t = c_uint;
pub const SUCCESS_SK_CODEC_RESULT: c_int = 0;
pub const INCOMPLETE_INPUT_SK_CODEC_RESULT: c_int = 1;
pub const ERROR_IN_INPUT_SK_CODEC_RESULT: c_int = 2;
pub const INVALID_CONVERSION_SK_CODEC_RESULT: c_int = 3;
pub const INVALID_SCALE_SK_CODEC_RESULT: c_int = 4;
pub const INVALID_PARAMETERS_SK_CODEC_RESULT: c_int = 5;
pub const INVALID_INPUT_SK_CODEC_RESULT: c_int = 6;
pub const COULD_NOT_REWIND_SK_CODEC_RESULT: c_int = 7;
pub const INTERNAL_ERROR_SK_CODEC_RESULT: c_int = 8;
pub const UNIMPLEMENTED_SK_CODEC_RESULT: c_int = 9;
pub const sk_codec_result_t = c_uint;
pub const YES_SK_CODEC_ZERO_INITIALIZED: c_int = 0;
pub const NO_SK_CODEC_ZERO_INITIALIZED: c_int = 1;
pub const sk_codec_zero_initialized_t = c_uint;
pub const sk_codec_options_t = extern struct {
    fZeroInitialized: sk_codec_zero_initialized_t = @import("std").mem.zeroes(sk_codec_zero_initialized_t),
    fSubset: [*c]sk_irect_t = @import("std").mem.zeroes([*c]sk_irect_t),
    fFrameIndex: c_int = @import("std").mem.zeroes(c_int),
    fPriorFrame: c_int = @import("std").mem.zeroes(c_int),
};
pub const TOP_DOWN_SK_CODEC_SCANLINE_ORDER: c_int = 0;
pub const BOTTOM_UP_SK_CODEC_SCANLINE_ORDER: c_int = 1;
pub const sk_codec_scanline_order_t = c_uint;
pub const MOVE_SK_PATH_VERB: c_int = 0;
pub const LINE_SK_PATH_VERB: c_int = 1;
pub const QUAD_SK_PATH_VERB: c_int = 2;
pub const CONIC_SK_PATH_VERB: c_int = 3;
pub const CUBIC_SK_PATH_VERB: c_int = 4;
pub const CLOSE_SK_PATH_VERB: c_int = 5;
pub const DONE_SK_PATH_VERB: c_int = 6;
pub const sk_path_verb_t = c_uint;
pub const struct_sk_path_iterator_t = opaque {};
pub const sk_path_iterator_t = struct_sk_path_iterator_t;
pub const struct_sk_path_rawiterator_t = opaque {};
pub const sk_path_rawiterator_t = struct_sk_path_rawiterator_t;
pub const APPEND_SK_PATH_ADD_MODE: c_int = 0;
pub const EXTEND_SK_PATH_ADD_MODE: c_int = 1;
pub const sk_path_add_mode_t = c_uint;
pub const LINE_SK_PATH_SEGMENT_MASK: c_int = 1;
pub const QUAD_SK_PATH_SEGMENT_MASK: c_int = 2;
pub const CONIC_SK_PATH_SEGMENT_MASK: c_int = 4;
pub const CUBIC_SK_PATH_SEGMENT_MASK: c_int = 8;
pub const sk_path_segment_mask_t = c_uint;
pub const TRANSLATE_SK_PATH_EFFECT_1D_STYLE: c_int = 0;
pub const ROTATE_SK_PATH_EFFECT_1D_STYLE: c_int = 1;
pub const MORPH_SK_PATH_EFFECT_1D_STYLE: c_int = 2;
pub const sk_path_effect_1d_style_t = c_uint;
pub const NORMAL_SK_PATH_EFFECT_TRIM_MODE: c_int = 0;
pub const INVERTED_SK_PATH_EFFECT_TRIM_MODE: c_int = 1;
pub const sk_path_effect_trim_mode_t = c_uint;
pub const struct_sk_path_effect_t = opaque {};
pub const sk_path_effect_t = struct_sk_path_effect_t;
pub const BUTT_SK_STROKE_CAP: c_int = 0;
pub const ROUND_SK_STROKE_CAP: c_int = 1;
pub const SQUARE_SK_STROKE_CAP: c_int = 2;
pub const sk_stroke_cap_t = c_uint;
pub const MITER_SK_STROKE_JOIN: c_int = 0;
pub const ROUND_SK_STROKE_JOIN: c_int = 1;
pub const BEVEL_SK_STROKE_JOIN: c_int = 2;
pub const sk_stroke_join_t = c_uint;
pub const CLAMP_SK_SHADER_TILEMODE: c_int = 0;
pub const REPEAT_SK_SHADER_TILEMODE: c_int = 1;
pub const MIRROR_SK_SHADER_TILEMODE: c_int = 2;
pub const DECAL_SK_SHADER_TILEMODE: c_int = 3;
pub const sk_shader_tilemode_t = c_uint;
pub const NORMAL_SK_BLUR_STYLE: c_int = 0;
pub const SOLID_SK_BLUR_STYLE: c_int = 1;
pub const OUTER_SK_BLUR_STYLE: c_int = 2;
pub const INNER_SK_BLUR_STYLE: c_int = 3;
pub const sk_blurstyle_t = c_uint;
pub const CW_SK_PATH_DIRECTION: c_int = 0;
pub const CCW_SK_PATH_DIRECTION: c_int = 1;
pub const sk_path_direction_t = c_uint;
pub const SMALL_SK_PATH_ARC_SIZE: c_int = 0;
pub const LARGE_SK_PATH_ARC_SIZE: c_int = 1;
pub const sk_path_arc_size_t = c_uint;
pub const FILL_SK_PAINT_STYLE: c_int = 0;
pub const STROKE_SK_PAINT_STYLE: c_int = 1;
pub const STROKE_AND_FILL_SK_PAINT_STYLE: c_int = 2;
pub const sk_paint_style_t = c_uint;
pub const NONE_SK_FONT_HINTING: c_int = 0;
pub const SLIGHT_SK_FONT_HINTING: c_int = 1;
pub const NORMAL_SK_FONT_HINTING: c_int = 2;
pub const FULL_SK_FONT_HINTING: c_int = 3;
pub const sk_font_hinting_t = c_uint;
pub const ALIAS_SK_FONT_EDGING: c_int = 0;
pub const ANTIALIAS_SK_FONT_EDGING: c_int = 1;
pub const SUBPIXEL_ANTIALIAS_SK_FONT_EDGING: c_int = 2;
pub const sk_font_edging_t = c_uint;
pub const struct_sk_pixelref_factory_t = opaque {};
pub const sk_pixelref_factory_t = struct_sk_pixelref_factory_t;
pub const TOP_LEFT_GR_SURFACE_ORIGIN: c_int = 0;
pub const BOTTOM_LEFT_GR_SURFACE_ORIGIN: c_int = 1;
pub const gr_surfaceorigin_t = c_uint;
pub const gr_context_options_t = extern struct {
    fAvoidStencilBuffers: bool = @import("std").mem.zeroes(bool),
    fRuntimeProgramCacheSize: c_int = @import("std").mem.zeroes(c_int),
    fGlyphCacheTextureMaximumBytes: usize = @import("std").mem.zeroes(usize),
    fAllowPathMaskCaching: bool = @import("std").mem.zeroes(bool),
    fDoManualMipmapping: bool = @import("std").mem.zeroes(bool),
    fBufferMapThreshold: c_int = @import("std").mem.zeroes(c_int),
};
pub const gr_backendobject_t = isize;
pub const struct_gr_backendrendertarget_t = opaque {};
pub const gr_backendrendertarget_t = struct_gr_backendrendertarget_t;
pub const struct_gr_backendtexture_t = opaque {};
pub const gr_backendtexture_t = struct_gr_backendtexture_t;
pub const struct_gr_direct_context_t = opaque {};
pub const gr_direct_context_t = struct_gr_direct_context_t;
pub const struct_gr_recording_context_t = opaque {};
pub const gr_recording_context_t = struct_gr_recording_context_t;
pub const OPENGL_GR_BACKEND: c_int = 0;
pub const VULKAN_GR_BACKEND: c_int = 1;
pub const METAL_GR_BACKEND: c_int = 2;
pub const DIRECT3D_GR_BACKEND: c_int = 3;
pub const DAWN_GR_BACKEND: c_int = 4;
pub const gr_backend_t = c_uint;
pub const gr_backendcontext_t = isize;
pub const struct_gr_glinterface_t = opaque {};
pub const gr_glinterface_t = struct_gr_glinterface_t;
pub const gr_gl_func_ptr = ?*const fn () callconv(.C) void;
pub const gr_gl_get_proc = ?*const fn (?*anyopaque, [*c]const u8) callconv(.C) gr_gl_func_ptr;
pub const gr_gl_textureinfo_t = extern struct {
    fTarget: c_uint = @import("std").mem.zeroes(c_uint),
    fID: c_uint = @import("std").mem.zeroes(c_uint),
    fFormat: c_uint = @import("std").mem.zeroes(c_uint),
    fProtected: bool = @import("std").mem.zeroes(bool),
};
pub const gr_gl_framebufferinfo_t = extern struct {
    fFBOID: c_uint = @import("std").mem.zeroes(c_uint),
    fFormat: c_uint = @import("std").mem.zeroes(c_uint),
    fProtected: bool = @import("std").mem.zeroes(bool),
};
pub const struct_vk_instance_t = opaque {};
pub const vk_instance_t = struct_vk_instance_t;
pub const struct_gr_vkinterface_t = opaque {};
pub const gr_vkinterface_t = struct_gr_vkinterface_t;
pub const struct_vk_physical_device_t = opaque {};
pub const vk_physical_device_t = struct_vk_physical_device_t;
pub const struct_vk_physical_device_features_t = opaque {};
pub const vk_physical_device_features_t = struct_vk_physical_device_features_t;
pub const struct_vk_physical_device_features_2_t = opaque {};
pub const vk_physical_device_features_2_t = struct_vk_physical_device_features_2_t;
pub const struct_vk_device_t = opaque {};
pub const vk_device_t = struct_vk_device_t;
pub const struct_vk_queue_t = opaque {};
pub const vk_queue_t = struct_vk_queue_t;
pub const struct_gr_vk_extensions_t = opaque {};
pub const gr_vk_extensions_t = struct_gr_vk_extensions_t;
pub const struct_gr_vk_memory_allocator_t = opaque {};
pub const gr_vk_memory_allocator_t = struct_gr_vk_memory_allocator_t;
pub const gr_vk_func_ptr = ?*const fn () callconv(.C) void;
pub const gr_vk_get_proc = ?*const fn (?*anyopaque, [*c]const u8, ?*vk_instance_t, ?*vk_device_t) callconv(.C) gr_vk_func_ptr;
pub const gr_vk_backendcontext_t = extern struct {
    fInstance: ?*vk_instance_t = @import("std").mem.zeroes(?*vk_instance_t),
    fPhysicalDevice: ?*vk_physical_device_t = @import("std").mem.zeroes(?*vk_physical_device_t),
    fDevice: ?*vk_device_t = @import("std").mem.zeroes(?*vk_device_t),
    fQueue: ?*vk_queue_t = @import("std").mem.zeroes(?*vk_queue_t),
    fGraphicsQueueIndex: u32 = @import("std").mem.zeroes(u32),
    fMinAPIVersion: u32 = @import("std").mem.zeroes(u32),
    fInstanceVersion: u32 = @import("std").mem.zeroes(u32),
    fMaxAPIVersion: u32 = @import("std").mem.zeroes(u32),
    fExtensions: u32 = @import("std").mem.zeroes(u32),
    fVkExtensions: ?*const gr_vk_extensions_t = @import("std").mem.zeroes(?*const gr_vk_extensions_t),
    fFeatures: u32 = @import("std").mem.zeroes(u32),
    fDeviceFeatures: ?*const vk_physical_device_features_t = @import("std").mem.zeroes(?*const vk_physical_device_features_t),
    fDeviceFeatures2: ?*const vk_physical_device_features_2_t = @import("std").mem.zeroes(?*const vk_physical_device_features_2_t),
    fMemoryAllocator: ?*gr_vk_memory_allocator_t = @import("std").mem.zeroes(?*gr_vk_memory_allocator_t),
    fGetProc: gr_vk_get_proc = @import("std").mem.zeroes(gr_vk_get_proc),
    fGetProcUserData: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    fOwnsInstanceAndDevice: bool = @import("std").mem.zeroes(bool),
    fProtectedContext: bool = @import("std").mem.zeroes(bool),
};
pub const gr_vk_backendmemory_t = isize;
pub const gr_vk_alloc_t = extern struct {
    fMemory: u64 = @import("std").mem.zeroes(u64),
    fOffset: u64 = @import("std").mem.zeroes(u64),
    fSize: u64 = @import("std").mem.zeroes(u64),
    fFlags: u32 = @import("std").mem.zeroes(u32),
    fBackendMemory: gr_vk_backendmemory_t = @import("std").mem.zeroes(gr_vk_backendmemory_t),
    _private_fUsesSystemHeap: bool = @import("std").mem.zeroes(bool),
};
pub const gr_vk_ycbcrconversioninfo_t = extern struct {
    fFormat: u32 = @import("std").mem.zeroes(u32),
    fExternalFormat: u64 = @import("std").mem.zeroes(u64),
    fYcbcrModel: u32 = @import("std").mem.zeroes(u32),
    fYcbcrRange: u32 = @import("std").mem.zeroes(u32),
    fXChromaOffset: u32 = @import("std").mem.zeroes(u32),
    fYChromaOffset: u32 = @import("std").mem.zeroes(u32),
    fChromaFilter: u32 = @import("std").mem.zeroes(u32),
    fForceExplicitReconstruction: u32 = @import("std").mem.zeroes(u32),
    fFormatFeatures: u32 = @import("std").mem.zeroes(u32),
};
pub const gr_vk_imageinfo_t = extern struct {
    fImage: u64 = @import("std").mem.zeroes(u64),
    fAlloc: gr_vk_alloc_t = @import("std").mem.zeroes(gr_vk_alloc_t),
    fImageTiling: u32 = @import("std").mem.zeroes(u32),
    fImageLayout: u32 = @import("std").mem.zeroes(u32),
    fFormat: u32 = @import("std").mem.zeroes(u32),
    fImageUsageFlags: u32 = @import("std").mem.zeroes(u32),
    fSampleCount: u32 = @import("std").mem.zeroes(u32),
    fLevelCount: u32 = @import("std").mem.zeroes(u32),
    fCurrentQueueFamily: u32 = @import("std").mem.zeroes(u32),
    fProtected: bool = @import("std").mem.zeroes(bool),
    fYcbcrConversionInfo: gr_vk_ycbcrconversioninfo_t = @import("std").mem.zeroes(gr_vk_ycbcrconversioninfo_t),
    fSharingMode: u32 = @import("std").mem.zeroes(u32),
};
pub const gr_mtl_textureinfo_t = extern struct {
    fTexture: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
};
pub const DIFFERENCE_SK_PATHOP: c_int = 0;
pub const INTERSECT_SK_PATHOP: c_int = 1;
pub const UNION_SK_PATHOP: c_int = 2;
pub const XOR_SK_PATHOP: c_int = 3;
pub const REVERSE_DIFFERENCE_SK_PATHOP: c_int = 4;
pub const sk_pathop_t = c_uint;
pub const struct_sk_opbuilder_t = opaque {};
pub const sk_opbuilder_t = struct_sk_opbuilder_t;
pub const DEFAULT_SK_LATTICE_RECT_TYPE: c_int = 0;
pub const TRANSPARENT_SK_LATTICE_RECT_TYPE: c_int = 1;
pub const FIXED_COLOR_SK_LATTICE_RECT_TYPE: c_int = 2;
pub const sk_lattice_recttype_t = c_uint;
pub const sk_lattice_t = extern struct {
    fXDivs: [*c]const c_int = @import("std").mem.zeroes([*c]const c_int),
    fYDivs: [*c]const c_int = @import("std").mem.zeroes([*c]const c_int),
    fRectTypes: [*c]const sk_lattice_recttype_t = @import("std").mem.zeroes([*c]const sk_lattice_recttype_t),
    fXCount: c_int = @import("std").mem.zeroes(c_int),
    fYCount: c_int = @import("std").mem.zeroes(c_int),
    fBounds: [*c]const sk_irect_t = @import("std").mem.zeroes([*c]const sk_irect_t),
    fColors: [*c]const sk_color_t = @import("std").mem.zeroes([*c]const sk_color_t),
};
pub const struct_sk_pathmeasure_t = opaque {};
pub const sk_pathmeasure_t = struct_sk_pathmeasure_t;
pub const GET_POSITION_SK_PATHMEASURE_MATRIXFLAGS: c_int = 1;
pub const GET_TANGENT_SK_PATHMEASURE_MATRIXFLAGS: c_int = 2;
pub const GET_POS_AND_TAN_SK_PATHMEASURE_MATRIXFLAGS: c_int = 3;
pub const sk_pathmeasure_matrixflags_t = c_uint;
pub const sk_bitmap_release_proc = ?*const fn (?*anyopaque, ?*anyopaque) callconv(.C) void;
pub const sk_data_release_proc = ?*const fn (?*const anyopaque, ?*anyopaque) callconv(.C) void;
pub const sk_image_raster_release_proc = ?*const fn (?*const anyopaque, ?*anyopaque) callconv(.C) void;
pub const sk_image_texture_release_proc = ?*const fn (?*anyopaque) callconv(.C) void;
pub const sk_surface_raster_release_proc = ?*const fn (?*anyopaque, ?*anyopaque) callconv(.C) void;
pub const sk_glyph_path_proc = ?*const fn (?*const sk_path_t, [*c]const sk_matrix_t, ?*anyopaque) callconv(.C) void;
pub const ALLOW_SK_IMAGE_CACHING_HINT: c_int = 0;
pub const DISALLOW_SK_IMAGE_CACHING_HINT: c_int = 1;
pub const sk_image_caching_hint_t = c_uint;
pub const NONE_SK_BITMAP_ALLOC_FLAGS: c_int = 0;
pub const ZERO_PIXELS_SK_BITMAP_ALLOC_FLAGS: c_int = 1;
pub const sk_bitmap_allocflags_t = c_uint;
pub const sk_time_datetime_t = extern struct {
    fTimeZoneMinutes: i16 = @import("std").mem.zeroes(i16),
    fYear: u16 = @import("std").mem.zeroes(u16),
    fMonth: u8 = @import("std").mem.zeroes(u8),
    fDayOfWeek: u8 = @import("std").mem.zeroes(u8),
    fDay: u8 = @import("std").mem.zeroes(u8),
    fHour: u8 = @import("std").mem.zeroes(u8),
    fMinute: u8 = @import("std").mem.zeroes(u8),
    fSecond: u8 = @import("std").mem.zeroes(u8),
};
pub const sk_document_pdf_metadata_t = extern struct {
    fTitle: ?*sk_string_t = @import("std").mem.zeroes(?*sk_string_t),
    fAuthor: ?*sk_string_t = @import("std").mem.zeroes(?*sk_string_t),
    fSubject: ?*sk_string_t = @import("std").mem.zeroes(?*sk_string_t),
    fKeywords: ?*sk_string_t = @import("std").mem.zeroes(?*sk_string_t),
    fCreator: ?*sk_string_t = @import("std").mem.zeroes(?*sk_string_t),
    fProducer: ?*sk_string_t = @import("std").mem.zeroes(?*sk_string_t),
    fCreation: [*c]sk_time_datetime_t = @import("std").mem.zeroes([*c]sk_time_datetime_t),
    fModified: [*c]sk_time_datetime_t = @import("std").mem.zeroes([*c]sk_time_datetime_t),
    fRasterDPI: f32 = @import("std").mem.zeroes(f32),
    fPDFA: bool = @import("std").mem.zeroes(bool),
    fEncodingQuality: c_int = @import("std").mem.zeroes(c_int),
};
pub const sk_imageinfo_t = extern struct {
    colorspace: ?*sk_colorspace_t = @import("std").mem.zeroes(?*sk_colorspace_t),
    width: i32 = @import("std").mem.zeroes(i32),
    height: i32 = @import("std").mem.zeroes(i32),
    colorType: sk_colortype_t = @import("std").mem.zeroes(sk_colortype_t),
    alphaType: sk_alphatype_t = @import("std").mem.zeroes(sk_alphatype_t),
};
pub const KEEP_SK_CODEC_ANIMATION_DISPOSAL_METHOD: c_int = 1;
pub const RESTORE_BG_COLOR_SK_CODEC_ANIMATION_DISPOSAL_METHOD: c_int = 2;
pub const RESTORE_PREVIOUS_SK_CODEC_ANIMATION_DISPOSAL_METHOD: c_int = 3;
pub const sk_codecanimation_disposalmethod_t = c_uint;
pub const SRC_OVER_SK_CODEC_ANIMATION_BLEND: c_int = 0;
pub const SRC_SK_CODEC_ANIMATION_BLEND: c_int = 1;
pub const sk_codecanimation_blend_t = c_uint;
pub const sk_codec_frameinfo_t = extern struct {
    fRequiredFrame: c_int = @import("std").mem.zeroes(c_int),
    fDuration: c_int = @import("std").mem.zeroes(c_int),
    fFullyReceived: bool = @import("std").mem.zeroes(bool),
    fAlphaType: sk_alphatype_t = @import("std").mem.zeroes(sk_alphatype_t),
    fHasAlphaWithinBounds: bool = @import("std").mem.zeroes(bool),
    fDisposalMethod: sk_codecanimation_disposalmethod_t = @import("std").mem.zeroes(sk_codecanimation_disposalmethod_t),
    fBlend: sk_codecanimation_blend_t = @import("std").mem.zeroes(sk_codecanimation_blend_t),
    fFrameRect: sk_irect_t = @import("std").mem.zeroes(sk_irect_t),
};
pub const struct_sk_svgcanvas_t = opaque {};
pub const sk_svgcanvas_t = struct_sk_svgcanvas_t;
pub const TRIANGLES_SK_VERTICES_VERTEX_MODE: c_int = 0;
pub const TRIANGLE_STRIP_SK_VERTICES_VERTEX_MODE: c_int = 1;
pub const TRIANGLE_FAN_SK_VERTICES_VERTEX_MODE: c_int = 2;
pub const sk_vertices_vertex_mode_t = c_uint;
pub const struct_sk_vertices_t = opaque {};
pub const sk_vertices_t = struct_sk_vertices_t;
pub const struct_sk_colorspace_transfer_fn_t = extern struct {
    fG: f32 = @import("std").mem.zeroes(f32),
    fA: f32 = @import("std").mem.zeroes(f32),
    fB: f32 = @import("std").mem.zeroes(f32),
    fC: f32 = @import("std").mem.zeroes(f32),
    fD: f32 = @import("std").mem.zeroes(f32),
    fE: f32 = @import("std").mem.zeroes(f32),
    fF: f32 = @import("std").mem.zeroes(f32),
};
pub const sk_colorspace_transfer_fn_t = struct_sk_colorspace_transfer_fn_t;
pub const struct_sk_colorspace_primaries_t = extern struct {
    fRX: f32 = @import("std").mem.zeroes(f32),
    fRY: f32 = @import("std").mem.zeroes(f32),
    fGX: f32 = @import("std").mem.zeroes(f32),
    fGY: f32 = @import("std").mem.zeroes(f32),
    fBX: f32 = @import("std").mem.zeroes(f32),
    fBY: f32 = @import("std").mem.zeroes(f32),
    fWX: f32 = @import("std").mem.zeroes(f32),
    fWY: f32 = @import("std").mem.zeroes(f32),
};
pub const sk_colorspace_primaries_t = struct_sk_colorspace_primaries_t;
pub const struct_sk_colorspace_xyz_t = extern struct {
    fM00: f32 = @import("std").mem.zeroes(f32),
    fM01: f32 = @import("std").mem.zeroes(f32),
    fM02: f32 = @import("std").mem.zeroes(f32),
    fM10: f32 = @import("std").mem.zeroes(f32),
    fM11: f32 = @import("std").mem.zeroes(f32),
    fM12: f32 = @import("std").mem.zeroes(f32),
    fM20: f32 = @import("std").mem.zeroes(f32),
    fM21: f32 = @import("std").mem.zeroes(f32),
    fM22: f32 = @import("std").mem.zeroes(f32),
};
pub const sk_colorspace_xyz_t = struct_sk_colorspace_xyz_t;
pub const struct_sk_colorspace_icc_profile_t = opaque {};
pub const sk_colorspace_icc_profile_t = struct_sk_colorspace_icc_profile_t;
pub const NO_INVERT_SK_HIGH_CONTRAST_CONFIG_INVERT_STYLE: c_int = 0;
pub const INVERT_BRIGHTNESS_SK_HIGH_CONTRAST_CONFIG_INVERT_STYLE: c_int = 1;
pub const INVERT_LIGHTNESS_SK_HIGH_CONTRAST_CONFIG_INVERT_STYLE: c_int = 2;
pub const sk_highcontrastconfig_invertstyle_t = c_uint;
pub const sk_highcontrastconfig_t = extern struct {
    fGrayscale: bool = @import("std").mem.zeroes(bool),
    fInvertStyle: sk_highcontrastconfig_invertstyle_t = @import("std").mem.zeroes(sk_highcontrastconfig_invertstyle_t),
    fContrast: f32 = @import("std").mem.zeroes(f32),
};
pub const ZERO_SK_PNGENCODER_FILTER_FLAGS: c_int = 0;
pub const NONE_SK_PNGENCODER_FILTER_FLAGS: c_int = 8;
pub const SUB_SK_PNGENCODER_FILTER_FLAGS: c_int = 16;
pub const UP_SK_PNGENCODER_FILTER_FLAGS: c_int = 32;
pub const AVG_SK_PNGENCODER_FILTER_FLAGS: c_int = 64;
pub const PAETH_SK_PNGENCODER_FILTER_FLAGS: c_int = 128;
pub const ALL_SK_PNGENCODER_FILTER_FLAGS: c_int = 248;
pub const sk_pngencoder_filterflags_t = c_uint;
pub const sk_pngencoder_options_t = extern struct {
    fFilterFlags: sk_pngencoder_filterflags_t = @import("std").mem.zeroes(sk_pngencoder_filterflags_t),
    fZLibLevel: c_int = @import("std").mem.zeroes(c_int),
    fComments: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    fICCProfile: ?*const sk_colorspace_icc_profile_t = @import("std").mem.zeroes(?*const sk_colorspace_icc_profile_t),
    fICCProfileDescription: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const DOWNSAMPLE_420_SK_JPEGENCODER_DOWNSAMPLE: c_int = 0;
pub const DOWNSAMPLE_422_SK_JPEGENCODER_DOWNSAMPLE: c_int = 1;
pub const DOWNSAMPLE_444_SK_JPEGENCODER_DOWNSAMPLE: c_int = 2;
pub const sk_jpegencoder_downsample_t = c_uint;
pub const IGNORE_SK_JPEGENCODER_ALPHA_OPTION: c_int = 0;
pub const BLEND_ON_BLACK_SK_JPEGENCODER_ALPHA_OPTION: c_int = 1;
pub const sk_jpegencoder_alphaoption_t = c_uint;
pub const sk_jpegencoder_options_t = extern struct {
    fQuality: c_int = @import("std").mem.zeroes(c_int),
    fDownsample: sk_jpegencoder_downsample_t = @import("std").mem.zeroes(sk_jpegencoder_downsample_t),
    fAlphaOption: sk_jpegencoder_alphaoption_t = @import("std").mem.zeroes(sk_jpegencoder_alphaoption_t),
    xmpMetadata: ?*const sk_data_t = @import("std").mem.zeroes(?*const sk_data_t),
    fICCProfile: ?*const sk_colorspace_icc_profile_t = @import("std").mem.zeroes(?*const sk_colorspace_icc_profile_t),
    fICCProfileDescription: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const LOSSY_SK_WEBPENCODER_COMPTRESSION: c_int = 0;
pub const LOSSLESS_SK_WEBPENCODER_COMPTRESSION: c_int = 1;
pub const sk_webpencoder_compression_t = c_uint;
pub const sk_webpencoder_options_t = extern struct {
    fCompression: sk_webpencoder_compression_t = @import("std").mem.zeroes(sk_webpencoder_compression_t),
    fQuality: f32 = @import("std").mem.zeroes(f32),
    fICCProfile: ?*const sk_colorspace_icc_profile_t = @import("std").mem.zeroes(?*const sk_colorspace_icc_profile_t),
    fICCProfileDescription: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const struct_sk_rrect_t = opaque {};
pub const sk_rrect_t = struct_sk_rrect_t;
pub const EMPTY_SK_RRECT_TYPE: c_int = 0;
pub const RECT_SK_RRECT_TYPE: c_int = 1;
pub const OVAL_SK_RRECT_TYPE: c_int = 2;
pub const SIMPLE_SK_RRECT_TYPE: c_int = 3;
pub const NINE_PATCH_SK_RRECT_TYPE: c_int = 4;
pub const COMPLEX_SK_RRECT_TYPE: c_int = 5;
pub const sk_rrect_type_t = c_uint;
pub const UPPER_LEFT_SK_RRECT_CORNER: c_int = 0;
pub const UPPER_RIGHT_SK_RRECT_CORNER: c_int = 1;
pub const LOWER_RIGHT_SK_RRECT_CORNER: c_int = 2;
pub const LOWER_LEFT_SK_RRECT_CORNER: c_int = 3;
pub const sk_rrect_corner_t = c_uint;
pub const struct_sk_textblob_t = opaque {};
pub const sk_textblob_t = struct_sk_textblob_t;
pub const struct_sk_textblob_builder_t = opaque {};
pub const sk_textblob_builder_t = struct_sk_textblob_builder_t;
pub const sk_textblob_builder_runbuffer_t = extern struct {
    glyphs: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    pos: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    utf8text: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    clusters: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const sk_rsxform_t = extern struct {
    fSCos: f32 = @import("std").mem.zeroes(f32),
    fSSin: f32 = @import("std").mem.zeroes(f32),
    fTX: f32 = @import("std").mem.zeroes(f32),
    fTY: f32 = @import("std").mem.zeroes(f32),
};
pub const struct_sk_tracememorydump_t = opaque {};
pub const sk_tracememorydump_t = struct_sk_tracememorydump_t;
pub const struct_sk_runtimeeffect_t = opaque {};
pub const sk_runtimeeffect_t = struct_sk_runtimeeffect_t;
pub const FLOAT_SK_RUNTIMEEFFECT_UNIFORM_TYPE: c_int = 0;
pub const FLOAT2_SK_RUNTIMEEFFECT_UNIFORM_TYPE: c_int = 1;
pub const FLOAT3_SK_RUNTIMEEFFECT_UNIFORM_TYPE: c_int = 2;
pub const FLOAT4_SK_RUNTIMEEFFECT_UNIFORM_TYPE: c_int = 3;
pub const FLOAT2X2_SK_RUNTIMEEFFECT_UNIFORM_TYPE: c_int = 4;
pub const FLOAT3X3_SK_RUNTIMEEFFECT_UNIFORM_TYPE: c_int = 5;
pub const FLOAT4X4_SK_RUNTIMEEFFECT_UNIFORM_TYPE: c_int = 6;
pub const INT_SK_RUNTIMEEFFECT_UNIFORM_TYPE: c_int = 7;
pub const INT2_SK_RUNTIMEEFFECT_UNIFORM_TYPE: c_int = 8;
pub const INT3_SK_RUNTIMEEFFECT_UNIFORM_TYPE: c_int = 9;
pub const INT4_SK_RUNTIMEEFFECT_UNIFORM_TYPE: c_int = 10;
pub const sk_runtimeeffect_uniform_type_t = c_uint;
pub const SHADER_SK_RUNTIMEEFFECT_CHILD_TYPE: c_int = 0;
pub const COLOR_FILTER_SK_RUNTIMEEFFECT_CHILD_TYPE: c_int = 1;
pub const BLENDER_SK_RUNTIMEEFFECT_CHILD_TYPE: c_int = 2;
pub const sk_runtimeeffect_child_type_t = c_uint;
pub const NONE_SK_RUNTIMEEFFECT_UNIFORM_FLAGS: c_int = 0;
pub const ARRAY_SK_RUNTIMEEFFECT_UNIFORM_FLAGS: c_int = 1;
pub const COLOR_SK_RUNTIMEEFFECT_UNIFORM_FLAGS: c_int = 2;
pub const VERTEX_SK_RUNTIMEEFFECT_UNIFORM_FLAGS: c_int = 4;
pub const FRAGMENT_SK_RUNTIMEEFFECT_UNIFORM_FLAGS: c_int = 8;
pub const HALF_PRECISION_SK_RUNTIMEEFFECT_UNIFORM_FLAGS: c_int = 16;
pub const sk_runtimeeffect_uniform_flags_t = c_uint;
pub const sk_runtimeeffect_uniform_t = extern struct {
    fName: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    fNameLength: usize = @import("std").mem.zeroes(usize),
    fOffset: usize = @import("std").mem.zeroes(usize),
    fType: sk_runtimeeffect_uniform_type_t = @import("std").mem.zeroes(sk_runtimeeffect_uniform_type_t),
    fCount: c_int = @import("std").mem.zeroes(c_int),
    fFlags: sk_runtimeeffect_uniform_flags_t = @import("std").mem.zeroes(sk_runtimeeffect_uniform_flags_t),
};
pub const sk_runtimeeffect_child_t = extern struct {
    fName: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    fNameLength: usize = @import("std").mem.zeroes(usize),
    fType: sk_runtimeeffect_child_type_t = @import("std").mem.zeroes(sk_runtimeeffect_child_type_t),
    fIndex: c_int = @import("std").mem.zeroes(c_int),
};
pub const NEAREST_SK_FILTER_MODE: c_int = 0;
pub const LINEAR_SK_FILTER_MODE: c_int = 1;
pub const sk_filter_mode_t = c_uint;
pub const NONE_SK_MIPMAP_MODE: c_int = 0;
pub const NEAREST_SK_MIPMAP_MODE: c_int = 1;
pub const LINEAR_SK_MIPMAP_MODE: c_int = 2;
pub const sk_mipmap_mode_t = c_uint;
pub const sk_cubic_resampler_t = extern struct {
    fB: f32 = @import("std").mem.zeroes(f32),
    fC: f32 = @import("std").mem.zeroes(f32),
};
pub const sk_sampling_options_t = extern struct {
    fMaxAniso: c_int = @import("std").mem.zeroes(c_int),
    fUseCubic: bool = @import("std").mem.zeroes(bool),
    fCubic: sk_cubic_resampler_t = @import("std").mem.zeroes(sk_cubic_resampler_t),
    fFilter: sk_filter_mode_t = @import("std").mem.zeroes(sk_filter_mode_t),
    fMipmap: sk_mipmap_mode_t = @import("std").mem.zeroes(sk_mipmap_mode_t),
};
pub const struct_skottie_animation_t = opaque {};
pub const skottie_animation_t = struct_skottie_animation_t;
pub const struct_skottie_animation_builder_t = opaque {};
pub const skottie_animation_builder_t = struct_skottie_animation_builder_t;
pub const struct_skottie_resource_provider_t = opaque {};
pub const skottie_resource_provider_t = struct_skottie_resource_provider_t;
pub const struct_skottie_property_observer_t = opaque {};
pub const skottie_property_observer_t = struct_skottie_property_observer_t;
pub const struct_skottie_logger_t = opaque {};
pub const skottie_logger_t = struct_skottie_logger_t;
pub const struct_skottie_marker_observer_t = opaque {};
pub const skottie_marker_observer_t = struct_skottie_marker_observer_t;
pub const struct_sksg_invalidation_controller_t = opaque {};
pub const sksg_invalidation_controller_t = struct_sksg_invalidation_controller_t;
pub const SKIP_TOP_LEVEL_ISOLATION: c_int = 1;
pub const DISABLE_TOP_LEVEL_CLIPPING: c_int = 2;
pub const skottie_animation_renderflags_t = c_uint;
pub const NONE_SKOTTIE_ANIMATION_BUILDER_FLAGS: c_int = 0;
pub const DEFER_IMAGE_LOADING_SKOTTIE_ANIMATION_BUILDER_FLAGS: c_int = 1;
pub const PREFER_EMBEDDED_FONTS_SKOTTIE_ANIMATION_BUILDER_FLAGS: c_int = 2;
pub const skottie_animation_builder_flags_t = c_uint;
pub const skottie_animation_builder_stats_t = extern struct {
    fTotalLoadTimeMS: f32 = @import("std").mem.zeroes(f32),
    fJsonParseTimeMS: f32 = @import("std").mem.zeroes(f32),
    fSceneParseTimeMS: f32 = @import("std").mem.zeroes(f32),
    fJsonSize: usize = @import("std").mem.zeroes(usize),
    fAnimatorCount: usize = @import("std").mem.zeroes(usize),
};
pub const struct_skresources_image_asset_t = opaque {};
pub const skresources_image_asset_t = struct_skresources_image_asset_t;
pub const struct_skresources_multi_frame_image_asset_t = opaque {};
pub const skresources_multi_frame_image_asset_t = struct_skresources_multi_frame_image_asset_t;
pub const struct_skresources_external_track_asset_t = opaque {};
pub const skresources_external_track_asset_t = struct_skresources_external_track_asset_t;
pub const struct_skresources_resource_provider_t = opaque {};
pub const skresources_resource_provider_t = struct_skresources_resource_provider_t;
pub extern fn gr_recording_context_unref(context: ?*gr_recording_context_t) void;
pub extern fn gr_recording_context_get_max_surface_sample_count_for_color_type(context: ?*gr_recording_context_t, colorType: sk_colortype_t) c_int;
pub extern fn gr_recording_context_get_backend(context: ?*gr_recording_context_t) gr_backend_t;
pub extern fn gr_recording_context_is_abandoned(context: ?*gr_recording_context_t) bool;
pub extern fn gr_recording_context_max_texture_size(context: ?*gr_recording_context_t) c_int;
pub extern fn gr_recording_context_max_render_target_size(context: ?*gr_recording_context_t) c_int;
pub extern fn gr_direct_context_make_gl(glInterface: ?*const gr_glinterface_t) ?*gr_direct_context_t;
pub extern fn gr_direct_context_make_gl_with_options(glInterface: ?*const gr_glinterface_t, options: [*c]const gr_context_options_t) ?*gr_direct_context_t;
pub extern fn gr_direct_context_make_vulkan(vkBackendContext: gr_vk_backendcontext_t) ?*gr_direct_context_t;
pub extern fn gr_direct_context_make_vulkan_with_options(vkBackendContext: gr_vk_backendcontext_t, options: [*c]const gr_context_options_t) ?*gr_direct_context_t;
pub extern fn gr_direct_context_make_metal(device: ?*anyopaque, queue: ?*anyopaque) ?*gr_direct_context_t;
pub extern fn gr_direct_context_make_metal_with_options(device: ?*anyopaque, queue: ?*anyopaque, options: [*c]const gr_context_options_t) ?*gr_direct_context_t;
pub extern fn gr_direct_context_is_abandoned(context: ?*gr_direct_context_t) bool;
pub extern fn gr_direct_context_abandon_context(context: ?*gr_direct_context_t) void;
pub extern fn gr_direct_context_release_resources_and_abandon_context(context: ?*gr_direct_context_t) void;
pub extern fn gr_direct_context_get_resource_cache_limit(context: ?*gr_direct_context_t) usize;
pub extern fn gr_direct_context_set_resource_cache_limit(context: ?*gr_direct_context_t, maxResourceBytes: usize) void;
pub extern fn gr_direct_context_get_resource_cache_usage(context: ?*gr_direct_context_t, maxResources: [*c]c_int, maxResourceBytes: [*c]usize) void;
pub extern fn gr_direct_context_flush(context: ?*gr_direct_context_t) void;
pub extern fn gr_direct_context_submit(context: ?*gr_direct_context_t, syncCpu: bool) bool;
pub extern fn gr_direct_context_flush_and_submit(context: ?*gr_direct_context_t, syncCpu: bool) void;
pub extern fn gr_direct_context_flush_image(context: ?*gr_direct_context_t, image: ?*const sk_image_t) void;
pub extern fn gr_direct_context_flush_surface(context: ?*gr_direct_context_t, surface: ?*sk_surface_t) void;
pub extern fn gr_direct_context_reset_context(context: ?*gr_direct_context_t, state: u32) void;
pub extern fn gr_direct_context_dump_memory_statistics(context: ?*const gr_direct_context_t, dump: ?*sk_tracememorydump_t) void;
pub extern fn gr_direct_context_free_gpu_resources(context: ?*gr_direct_context_t) void;
pub extern fn gr_direct_context_perform_deferred_cleanup(context: ?*gr_direct_context_t, ms: c_longlong) void;
pub extern fn gr_direct_context_purge_unlocked_resources_bytes(context: ?*gr_direct_context_t, bytesToPurge: usize, preferScratchResources: bool) void;
pub extern fn gr_direct_context_purge_unlocked_resources(context: ?*gr_direct_context_t, scratchResourcesOnly: bool) void;
pub extern fn gr_glinterface_create_native_interface() ?*const gr_glinterface_t;
pub extern fn gr_glinterface_assemble_interface(ctx: ?*anyopaque, get: gr_gl_get_proc) ?*const gr_glinterface_t;
pub extern fn gr_glinterface_assemble_gl_interface(ctx: ?*anyopaque, get: gr_gl_get_proc) ?*const gr_glinterface_t;
pub extern fn gr_glinterface_assemble_gles_interface(ctx: ?*anyopaque, get: gr_gl_get_proc) ?*const gr_glinterface_t;
pub extern fn gr_glinterface_assemble_webgl_interface(ctx: ?*anyopaque, get: gr_gl_get_proc) ?*const gr_glinterface_t;
pub extern fn gr_glinterface_unref(glInterface: ?*const gr_glinterface_t) void;
pub extern fn gr_glinterface_validate(glInterface: ?*const gr_glinterface_t) bool;
pub extern fn gr_glinterface_has_extension(glInterface: ?*const gr_glinterface_t, extension: [*c]const u8) bool;
pub extern fn gr_vk_extensions_new() ?*gr_vk_extensions_t;
pub extern fn gr_vk_extensions_delete(extensions: ?*gr_vk_extensions_t) void;
pub extern fn gr_vk_extensions_init(extensions: ?*gr_vk_extensions_t, getProc: gr_vk_get_proc, userData: ?*anyopaque, instance: ?*vk_instance_t, physDev: ?*vk_physical_device_t, instanceExtensionCount: u32, instanceExtensions: [*c][*c]const u8, deviceExtensionCount: u32, deviceExtensions: [*c][*c]const u8) void;
pub extern fn gr_vk_extensions_has_extension(extensions: ?*gr_vk_extensions_t, ext: [*c]const u8, minVersion: u32) bool;
pub extern fn gr_backendtexture_new_gl(width: c_int, height: c_int, mipmapped: bool, glInfo: [*c]const gr_gl_textureinfo_t) ?*gr_backendtexture_t;
pub extern fn gr_backendtexture_new_vulkan(width: c_int, height: c_int, vkInfo: [*c]const gr_vk_imageinfo_t) ?*gr_backendtexture_t;
pub extern fn gr_backendtexture_new_metal(width: c_int, height: c_int, mipmapped: bool, mtlInfo: [*c]const gr_mtl_textureinfo_t) ?*gr_backendtexture_t;
pub extern fn gr_backendtexture_delete(texture: ?*gr_backendtexture_t) void;
pub extern fn gr_backendtexture_is_valid(texture: ?*const gr_backendtexture_t) bool;
pub extern fn gr_backendtexture_get_width(texture: ?*const gr_backendtexture_t) c_int;
pub extern fn gr_backendtexture_get_height(texture: ?*const gr_backendtexture_t) c_int;
pub extern fn gr_backendtexture_has_mipmaps(texture: ?*const gr_backendtexture_t) bool;
pub extern fn gr_backendtexture_get_backend(texture: ?*const gr_backendtexture_t) gr_backend_t;
pub extern fn gr_backendtexture_get_gl_textureinfo(texture: ?*const gr_backendtexture_t, glInfo: [*c]gr_gl_textureinfo_t) bool;
pub extern fn gr_backendrendertarget_new_gl(width: c_int, height: c_int, samples: c_int, stencils: c_int, glInfo: [*c]const gr_gl_framebufferinfo_t) ?*gr_backendrendertarget_t;
pub extern fn gr_backendrendertarget_new_vulkan(width: c_int, height: c_int, samples: c_int, vkImageInfo: [*c]const gr_vk_imageinfo_t) ?*gr_backendrendertarget_t;
pub extern fn gr_backendrendertarget_new_metal(width: c_int, height: c_int, samples: c_int, mtlInfo: [*c]const gr_mtl_textureinfo_t) ?*gr_backendrendertarget_t;
pub extern fn gr_backendrendertarget_delete(rendertarget: ?*gr_backendrendertarget_t) void;
pub extern fn gr_backendrendertarget_is_valid(rendertarget: ?*const gr_backendrendertarget_t) bool;
pub extern fn gr_backendrendertarget_get_width(rendertarget: ?*const gr_backendrendertarget_t) c_int;
pub extern fn gr_backendrendertarget_get_height(rendertarget: ?*const gr_backendrendertarget_t) c_int;
pub extern fn gr_backendrendertarget_get_samples(rendertarget: ?*const gr_backendrendertarget_t) c_int;
pub extern fn gr_backendrendertarget_get_stencils(rendertarget: ?*const gr_backendrendertarget_t) c_int;
pub extern fn gr_backendrendertarget_get_backend(rendertarget: ?*const gr_backendrendertarget_t) gr_backend_t;
pub extern fn gr_backendrendertarget_get_gl_framebufferinfo(rendertarget: ?*const gr_backendrendertarget_t, glInfo: [*c]gr_gl_framebufferinfo_t) bool;
pub extern fn sk_canvas_destroy(ccanvas: ?*sk_canvas_t) void;
pub extern fn sk_canvas_clear(ccanvas: ?*sk_canvas_t, color: sk_color_t) void;
pub extern fn sk_canvas_clear_color4f(ccanvas: ?*sk_canvas_t, color: sk_color4f_t) void;
pub extern fn sk_canvas_discard(ccanvas: ?*sk_canvas_t) void;
pub extern fn sk_canvas_get_save_count(ccanvas: ?*sk_canvas_t) c_int;
pub extern fn sk_canvas_restore_to_count(ccanvas: ?*sk_canvas_t, saveCount: c_int) void;
pub extern fn sk_canvas_draw_color(ccanvas: ?*sk_canvas_t, color: sk_color_t, cmode: sk_blendmode_t) void;
pub extern fn sk_canvas_draw_color4f(ccanvas: ?*sk_canvas_t, color: sk_color4f_t, cmode: sk_blendmode_t) void;
pub extern fn sk_canvas_draw_points(ccanvas: ?*sk_canvas_t, pointMode: sk_point_mode_t, count: usize, points: [*c]const sk_point_t, cpaint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_point(ccanvas: ?*sk_canvas_t, x: f32, y: f32, cpaint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_line(ccanvas: ?*sk_canvas_t, x0: f32, y0: f32, x1: f32, y1: f32, cpaint: ?*sk_paint_t) void;
pub extern fn sk_canvas_draw_simple_text(ccanvas: ?*sk_canvas_t, text: ?*const anyopaque, byte_length: usize, encoding: sk_text_encoding_t, x: f32, y: f32, cfont: ?*const sk_font_t, cpaint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_text_blob(ccanvas: ?*sk_canvas_t, text: ?*sk_textblob_t, x: f32, y: f32, cpaint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_reset_matrix(ccanvas: ?*sk_canvas_t) void;
pub extern fn sk_canvas_set_matrix(ccanvas: ?*sk_canvas_t, cmatrix: [*c]const sk_matrix44_t) void;
pub extern fn sk_canvas_get_matrix(ccanvas: ?*sk_canvas_t, cmatrix: [*c]sk_matrix44_t) void;
pub extern fn sk_canvas_draw_round_rect(ccanvas: ?*sk_canvas_t, crect: [*c]const sk_rect_t, rx: f32, ry: f32, cpaint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_clip_rect_with_operation(ccanvas: ?*sk_canvas_t, crect: [*c]const sk_rect_t, op: sk_clipop_t, doAA: bool) void;
pub extern fn sk_canvas_clip_path_with_operation(ccanvas: ?*sk_canvas_t, cpath: ?*const sk_path_t, op: sk_clipop_t, doAA: bool) void;
pub extern fn sk_canvas_clip_rrect_with_operation(ccanvas: ?*sk_canvas_t, crect: ?*const sk_rrect_t, op: sk_clipop_t, doAA: bool) void;
pub extern fn sk_canvas_get_local_clip_bounds(ccanvas: ?*sk_canvas_t, cbounds: [*c]sk_rect_t) bool;
pub extern fn sk_canvas_get_device_clip_bounds(ccanvas: ?*sk_canvas_t, cbounds: [*c]sk_irect_t) bool;
pub extern fn sk_canvas_save(ccanvas: ?*sk_canvas_t) c_int;
pub extern fn sk_canvas_save_layer(ccanvas: ?*sk_canvas_t, crect: [*c]const sk_rect_t, cpaint: ?*const sk_paint_t) c_int;
pub extern fn sk_canvas_restore(ccanvas: ?*sk_canvas_t) void;
pub extern fn sk_canvas_translate(ccanvas: ?*sk_canvas_t, dx: f32, dy: f32) void;
pub extern fn sk_canvas_scale(ccanvas: ?*sk_canvas_t, sx: f32, sy: f32) void;
pub extern fn sk_canvas_rotate_degrees(ccanvas: ?*sk_canvas_t, degrees: f32) void;
pub extern fn sk_canvas_rotate_radians(ccanvas: ?*sk_canvas_t, radians: f32) void;
pub extern fn sk_canvas_skew(ccanvas: ?*sk_canvas_t, sx: f32, sy: f32) void;
pub extern fn sk_canvas_concat(ccanvas: ?*sk_canvas_t, cmatrix: [*c]const sk_matrix44_t) void;
pub extern fn sk_canvas_quick_reject(ccanvas: ?*sk_canvas_t, crect: [*c]const sk_rect_t) bool;
pub extern fn sk_canvas_clip_region(ccanvas: ?*sk_canvas_t, region: ?*const sk_region_t, op: sk_clipop_t) void;
pub extern fn sk_canvas_draw_paint(ccanvas: ?*sk_canvas_t, cpaint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_region(ccanvas: ?*sk_canvas_t, cregion: ?*const sk_region_t, cpaint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_rect(ccanvas: ?*sk_canvas_t, crect: [*c]const sk_rect_t, cpaint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_rrect(ccanvas: ?*sk_canvas_t, crect: ?*const sk_rrect_t, cpaint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_circle(ccanvas: ?*sk_canvas_t, cx: f32, cy: f32, rad: f32, cpaint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_oval(ccanvas: ?*sk_canvas_t, crect: [*c]const sk_rect_t, cpaint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_path(ccanvas: ?*sk_canvas_t, cpath: ?*const sk_path_t, cpaint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_image(ccanvas: ?*sk_canvas_t, cimage: ?*const sk_image_t, x: f32, y: f32, sampling: [*c]const sk_sampling_options_t, cpaint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_image_rect(ccanvas: ?*sk_canvas_t, cimage: ?*const sk_image_t, csrcR: [*c]const sk_rect_t, cdstR: [*c]const sk_rect_t, sampling: [*c]const sk_sampling_options_t, cpaint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_picture(ccanvas: ?*sk_canvas_t, cpicture: ?*const sk_picture_t, cmatrix: [*c]const sk_matrix_t, cpaint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_drawable(ccanvas: ?*sk_canvas_t, cdrawable: ?*sk_drawable_t, cmatrix: [*c]const sk_matrix_t) void;
pub extern fn sk_canvas_flush(ccanvas: ?*sk_canvas_t) void;
pub extern fn sk_canvas_new_from_bitmap(bitmap: ?*const sk_bitmap_t) ?*sk_canvas_t;
pub extern fn sk_canvas_new_from_raster(cinfo: [*c]const sk_imageinfo_t, pixels: ?*anyopaque, rowBytes: usize, props: ?*const sk_surfaceprops_t) ?*sk_canvas_t;
pub extern fn sk_canvas_draw_annotation(t: ?*sk_canvas_t, rect: [*c]const sk_rect_t, key: [*c]const u8, value: ?*sk_data_t) void;
pub extern fn sk_canvas_draw_url_annotation(t: ?*sk_canvas_t, rect: [*c]const sk_rect_t, value: ?*sk_data_t) void;
pub extern fn sk_canvas_draw_named_destination_annotation(t: ?*sk_canvas_t, point: [*c]const sk_point_t, value: ?*sk_data_t) void;
pub extern fn sk_canvas_draw_link_destination_annotation(t: ?*sk_canvas_t, rect: [*c]const sk_rect_t, value: ?*sk_data_t) void;
pub extern fn sk_canvas_draw_image_lattice(ccanvas: ?*sk_canvas_t, image: ?*const sk_image_t, lattice: [*c]const sk_lattice_t, dst: [*c]const sk_rect_t, mode: sk_filter_mode_t, paint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_image_nine(ccanvas: ?*sk_canvas_t, image: ?*const sk_image_t, center: [*c]const sk_irect_t, dst: [*c]const sk_rect_t, mode: sk_filter_mode_t, paint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_vertices(ccanvas: ?*sk_canvas_t, vertices: ?*const sk_vertices_t, mode: sk_blendmode_t, paint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_arc(ccanvas: ?*sk_canvas_t, oval: [*c]const sk_rect_t, startAngle: f32, sweepAngle: f32, useCenter: bool, paint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_drrect(ccanvas: ?*sk_canvas_t, outer: ?*const sk_rrect_t, inner: ?*const sk_rrect_t, paint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_atlas(ccanvas: ?*sk_canvas_t, atlas: ?*const sk_image_t, xform: [*c]const sk_rsxform_t, tex: [*c]const sk_rect_t, colors: [*c]const sk_color_t, count: c_int, mode: sk_blendmode_t, sampling: [*c]const sk_sampling_options_t, cullRect: [*c]const sk_rect_t, paint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_draw_patch(ccanvas: ?*sk_canvas_t, cubics: [*c]const sk_point_t, colors: [*c]const sk_color_t, texCoords: [*c]const sk_point_t, mode: sk_blendmode_t, paint: ?*const sk_paint_t) void;
pub extern fn sk_canvas_is_clip_empty(ccanvas: ?*sk_canvas_t) bool;
pub extern fn sk_canvas_is_clip_rect(ccanvas: ?*sk_canvas_t) bool;
pub extern fn sk_nodraw_canvas_new(width: c_int, height: c_int) ?*sk_nodraw_canvas_t;
pub extern fn sk_nodraw_canvas_destroy(t: ?*sk_nodraw_canvas_t) void;
pub extern fn sk_nway_canvas_new(width: c_int, height: c_int) ?*sk_nway_canvas_t;
pub extern fn sk_nway_canvas_destroy(t: ?*sk_nway_canvas_t) void;
pub extern fn sk_nway_canvas_add_canvas(t: ?*sk_nway_canvas_t, canvas: ?*sk_canvas_t) void;
pub extern fn sk_nway_canvas_remove_canvas(t: ?*sk_nway_canvas_t, canvas: ?*sk_canvas_t) void;
pub extern fn sk_nway_canvas_remove_all(t: ?*sk_nway_canvas_t) void;
pub extern fn sk_overdraw_canvas_new(canvas: ?*sk_canvas_t) ?*sk_overdraw_canvas_t;
pub extern fn sk_overdraw_canvas_destroy(canvas: ?*sk_overdraw_canvas_t) void;
pub extern fn sk_colorspace_ref(colorspace: ?*sk_colorspace_t) void;
pub extern fn sk_colorspace_unref(colorspace: ?*sk_colorspace_t) void;
pub extern fn sk_colorspace_new_srgb() ?*sk_colorspace_t;
pub extern fn sk_colorspace_new_srgb_linear() ?*sk_colorspace_t;
pub extern fn sk_colorspace_new_rgb(transferFn: [*c]const sk_colorspace_transfer_fn_t, toXYZD50: [*c]const sk_colorspace_xyz_t) ?*sk_colorspace_t;
pub extern fn sk_colorspace_new_icc(profile: ?*const sk_colorspace_icc_profile_t) ?*sk_colorspace_t;
pub extern fn sk_colorspace_to_profile(colorspace: ?*const sk_colorspace_t, profile: ?*sk_colorspace_icc_profile_t) void;
pub extern fn sk_colorspace_gamma_close_to_srgb(colorspace: ?*const sk_colorspace_t) bool;
pub extern fn sk_colorspace_gamma_is_linear(colorspace: ?*const sk_colorspace_t) bool;
pub extern fn sk_colorspace_is_numerical_transfer_fn(colorspace: ?*const sk_colorspace_t, transferFn: [*c]sk_colorspace_transfer_fn_t) bool;
pub extern fn sk_colorspace_to_xyzd50(colorspace: ?*const sk_colorspace_t, toXYZD50: [*c]sk_colorspace_xyz_t) bool;
pub extern fn sk_colorspace_make_linear_gamma(colorspace: ?*const sk_colorspace_t) ?*sk_colorspace_t;
pub extern fn sk_colorspace_make_srgb_gamma(colorspace: ?*const sk_colorspace_t) ?*sk_colorspace_t;
pub extern fn sk_colorspace_is_srgb(colorspace: ?*const sk_colorspace_t) bool;
pub extern fn sk_colorspace_equals(src: ?*const sk_colorspace_t, dst: ?*const sk_colorspace_t) bool;
pub extern fn sk_colorspace_transfer_fn_named_srgb(transferFn: [*c]sk_colorspace_transfer_fn_t) void;
pub extern fn sk_colorspace_transfer_fn_named_2dot2(transferFn: [*c]sk_colorspace_transfer_fn_t) void;
pub extern fn sk_colorspace_transfer_fn_named_linear(transferFn: [*c]sk_colorspace_transfer_fn_t) void;
pub extern fn sk_colorspace_transfer_fn_named_rec2020(transferFn: [*c]sk_colorspace_transfer_fn_t) void;
pub extern fn sk_colorspace_transfer_fn_named_pq(transferFn: [*c]sk_colorspace_transfer_fn_t) void;
pub extern fn sk_colorspace_transfer_fn_named_hlg(transferFn: [*c]sk_colorspace_transfer_fn_t) void;
pub extern fn sk_colorspace_transfer_fn_eval(transferFn: [*c]const sk_colorspace_transfer_fn_t, x: f32) f32;
pub extern fn sk_colorspace_transfer_fn_invert(src: [*c]const sk_colorspace_transfer_fn_t, dst: [*c]sk_colorspace_transfer_fn_t) bool;
pub extern fn sk_colorspace_primaries_to_xyzd50(primaries: [*c]const sk_colorspace_primaries_t, toXYZD50: [*c]sk_colorspace_xyz_t) bool;
pub extern fn sk_colorspace_xyz_named_srgb(xyz: [*c]sk_colorspace_xyz_t) void;
pub extern fn sk_colorspace_xyz_named_adobe_rgb(xyz: [*c]sk_colorspace_xyz_t) void;
pub extern fn sk_colorspace_xyz_named_display_p3(xyz: [*c]sk_colorspace_xyz_t) void;
pub extern fn sk_colorspace_xyz_named_rec2020(xyz: [*c]sk_colorspace_xyz_t) void;
pub extern fn sk_colorspace_xyz_named_xyz(xyz: [*c]sk_colorspace_xyz_t) void;
pub extern fn sk_colorspace_xyz_invert(src: [*c]const sk_colorspace_xyz_t, dst: [*c]sk_colorspace_xyz_t) bool;
pub extern fn sk_colorspace_xyz_concat(a: [*c]const sk_colorspace_xyz_t, b: [*c]const sk_colorspace_xyz_t, result: [*c]sk_colorspace_xyz_t) void;
pub extern fn sk_colorspace_icc_profile_delete(profile: ?*sk_colorspace_icc_profile_t) void;
pub extern fn sk_colorspace_icc_profile_new() ?*sk_colorspace_icc_profile_t;
pub extern fn sk_colorspace_icc_profile_parse(buffer: ?*const anyopaque, length: usize, profile: ?*sk_colorspace_icc_profile_t) bool;
pub extern fn sk_colorspace_icc_profile_get_buffer(profile: ?*const sk_colorspace_icc_profile_t, size: [*c]u32) [*c]const u8;
pub extern fn sk_colorspace_icc_profile_get_to_xyzd50(profile: ?*const sk_colorspace_icc_profile_t, toXYZD50: [*c]sk_colorspace_xyz_t) bool;
pub extern fn sk_color4f_to_color(color4f: [*c]const sk_color4f_t) sk_color_t;
pub extern fn sk_color4f_from_color(color: sk_color_t, color4f: [*c]sk_color4f_t) void;
pub extern fn sk_data_new_empty() ?*sk_data_t;
pub extern fn sk_data_new_with_copy(src: ?*const anyopaque, length: usize) ?*sk_data_t;
pub extern fn sk_data_new_subset(src: ?*const sk_data_t, offset: usize, length: usize) ?*sk_data_t;
pub extern fn sk_data_ref(?*const sk_data_t) void;
pub extern fn sk_data_unref(?*const sk_data_t) void;
pub extern fn sk_data_get_size(?*const sk_data_t) usize;
pub extern fn sk_data_get_data(?*const sk_data_t) ?*const anyopaque;
pub extern fn sk_data_new_from_file(path: [*c]const u8) ?*sk_data_t;
pub extern fn sk_data_new_from_stream(stream: ?*sk_stream_t, length: usize) ?*sk_data_t;
pub extern fn sk_data_get_bytes(?*const sk_data_t) [*c]const u8;
pub extern fn sk_data_new_with_proc(ptr: ?*const anyopaque, length: usize, proc: sk_data_release_proc, ctx: ?*anyopaque) ?*sk_data_t;
pub extern fn sk_data_new_uninitialized(size: usize) ?*sk_data_t;
pub extern fn sk_image_ref(cimage: ?*const sk_image_t) void;
pub extern fn sk_image_unref(cimage: ?*const sk_image_t) void;
pub extern fn sk_image_new_raster_copy(cinfo: [*c]const sk_imageinfo_t, pixels: ?*const anyopaque, rowBytes: usize) ?*sk_image_t;
pub extern fn sk_image_new_raster_copy_with_pixmap(pixmap: ?*const sk_pixmap_t) ?*sk_image_t;
pub extern fn sk_image_new_raster_data(cinfo: [*c]const sk_imageinfo_t, pixels: ?*sk_data_t, rowBytes: usize) ?*sk_image_t;
pub extern fn sk_image_new_raster(pixmap: ?*const sk_pixmap_t, releaseProc: sk_image_raster_release_proc, context: ?*anyopaque) ?*sk_image_t;
pub extern fn sk_image_new_from_bitmap(cbitmap: ?*const sk_bitmap_t) ?*sk_image_t;
pub extern fn sk_image_new_from_encoded(cdata: ?*const sk_data_t) ?*sk_image_t;
pub extern fn sk_image_new_from_texture(context: ?*gr_recording_context_t, texture: ?*const gr_backendtexture_t, origin: gr_surfaceorigin_t, colorType: sk_colortype_t, alpha: sk_alphatype_t, colorSpace: ?*const sk_colorspace_t, releaseProc: sk_image_texture_release_proc, releaseContext: ?*anyopaque) ?*sk_image_t;
pub extern fn sk_image_new_from_adopted_texture(context: ?*gr_recording_context_t, texture: ?*const gr_backendtexture_t, origin: gr_surfaceorigin_t, colorType: sk_colortype_t, alpha: sk_alphatype_t, colorSpace: ?*const sk_colorspace_t) ?*sk_image_t;
pub extern fn sk_image_new_from_picture(picture: ?*sk_picture_t, dimensions: [*c]const sk_isize_t, cmatrix: [*c]const sk_matrix_t, paint: ?*const sk_paint_t, useFloatingPointBitDepth: bool, colorSpace: ?*const sk_colorspace_t, props: ?*const sk_surfaceprops_t) ?*sk_image_t;
pub extern fn sk_image_get_width(cimage: ?*const sk_image_t) c_int;
pub extern fn sk_image_get_height(cimage: ?*const sk_image_t) c_int;
pub extern fn sk_image_get_unique_id(cimage: ?*const sk_image_t) u32;
pub extern fn sk_image_get_alpha_type(image: ?*const sk_image_t) sk_alphatype_t;
pub extern fn sk_image_get_color_type(image: ?*const sk_image_t) sk_colortype_t;
pub extern fn sk_image_get_colorspace(image: ?*const sk_image_t) ?*sk_colorspace_t;
pub extern fn sk_image_is_alpha_only(image: ?*const sk_image_t) bool;
pub extern fn sk_image_make_shader(image: ?*const sk_image_t, tileX: sk_shader_tilemode_t, tileY: sk_shader_tilemode_t, sampling: [*c]const sk_sampling_options_t, cmatrix: [*c]const sk_matrix_t) ?*sk_shader_t;
pub extern fn sk_image_make_raw_shader(image: ?*const sk_image_t, tileX: sk_shader_tilemode_t, tileY: sk_shader_tilemode_t, sampling: [*c]const sk_sampling_options_t, cmatrix: [*c]const sk_matrix_t) ?*sk_shader_t;
pub extern fn sk_image_peek_pixels(image: ?*const sk_image_t, pixmap: ?*sk_pixmap_t) bool;
pub extern fn sk_image_is_texture_backed(image: ?*const sk_image_t) bool;
pub extern fn sk_image_is_lazy_generated(image: ?*const sk_image_t) bool;
pub extern fn sk_image_is_valid(image: ?*const sk_image_t, context: ?*gr_recording_context_t) bool;
pub extern fn sk_image_read_pixels(image: ?*const sk_image_t, dstInfo: [*c]const sk_imageinfo_t, dstPixels: ?*anyopaque, dstRowBytes: usize, srcX: c_int, srcY: c_int, cachingHint: sk_image_caching_hint_t) bool;
pub extern fn sk_image_read_pixels_into_pixmap(image: ?*const sk_image_t, dst: ?*const sk_pixmap_t, srcX: c_int, srcY: c_int, cachingHint: sk_image_caching_hint_t) bool;
pub extern fn sk_image_scale_pixels(image: ?*const sk_image_t, dst: ?*const sk_pixmap_t, sampling: [*c]const sk_sampling_options_t, cachingHint: sk_image_caching_hint_t) bool;
pub extern fn sk_image_ref_encoded(cimage: ?*const sk_image_t) ?*sk_data_t;
pub extern fn sk_image_make_subset_raster(cimage: ?*const sk_image_t, subset: [*c]const sk_irect_t) ?*sk_image_t;
pub extern fn sk_image_make_subset(cimage: ?*const sk_image_t, context: ?*gr_direct_context_t, subset: [*c]const sk_irect_t) ?*sk_image_t;
pub extern fn sk_image_make_texture_image(cimage: ?*const sk_image_t, context: ?*gr_direct_context_t, mipmapped: bool, budgeted: bool) ?*sk_image_t;
pub extern fn sk_image_make_non_texture_image(cimage: ?*const sk_image_t) ?*sk_image_t;
pub extern fn sk_image_make_raster_image(cimage: ?*const sk_image_t) ?*sk_image_t;
pub extern fn sk_image_make_with_filter_raster(cimage: ?*const sk_image_t, filter: ?*const sk_imagefilter_t, subset: [*c]const sk_irect_t, clipBounds: [*c]const sk_irect_t, outSubset: [*c]sk_irect_t, outOffset: [*c]sk_ipoint_t) ?*sk_image_t;
pub extern fn sk_image_make_with_filter(cimage: ?*const sk_image_t, context: ?*gr_recording_context_t, filter: ?*const sk_imagefilter_t, subset: [*c]const sk_irect_t, clipBounds: [*c]const sk_irect_t, outSubset: [*c]sk_irect_t, outOffset: [*c]sk_ipoint_t) ?*sk_image_t;
pub extern fn sk_paint_new() ?*sk_paint_t;
pub extern fn sk_paint_clone(?*sk_paint_t) ?*sk_paint_t;
pub extern fn sk_paint_delete(?*sk_paint_t) void;
pub extern fn sk_paint_reset(?*sk_paint_t) void;
pub extern fn sk_paint_is_antialias(?*const sk_paint_t) bool;
pub extern fn sk_paint_set_antialias(?*sk_paint_t, bool) void;
pub extern fn sk_paint_get_color(?*const sk_paint_t) sk_color_t;
pub extern fn sk_paint_get_color4f(paint: ?*const sk_paint_t, color: [*c]sk_color4f_t) void;
pub extern fn sk_paint_set_color(?*sk_paint_t, sk_color_t) void;
pub extern fn sk_paint_set_color4f(paint: ?*sk_paint_t, color: [*c]sk_color4f_t, colorspace: ?*sk_colorspace_t) void;
pub extern fn sk_paint_get_style(?*const sk_paint_t) sk_paint_style_t;
pub extern fn sk_paint_set_style(?*sk_paint_t, sk_paint_style_t) void;
pub extern fn sk_paint_get_stroke_width(?*const sk_paint_t) f32;
pub extern fn sk_paint_set_stroke_width(?*sk_paint_t, width: f32) void;
pub extern fn sk_paint_get_stroke_miter(?*const sk_paint_t) f32;
pub extern fn sk_paint_set_stroke_miter(?*sk_paint_t, miter: f32) void;
pub extern fn sk_paint_get_stroke_cap(?*const sk_paint_t) sk_stroke_cap_t;
pub extern fn sk_paint_set_stroke_cap(?*sk_paint_t, sk_stroke_cap_t) void;
pub extern fn sk_paint_get_stroke_join(?*const sk_paint_t) sk_stroke_join_t;
pub extern fn sk_paint_set_stroke_join(?*sk_paint_t, sk_stroke_join_t) void;
pub extern fn sk_paint_set_shader(?*sk_paint_t, ?*sk_shader_t) void;
pub extern fn sk_paint_set_maskfilter(?*sk_paint_t, ?*sk_maskfilter_t) void;
pub extern fn sk_paint_set_blendmode(?*sk_paint_t, sk_blendmode_t) void;
pub extern fn sk_paint_set_blender(paint: ?*sk_paint_t, blender: ?*sk_blender_t) void;
pub extern fn sk_paint_is_dither(?*const sk_paint_t) bool;
pub extern fn sk_paint_set_dither(?*sk_paint_t, bool) void;
pub extern fn sk_paint_get_shader(?*sk_paint_t) ?*sk_shader_t;
pub extern fn sk_paint_get_maskfilter(?*sk_paint_t) ?*sk_maskfilter_t;
pub extern fn sk_paint_set_colorfilter(?*sk_paint_t, ?*sk_colorfilter_t) void;
pub extern fn sk_paint_get_colorfilter(?*sk_paint_t) ?*sk_colorfilter_t;
pub extern fn sk_paint_set_imagefilter(?*sk_paint_t, ?*sk_imagefilter_t) void;
pub extern fn sk_paint_get_imagefilter(?*sk_paint_t) ?*sk_imagefilter_t;
pub extern fn sk_paint_get_blendmode(?*sk_paint_t) sk_blendmode_t;
pub extern fn sk_paint_get_blender(cpaint: ?*sk_paint_t) ?*sk_blender_t;
pub extern fn sk_paint_get_path_effect(cpaint: ?*sk_paint_t) ?*sk_path_effect_t;
pub extern fn sk_paint_set_path_effect(cpaint: ?*sk_paint_t, effect: ?*sk_path_effect_t) void;
pub extern fn sk_paint_get_fill_path(cpaint: ?*const sk_paint_t, src: ?*const sk_path_t, dst: ?*sk_path_t, cullRect: [*c]const sk_rect_t, cmatrix: [*c]const sk_matrix_t) bool;
pub extern fn sk_path_new() ?*sk_path_t;
pub extern fn sk_path_delete(?*sk_path_t) void;
pub extern fn sk_path_move_to(?*sk_path_t, x: f32, y: f32) void;
pub extern fn sk_path_line_to(?*sk_path_t, x: f32, y: f32) void;
pub extern fn sk_path_quad_to(?*sk_path_t, x0: f32, y0: f32, x1: f32, y1: f32) void;
pub extern fn sk_path_conic_to(?*sk_path_t, x0: f32, y0: f32, x1: f32, y1: f32, w: f32) void;
pub extern fn sk_path_cubic_to(?*sk_path_t, x0: f32, y0: f32, x1: f32, y1: f32, x2: f32, y2: f32) void;
pub extern fn sk_path_arc_to(?*sk_path_t, rx: f32, ry: f32, xAxisRotate: f32, largeArc: sk_path_arc_size_t, sweep: sk_path_direction_t, x: f32, y: f32) void;
pub extern fn sk_path_rarc_to(?*sk_path_t, rx: f32, ry: f32, xAxisRotate: f32, largeArc: sk_path_arc_size_t, sweep: sk_path_direction_t, x: f32, y: f32) void;
pub extern fn sk_path_arc_to_with_oval(?*sk_path_t, oval: [*c]const sk_rect_t, startAngle: f32, sweepAngle: f32, forceMoveTo: bool) void;
pub extern fn sk_path_arc_to_with_points(?*sk_path_t, x1: f32, y1: f32, x2: f32, y2: f32, radius: f32) void;
pub extern fn sk_path_close(?*sk_path_t) void;
pub extern fn sk_path_add_rect(?*sk_path_t, [*c]const sk_rect_t, sk_path_direction_t) void;
pub extern fn sk_path_add_rrect(?*sk_path_t, ?*const sk_rrect_t, sk_path_direction_t) void;
pub extern fn sk_path_add_rrect_start(?*sk_path_t, ?*const sk_rrect_t, sk_path_direction_t, u32) void;
pub extern fn sk_path_add_rounded_rect(?*sk_path_t, [*c]const sk_rect_t, f32, f32, sk_path_direction_t) void;
pub extern fn sk_path_add_oval(?*sk_path_t, [*c]const sk_rect_t, sk_path_direction_t) void;
pub extern fn sk_path_add_circle(?*sk_path_t, x: f32, y: f32, radius: f32, dir: sk_path_direction_t) void;
pub extern fn sk_path_get_bounds(?*const sk_path_t, [*c]sk_rect_t) void;
pub extern fn sk_path_compute_tight_bounds(?*const sk_path_t, [*c]sk_rect_t) void;
pub extern fn sk_path_rmove_to(?*sk_path_t, dx: f32, dy: f32) void;
pub extern fn sk_path_rline_to(?*sk_path_t, dx: f32, yd: f32) void;
pub extern fn sk_path_rquad_to(?*sk_path_t, dx0: f32, dy0: f32, dx1: f32, dy1: f32) void;
pub extern fn sk_path_rconic_to(?*sk_path_t, dx0: f32, dy0: f32, dx1: f32, dy1: f32, w: f32) void;
pub extern fn sk_path_rcubic_to(?*sk_path_t, dx0: f32, dy0: f32, dx1: f32, dy1: f32, dx2: f32, dy2: f32) void;
pub extern fn sk_path_add_rect_start(cpath: ?*sk_path_t, crect: [*c]const sk_rect_t, cdir: sk_path_direction_t, startIndex: u32) void;
pub extern fn sk_path_add_arc(cpath: ?*sk_path_t, crect: [*c]const sk_rect_t, startAngle: f32, sweepAngle: f32) void;
pub extern fn sk_path_get_filltype(?*sk_path_t) sk_path_filltype_t;
pub extern fn sk_path_set_filltype(?*sk_path_t, sk_path_filltype_t) void;
pub extern fn sk_path_transform(cpath: ?*sk_path_t, cmatrix: [*c]const sk_matrix_t) void;
pub extern fn sk_path_transform_to_dest(cpath: ?*const sk_path_t, cmatrix: [*c]const sk_matrix_t, destination: ?*sk_path_t) void;
pub extern fn sk_path_clone(cpath: ?*const sk_path_t) ?*sk_path_t;
pub extern fn sk_path_add_path_offset(cpath: ?*sk_path_t, other: ?*sk_path_t, dx: f32, dy: f32, add_mode: sk_path_add_mode_t) void;
pub extern fn sk_path_add_path_matrix(cpath: ?*sk_path_t, other: ?*sk_path_t, matrix: [*c]sk_matrix_t, add_mode: sk_path_add_mode_t) void;
pub extern fn sk_path_add_path(cpath: ?*sk_path_t, other: ?*sk_path_t, add_mode: sk_path_add_mode_t) void;
pub extern fn sk_path_add_path_reverse(cpath: ?*sk_path_t, other: ?*sk_path_t) void;
pub extern fn sk_path_reset(cpath: ?*sk_path_t) void;
pub extern fn sk_path_rewind(cpath: ?*sk_path_t) void;
pub extern fn sk_path_count_points(cpath: ?*const sk_path_t) c_int;
pub extern fn sk_path_count_verbs(cpath: ?*const sk_path_t) c_int;
pub extern fn sk_path_get_point(cpath: ?*const sk_path_t, index: c_int, point: [*c]sk_point_t) void;
pub extern fn sk_path_get_points(cpath: ?*const sk_path_t, points: [*c]sk_point_t, max: c_int) c_int;
pub extern fn sk_path_contains(cpath: ?*const sk_path_t, x: f32, y: f32) bool;
pub extern fn sk_path_parse_svg_string(cpath: ?*sk_path_t, str: [*c]const u8) bool;
pub extern fn sk_path_to_svg_string(cpath: ?*const sk_path_t, str: ?*sk_string_t) void;
pub extern fn sk_path_get_last_point(cpath: ?*const sk_path_t, point: [*c]sk_point_t) bool;
pub extern fn sk_path_convert_conic_to_quads(p0: [*c]const sk_point_t, p1: [*c]const sk_point_t, p2: [*c]const sk_point_t, w: f32, pts: [*c]sk_point_t, pow2: c_int) c_int;
pub extern fn sk_path_add_poly(cpath: ?*sk_path_t, points: [*c]const sk_point_t, count: c_int, close: bool) void;
pub extern fn sk_path_get_segment_masks(cpath: ?*sk_path_t) u32;
pub extern fn sk_path_is_oval(cpath: ?*sk_path_t, bounds: [*c]sk_rect_t) bool;
pub extern fn sk_path_is_rrect(cpath: ?*sk_path_t, bounds: ?*sk_rrect_t) bool;
pub extern fn sk_path_is_line(cpath: ?*sk_path_t, line: [*c]sk_point_t) bool;
pub extern fn sk_path_is_rect(cpath: ?*sk_path_t, rect: [*c]sk_rect_t, isClosed: [*c]bool, direction: [*c]sk_path_direction_t) bool;
pub extern fn sk_path_is_convex(cpath: ?*const sk_path_t) bool;
pub extern fn sk_path_create_iter(cpath: ?*sk_path_t, forceClose: c_int) ?*sk_path_iterator_t;
pub extern fn sk_path_iter_next(iterator: ?*sk_path_iterator_t, points: [*c]sk_point_t) sk_path_verb_t;
pub extern fn sk_path_iter_conic_weight(iterator: ?*sk_path_iterator_t) f32;
pub extern fn sk_path_iter_is_close_line(iterator: ?*sk_path_iterator_t) c_int;
pub extern fn sk_path_iter_is_closed_contour(iterator: ?*sk_path_iterator_t) c_int;
pub extern fn sk_path_iter_destroy(iterator: ?*sk_path_iterator_t) void;
pub extern fn sk_path_create_rawiter(cpath: ?*sk_path_t) ?*sk_path_rawiterator_t;
pub extern fn sk_path_rawiter_peek(iterator: ?*sk_path_rawiterator_t) sk_path_verb_t;
pub extern fn sk_path_rawiter_next(iterator: ?*sk_path_rawiterator_t, points: [*c]sk_point_t) sk_path_verb_t;
pub extern fn sk_path_rawiter_conic_weight(iterator: ?*sk_path_rawiterator_t) f32;
pub extern fn sk_path_rawiter_destroy(iterator: ?*sk_path_rawiterator_t) void;
pub extern fn sk_pathop_op(one: ?*const sk_path_t, two: ?*const sk_path_t, op: sk_pathop_t, result: ?*sk_path_t) bool;
pub extern fn sk_pathop_simplify(path: ?*const sk_path_t, result: ?*sk_path_t) bool;
pub extern fn sk_pathop_tight_bounds(path: ?*const sk_path_t, result: [*c]sk_rect_t) bool;
pub extern fn sk_pathop_as_winding(path: ?*const sk_path_t, result: ?*sk_path_t) bool;
pub extern fn sk_opbuilder_new() ?*sk_opbuilder_t;
pub extern fn sk_opbuilder_destroy(builder: ?*sk_opbuilder_t) void;
pub extern fn sk_opbuilder_add(builder: ?*sk_opbuilder_t, path: ?*const sk_path_t, op: sk_pathop_t) void;
pub extern fn sk_opbuilder_resolve(builder: ?*sk_opbuilder_t, result: ?*sk_path_t) bool;
pub extern fn sk_pathmeasure_new() ?*sk_pathmeasure_t;
pub extern fn sk_pathmeasure_new_with_path(path: ?*const sk_path_t, forceClosed: bool, resScale: f32) ?*sk_pathmeasure_t;
pub extern fn sk_pathmeasure_destroy(pathMeasure: ?*sk_pathmeasure_t) void;
pub extern fn sk_pathmeasure_set_path(pathMeasure: ?*sk_pathmeasure_t, path: ?*const sk_path_t, forceClosed: bool) void;
pub extern fn sk_pathmeasure_get_length(pathMeasure: ?*sk_pathmeasure_t) f32;
pub extern fn sk_pathmeasure_get_pos_tan(pathMeasure: ?*sk_pathmeasure_t, distance: f32, position: [*c]sk_point_t, tangent: [*c]sk_vector_t) bool;
pub extern fn sk_pathmeasure_get_matrix(pathMeasure: ?*sk_pathmeasure_t, distance: f32, matrix: [*c]sk_matrix_t, flags: sk_pathmeasure_matrixflags_t) bool;
pub extern fn sk_pathmeasure_get_segment(pathMeasure: ?*sk_pathmeasure_t, start: f32, stop: f32, dst: ?*sk_path_t, startWithMoveTo: bool) bool;
pub extern fn sk_pathmeasure_is_closed(pathMeasure: ?*sk_pathmeasure_t) bool;
pub extern fn sk_pathmeasure_next_contour(pathMeasure: ?*sk_pathmeasure_t) bool;
pub extern fn sk_surface_new_null(width: c_int, height: c_int) ?*sk_surface_t;
pub extern fn sk_surface_new_raster([*c]const sk_imageinfo_t, rowBytes: usize, ?*const sk_surfaceprops_t) ?*sk_surface_t;
pub extern fn sk_surface_new_raster_direct([*c]const sk_imageinfo_t, pixels: ?*anyopaque, rowBytes: usize, releaseProc: sk_surface_raster_release_proc, context: ?*anyopaque, props: ?*const sk_surfaceprops_t) ?*sk_surface_t;
pub extern fn sk_surface_new_backend_texture(context: ?*gr_recording_context_t, texture: ?*const gr_backendtexture_t, origin: gr_surfaceorigin_t, samples: c_int, colorType: sk_colortype_t, colorspace: ?*sk_colorspace_t, props: ?*const sk_surfaceprops_t) ?*sk_surface_t;
pub extern fn sk_surface_new_backend_render_target(context: ?*gr_recording_context_t, target: ?*const gr_backendrendertarget_t, origin: gr_surfaceorigin_t, colorType: sk_colortype_t, colorspace: ?*sk_colorspace_t, props: ?*const sk_surfaceprops_t) ?*sk_surface_t;
pub extern fn sk_surface_new_render_target(context: ?*gr_recording_context_t, budgeted: bool, cinfo: [*c]const sk_imageinfo_t, sampleCount: c_int, origin: gr_surfaceorigin_t, props: ?*const sk_surfaceprops_t, shouldCreateWithMips: bool) ?*sk_surface_t;
pub extern fn sk_surface_new_metal_layer(context: ?*gr_recording_context_t, layer: ?*const anyopaque, origin: gr_surfaceorigin_t, sampleCount: c_int, colorType: sk_colortype_t, colorspace: ?*sk_colorspace_t, props: ?*const sk_surfaceprops_t, drawable: [*c]?*const anyopaque) ?*sk_surface_t;
pub extern fn sk_surface_new_metal_view(context: ?*gr_recording_context_t, mtkView: ?*const anyopaque, origin: gr_surfaceorigin_t, sampleCount: c_int, colorType: sk_colortype_t, colorspace: ?*sk_colorspace_t, props: ?*const sk_surfaceprops_t) ?*sk_surface_t;
pub extern fn sk_surface_unref(?*sk_surface_t) void;
pub extern fn sk_surface_get_canvas(?*sk_surface_t) ?*sk_canvas_t;
pub extern fn sk_surface_new_image_snapshot(?*sk_surface_t) ?*sk_image_t;
pub extern fn sk_surface_new_image_snapshot_with_crop(surface: ?*sk_surface_t, bounds: [*c]const sk_irect_t) ?*sk_image_t;
pub extern fn sk_surface_draw(surface: ?*sk_surface_t, canvas: ?*sk_canvas_t, x: f32, y: f32, paint: ?*const sk_paint_t) void;
pub extern fn sk_surface_peek_pixels(surface: ?*sk_surface_t, pixmap: ?*sk_pixmap_t) bool;
pub extern fn sk_surface_read_pixels(surface: ?*sk_surface_t, dstInfo: [*c]sk_imageinfo_t, dstPixels: ?*anyopaque, dstRowBytes: usize, srcX: c_int, srcY: c_int) bool;
pub extern fn sk_surface_get_props(surface: ?*sk_surface_t) ?*const sk_surfaceprops_t;
pub extern fn sk_surface_flush(surface: ?*sk_surface_t) void;
pub extern fn sk_surface_flush_and_submit(surface: ?*sk_surface_t, syncCpu: bool) void;
pub extern fn sk_surface_get_recording_context(surface: ?*sk_surface_t) ?*gr_recording_context_t;
pub extern fn sk_surfaceprops_new(flags: u32, geometry: sk_pixelgeometry_t) ?*sk_surfaceprops_t;
pub extern fn sk_surfaceprops_delete(props: ?*sk_surfaceprops_t) void;
pub extern fn sk_surfaceprops_get_flags(props: ?*sk_surfaceprops_t) u32;
pub extern fn sk_surfaceprops_get_pixel_geometry(props: ?*sk_surfaceprops_t) sk_pixelgeometry_t;
pub const __llvm__ = @as(c_int, 1);
pub const __clang__ = @as(c_int, 1);
pub const __clang_major__ = @as(c_int, 19);
pub const __clang_minor__ = @as(c_int, 1);
pub const __clang_patchlevel__ = @as(c_int, 0);
pub const __clang_version__ = "19.1.0 (https://github.com/ziglang/zig-bootstrap cafebd74b6c664a45989f8dd6fec07a64708df06)";
pub const __GNUC__ = @as(c_int, 4);
pub const __GNUC_MINOR__ = @as(c_int, 2);
pub const __GNUC_PATCHLEVEL__ = @as(c_int, 1);
pub const __GXX_ABI_VERSION = @as(c_int, 1002);
pub const __ATOMIC_RELAXED = @as(c_int, 0);
pub const __ATOMIC_CONSUME = @as(c_int, 1);
pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
pub const __ATOMIC_RELEASE = @as(c_int, 3);
pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
pub const __MEMORY_SCOPE_SYSTEM = @as(c_int, 0);
pub const __MEMORY_SCOPE_DEVICE = @as(c_int, 1);
pub const __MEMORY_SCOPE_WRKGRP = @as(c_int, 2);
pub const __MEMORY_SCOPE_WVFRNT = @as(c_int, 3);
pub const __MEMORY_SCOPE_SINGLE = @as(c_int, 4);
pub const __OPENCL_MEMORY_SCOPE_WORK_ITEM = @as(c_int, 0);
pub const __OPENCL_MEMORY_SCOPE_WORK_GROUP = @as(c_int, 1);
pub const __OPENCL_MEMORY_SCOPE_DEVICE = @as(c_int, 2);
pub const __OPENCL_MEMORY_SCOPE_ALL_SVM_DEVICES = @as(c_int, 3);
pub const __OPENCL_MEMORY_SCOPE_SUB_GROUP = @as(c_int, 4);
pub const __FPCLASS_SNAN = @as(c_int, 0x0001);
pub const __FPCLASS_QNAN = @as(c_int, 0x0002);
pub const __FPCLASS_NEGINF = @as(c_int, 0x0004);
pub const __FPCLASS_NEGNORMAL = @as(c_int, 0x0008);
pub const __FPCLASS_NEGSUBNORMAL = @as(c_int, 0x0010);
pub const __FPCLASS_NEGZERO = @as(c_int, 0x0020);
pub const __FPCLASS_POSZERO = @as(c_int, 0x0040);
pub const __FPCLASS_POSSUBNORMAL = @as(c_int, 0x0080);
pub const __FPCLASS_POSNORMAL = @as(c_int, 0x0100);
pub const __FPCLASS_POSINF = @as(c_int, 0x0200);
pub const __PRAGMA_REDEFINE_EXTNAME = @as(c_int, 1);
pub const __VERSION__ = "Clang 19.1.0 (https://github.com/ziglang/zig-bootstrap cafebd74b6c664a45989f8dd6fec07a64708df06)";
pub const __GXX_TYPEINFO_EQUALITY_INLINE = @as(c_int, 0);
pub const __OBJC_BOOL_IS_BOOL = @as(c_int, 0);
pub const __CONSTANT_CFSTRINGS__ = @as(c_int, 1);
pub const __SEH__ = @as(c_int, 1);
pub const __clang_literal_encoding__ = "UTF-8";
pub const __clang_wide_literal_encoding__ = "UTF-16";
pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
pub const __CHAR_BIT__ = @as(c_int, 8);
pub const __BOOL_WIDTH__ = @as(c_int, 8);
pub const __SHRT_WIDTH__ = @as(c_int, 16);
pub const __INT_WIDTH__ = @as(c_int, 32);
pub const __LONG_WIDTH__ = @as(c_int, 32);
pub const __LLONG_WIDTH__ = @as(c_int, 64);
pub const __BITINT_MAXWIDTH__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 8388608, .decimal);
pub const __SCHAR_MAX__ = @as(c_int, 127);
pub const __SHRT_MAX__ = @as(c_int, 32767);
pub const __INT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __LONG_MAX__ = @as(c_long, 2147483647);
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __WCHAR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __WCHAR_WIDTH__ = @as(c_int, 16);
pub const __WINT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __WINT_WIDTH__ = @as(c_int, 16);
pub const __INTMAX_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INTMAX_WIDTH__ = @as(c_int, 64);
pub const __SIZE_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __SIZE_WIDTH__ = @as(c_int, 64);
pub const __UINTMAX_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
pub const __PTRDIFF_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __PTRDIFF_WIDTH__ = @as(c_int, 64);
pub const __INTPTR_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INTPTR_WIDTH__ = @as(c_int, 64);
pub const __UINTPTR_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __UINTPTR_WIDTH__ = @as(c_int, 64);
pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
pub const __SIZEOF_INT__ = @as(c_int, 4);
pub const __SIZEOF_LONG__ = @as(c_int, 4);
pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 16);
pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
pub const __SIZEOF_POINTER__ = @as(c_int, 8);
pub const __SIZEOF_SHORT__ = @as(c_int, 2);
pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 8);
pub const __SIZEOF_SIZE_T__ = @as(c_int, 8);
pub const __SIZEOF_WCHAR_T__ = @as(c_int, 2);
pub const __SIZEOF_WINT_T__ = @as(c_int, 2);
pub const __SIZEOF_INT128__ = @as(c_int, 16);
pub const __INTMAX_TYPE__ = c_longlong;
pub const __INTMAX_FMTd__ = "lld";
pub const __INTMAX_FMTi__ = "lli";
pub const __INTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `LL`");
// (no file):95:9
pub const __UINTMAX_TYPE__ = c_ulonglong;
pub const __UINTMAX_FMTo__ = "llo";
pub const __UINTMAX_FMTu__ = "llu";
pub const __UINTMAX_FMTx__ = "llx";
pub const __UINTMAX_FMTX__ = "llX";
pub const __UINTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `ULL`");
// (no file):101:9
pub const __PTRDIFF_TYPE__ = c_longlong;
pub const __PTRDIFF_FMTd__ = "lld";
pub const __PTRDIFF_FMTi__ = "lli";
pub const __INTPTR_TYPE__ = c_longlong;
pub const __INTPTR_FMTd__ = "lld";
pub const __INTPTR_FMTi__ = "lli";
pub const __SIZE_TYPE__ = c_ulonglong;
pub const __SIZE_FMTo__ = "llo";
pub const __SIZE_FMTu__ = "llu";
pub const __SIZE_FMTx__ = "llx";
pub const __SIZE_FMTX__ = "llX";
pub const __WCHAR_TYPE__ = c_ushort;
pub const __WINT_TYPE__ = c_ushort;
pub const __SIG_ATOMIC_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
pub const __CHAR16_TYPE__ = c_ushort;
pub const __CHAR32_TYPE__ = c_uint;
pub const __UINTPTR_TYPE__ = c_ulonglong;
pub const __UINTPTR_FMTo__ = "llo";
pub const __UINTPTR_FMTu__ = "llu";
pub const __UINTPTR_FMTx__ = "llx";
pub const __UINTPTR_FMTX__ = "llX";
pub const __FLT16_DENORM_MIN__ = @as(f16, 5.9604644775390625e-8);
pub const __FLT16_NORM_MAX__ = @as(f16, 6.5504e+4);
pub const __FLT16_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT16_DIG__ = @as(c_int, 3);
pub const __FLT16_DECIMAL_DIG__ = @as(c_int, 5);
pub const __FLT16_EPSILON__ = @as(f16, 9.765625e-4);
pub const __FLT16_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT16_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT16_MANT_DIG__ = @as(c_int, 11);
pub const __FLT16_MAX_10_EXP__ = @as(c_int, 4);
pub const __FLT16_MAX_EXP__ = @as(c_int, 16);
pub const __FLT16_MAX__ = @as(f16, 6.5504e+4);
pub const __FLT16_MIN_10_EXP__ = -@as(c_int, 4);
pub const __FLT16_MIN_EXP__ = -@as(c_int, 13);
pub const __FLT16_MIN__ = @as(f16, 6.103515625e-5);
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub const __FLT_NORM_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT_DIG__ = @as(c_int, 6);
pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FLT_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT_MANT_DIG__ = @as(c_int, 24);
pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
pub const __FLT_MAX_EXP__ = @as(c_int, 128);
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __DBL_DENORM_MIN__ = @as(f64, 4.9406564584124654e-324);
pub const __DBL_NORM_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_HAS_DENORM__ = @as(c_int, 1);
pub const __DBL_DIG__ = @as(c_int, 15);
pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __DBL_EPSILON__ = @as(f64, 2.2204460492503131e-16);
pub const __DBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __DBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __DBL_MANT_DIG__ = @as(c_int, 53);
pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
pub const __DBL_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __DBL_MIN__ = @as(f64, 2.2250738585072014e-308);
pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 3.64519953188247460253e-4951);
pub const __LDBL_NORM_MAX__ = @as(c_longdouble, 1.18973149535723176502e+4932);
pub const __LDBL_HAS_DENORM__ = @as(c_int, 1);
pub const __LDBL_DIG__ = @as(c_int, 18);
pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 21);
pub const __LDBL_EPSILON__ = @as(c_longdouble, 1.08420217248550443401e-19);
pub const __LDBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __LDBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __LDBL_MANT_DIG__ = @as(c_int, 64);
pub const __LDBL_MAX_10_EXP__ = @as(c_int, 4932);
pub const __LDBL_MAX_EXP__ = @as(c_int, 16384);
pub const __LDBL_MAX__ = @as(c_longdouble, 1.18973149535723176502e+4932);
pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 4931);
pub const __LDBL_MIN_EXP__ = -@as(c_int, 16381);
pub const __LDBL_MIN__ = @as(c_longdouble, 3.36210314311209350626e-4932);
pub const __POINTER_WIDTH__ = @as(c_int, 64);
pub const __BIGGEST_ALIGNMENT__ = @as(c_int, 16);
pub const __WCHAR_UNSIGNED__ = @as(c_int, 1);
pub const __WINT_UNSIGNED__ = @as(c_int, 1);
pub const __INT8_TYPE__ = i8;
pub const __INT8_FMTd__ = "hhd";
pub const __INT8_FMTi__ = "hhi";
pub const __INT8_C_SUFFIX__ = "";
pub const __INT16_TYPE__ = c_short;
pub const __INT16_FMTd__ = "hd";
pub const __INT16_FMTi__ = "hi";
pub const __INT16_C_SUFFIX__ = "";
pub const __INT32_TYPE__ = c_int;
pub const __INT32_FMTd__ = "d";
pub const __INT32_FMTi__ = "i";
pub const __INT32_C_SUFFIX__ = "";
pub const __INT64_TYPE__ = c_longlong;
pub const __INT64_FMTd__ = "lld";
pub const __INT64_FMTi__ = "lli";
pub const __INT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `LL`");
// (no file):203:9
pub const __UINT8_TYPE__ = u8;
pub const __UINT8_FMTo__ = "hho";
pub const __UINT8_FMTu__ = "hhu";
pub const __UINT8_FMTx__ = "hhx";
pub const __UINT8_FMTX__ = "hhX";
pub const __UINT8_C_SUFFIX__ = "";
pub const __UINT8_MAX__ = @as(c_int, 255);
pub const __INT8_MAX__ = @as(c_int, 127);
pub const __UINT16_TYPE__ = c_ushort;
pub const __UINT16_FMTo__ = "ho";
pub const __UINT16_FMTu__ = "hu";
pub const __UINT16_FMTx__ = "hx";
pub const __UINT16_FMTX__ = "hX";
pub const __UINT16_C_SUFFIX__ = "";
pub const __UINT16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __INT16_MAX__ = @as(c_int, 32767);
pub const __UINT32_TYPE__ = c_uint;
pub const __UINT32_FMTo__ = "o";
pub const __UINT32_FMTu__ = "u";
pub const __UINT32_FMTx__ = "x";
pub const __UINT32_FMTX__ = "X";
pub const __UINT32_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `U`");
// (no file):225:9
pub const __UINT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __INT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __UINT64_TYPE__ = c_ulonglong;
pub const __UINT64_FMTo__ = "llo";
pub const __UINT64_FMTu__ = "llu";
pub const __UINT64_FMTx__ = "llx";
pub const __UINT64_FMTX__ = "llX";
pub const __UINT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `ULL`");
// (no file):233:9
pub const __UINT64_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __INT64_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INT_LEAST8_TYPE__ = i8;
pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
pub const __INT_LEAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_LEAST8_FMTd__ = "hhd";
pub const __INT_LEAST8_FMTi__ = "hhi";
pub const __UINT_LEAST8_TYPE__ = u8;
pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
pub const __UINT_LEAST8_FMTo__ = "hho";
pub const __UINT_LEAST8_FMTu__ = "hhu";
pub const __UINT_LEAST8_FMTx__ = "hhx";
pub const __UINT_LEAST8_FMTX__ = "hhX";
pub const __INT_LEAST16_TYPE__ = c_short;
pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
pub const __INT_LEAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_LEAST16_FMTd__ = "hd";
pub const __INT_LEAST16_FMTi__ = "hi";
pub const __UINT_LEAST16_TYPE__ = c_ushort;
pub const __UINT_LEAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_LEAST16_FMTo__ = "ho";
pub const __UINT_LEAST16_FMTu__ = "hu";
pub const __UINT_LEAST16_FMTx__ = "hx";
pub const __UINT_LEAST16_FMTX__ = "hX";
pub const __INT_LEAST32_TYPE__ = c_int;
pub const __INT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_LEAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_LEAST32_FMTd__ = "d";
pub const __INT_LEAST32_FMTi__ = "i";
pub const __UINT_LEAST32_TYPE__ = c_uint;
pub const __UINT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_LEAST32_FMTo__ = "o";
pub const __UINT_LEAST32_FMTu__ = "u";
pub const __UINT_LEAST32_FMTx__ = "x";
pub const __UINT_LEAST32_FMTX__ = "X";
pub const __INT_LEAST64_TYPE__ = c_longlong;
pub const __INT_LEAST64_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INT_LEAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_LEAST64_FMTd__ = "lld";
pub const __INT_LEAST64_FMTi__ = "lli";
pub const __UINT_LEAST64_TYPE__ = c_ulonglong;
pub const __UINT_LEAST64_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __UINT_LEAST64_FMTo__ = "llo";
pub const __UINT_LEAST64_FMTu__ = "llu";
pub const __UINT_LEAST64_FMTx__ = "llx";
pub const __UINT_LEAST64_FMTX__ = "llX";
pub const __INT_FAST8_TYPE__ = i8;
pub const __INT_FAST8_MAX__ = @as(c_int, 127);
pub const __INT_FAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_FAST8_FMTd__ = "hhd";
pub const __INT_FAST8_FMTi__ = "hhi";
pub const __UINT_FAST8_TYPE__ = u8;
pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
pub const __UINT_FAST8_FMTo__ = "hho";
pub const __UINT_FAST8_FMTu__ = "hhu";
pub const __UINT_FAST8_FMTx__ = "hhx";
pub const __UINT_FAST8_FMTX__ = "hhX";
pub const __INT_FAST16_TYPE__ = c_short;
pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
pub const __INT_FAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_FAST16_FMTd__ = "hd";
pub const __INT_FAST16_FMTi__ = "hi";
pub const __UINT_FAST16_TYPE__ = c_ushort;
pub const __UINT_FAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_FAST16_FMTo__ = "ho";
pub const __UINT_FAST16_FMTu__ = "hu";
pub const __UINT_FAST16_FMTx__ = "hx";
pub const __UINT_FAST16_FMTX__ = "hX";
pub const __INT_FAST32_TYPE__ = c_int;
pub const __INT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_FAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_FAST32_FMTd__ = "d";
pub const __INT_FAST32_FMTi__ = "i";
pub const __UINT_FAST32_TYPE__ = c_uint;
pub const __UINT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_FAST32_FMTo__ = "o";
pub const __UINT_FAST32_FMTu__ = "u";
pub const __UINT_FAST32_FMTx__ = "x";
pub const __UINT_FAST32_FMTX__ = "X";
pub const __INT_FAST64_TYPE__ = c_longlong;
pub const __INT_FAST64_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __INT_FAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_FAST64_FMTd__ = "lld";
pub const __INT_FAST64_FMTi__ = "lli";
pub const __UINT_FAST64_TYPE__ = c_ulonglong;
pub const __UINT_FAST64_MAX__ = @as(c_ulonglong, 18446744073709551615);
pub const __UINT_FAST64_FMTo__ = "llo";
pub const __UINT_FAST64_FMTu__ = "llu";
pub const __UINT_FAST64_FMTx__ = "llx";
pub const __UINT_FAST64_FMTX__ = "llX";
pub const __USER_LABEL_PREFIX__ = "";
pub const __FINITE_MATH_ONLY__ = @as(c_int, 0);
pub const __GNUC_STDC_INLINE__ = @as(c_int, 1);
pub const __GCC_ATOMIC_TEST_AND_SET_TRUEVAL = @as(c_int, 1);
pub const __GCC_DESTRUCTIVE_SIZE = @as(c_int, 64);
pub const __GCC_CONSTRUCTIVE_SIZE = @as(c_int, 64);
pub const __CLANG_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_INT_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_LONG_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_INT_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_LONG_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 2);
pub const __NO_INLINE__ = @as(c_int, 1);
pub const __PIC__ = @as(c_int, 2);
pub const __pic__ = @as(c_int, 2);
pub const __FLT_RADIX__ = @as(c_int, 2);
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const __GCC_ASM_FLAG_OUTPUTS__ = @as(c_int, 1);
pub const __code_model_small__ = @as(c_int, 1);
pub const __amd64__ = @as(c_int, 1);
pub const __amd64 = @as(c_int, 1);
pub const __x86_64 = @as(c_int, 1);
pub const __x86_64__ = @as(c_int, 1);
pub const __SEG_GS = @as(c_int, 1);
pub const __SEG_FS = @as(c_int, 1);
pub const __seg_gs = @compileError("unable to translate macro: undefined identifier `address_space`");
// (no file):365:9
pub const __seg_fs = @compileError("unable to translate macro: undefined identifier `address_space`");
// (no file):366:9
pub const __znver4 = @as(c_int, 1);
pub const __znver4__ = @as(c_int, 1);
pub const __tune_znver4__ = @as(c_int, 1);
pub const __REGISTER_PREFIX__ = "";
pub const __NO_MATH_INLINES = @as(c_int, 1);
pub const __AES__ = @as(c_int, 1);
pub const __VAES__ = @as(c_int, 1);
pub const __PCLMUL__ = @as(c_int, 1);
pub const __VPCLMULQDQ__ = @as(c_int, 1);
pub const __LAHF_SAHF__ = @as(c_int, 1);
pub const __LZCNT__ = @as(c_int, 1);
pub const __RDRND__ = @as(c_int, 1);
pub const __FSGSBASE__ = @as(c_int, 1);
pub const __BMI__ = @as(c_int, 1);
pub const __BMI2__ = @as(c_int, 1);
pub const __POPCNT__ = @as(c_int, 1);
pub const __PRFCHW__ = @as(c_int, 1);
pub const __RDSEED__ = @as(c_int, 1);
pub const __ADX__ = @as(c_int, 1);
pub const __MWAITX__ = @as(c_int, 1);
pub const __MOVBE__ = @as(c_int, 1);
pub const __SSE4A__ = @as(c_int, 1);
pub const __FMA__ = @as(c_int, 1);
pub const __F16C__ = @as(c_int, 1);
pub const __GFNI__ = @as(c_int, 1);
pub const __EVEX512__ = @as(c_int, 1);
pub const __AVX512CD__ = @as(c_int, 1);
pub const __AVX512VPOPCNTDQ__ = @as(c_int, 1);
pub const __AVX512VNNI__ = @as(c_int, 1);
pub const __AVX512BF16__ = @as(c_int, 1);
pub const __AVX512DQ__ = @as(c_int, 1);
pub const __AVX512BITALG__ = @as(c_int, 1);
pub const __AVX512BW__ = @as(c_int, 1);
pub const __AVX512VL__ = @as(c_int, 1);
pub const __EVEX256__ = @as(c_int, 1);
pub const __AVX512VBMI__ = @as(c_int, 1);
pub const __AVX512VBMI2__ = @as(c_int, 1);
pub const __AVX512IFMA__ = @as(c_int, 1);
pub const __SHA__ = @as(c_int, 1);
pub const __FXSR__ = @as(c_int, 1);
pub const __XSAVE__ = @as(c_int, 1);
pub const __XSAVEOPT__ = @as(c_int, 1);
pub const __XSAVEC__ = @as(c_int, 1);
pub const __XSAVES__ = @as(c_int, 1);
pub const __CLFLUSHOPT__ = @as(c_int, 1);
pub const __CLWB__ = @as(c_int, 1);
pub const __WBNOINVD__ = @as(c_int, 1);
pub const __SHSTK__ = @as(c_int, 1);
pub const __CLZERO__ = @as(c_int, 1);
pub const __RDPID__ = @as(c_int, 1);
pub const __RDPRU__ = @as(c_int, 1);
pub const __INVPCID__ = @as(c_int, 1);
pub const __CRC32__ = @as(c_int, 1);
pub const __AVX512F__ = @as(c_int, 1);
pub const __AVX2__ = @as(c_int, 1);
pub const __AVX__ = @as(c_int, 1);
pub const __SSE4_2__ = @as(c_int, 1);
pub const __SSE4_1__ = @as(c_int, 1);
pub const __SSSE3__ = @as(c_int, 1);
pub const __SSE3__ = @as(c_int, 1);
pub const __SSE2__ = @as(c_int, 1);
pub const __SSE2_MATH__ = @as(c_int, 1);
pub const __SSE__ = @as(c_int, 1);
pub const __SSE_MATH__ = @as(c_int, 1);
pub const __MMX__ = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_16 = @as(c_int, 1);
pub const __SIZEOF_FLOAT128__ = @as(c_int, 16);
pub const _WIN32 = @as(c_int, 1);
pub const _WIN64 = @as(c_int, 1);
pub const WIN32 = @as(c_int, 1);
pub const __WIN32 = @as(c_int, 1);
pub const __WIN32__ = @as(c_int, 1);
pub const WINNT = @as(c_int, 1);
pub const __WINNT = @as(c_int, 1);
pub const __WINNT__ = @as(c_int, 1);
pub const WIN64 = @as(c_int, 1);
pub const __WIN64 = @as(c_int, 1);
pub const __WIN64__ = @as(c_int, 1);
pub const __MINGW64__ = @as(c_int, 1);
pub const __MSVCRT__ = @as(c_int, 1);
pub const __MINGW32__ = @as(c_int, 1);
pub const __declspec = @compileError("unable to translate C expr: unexpected token '__attribute__'");
// (no file):452:9
pub const _cdecl = @compileError("unable to translate macro: undefined identifier `__cdecl__`");
// (no file):453:9
pub const __cdecl = @compileError("unable to translate macro: undefined identifier `__cdecl__`");
// (no file):454:9
pub const _stdcall = @compileError("unable to translate macro: undefined identifier `__stdcall__`");
// (no file):455:9
pub const __stdcall = @compileError("unable to translate macro: undefined identifier `__stdcall__`");
// (no file):456:9
pub const _fastcall = @compileError("unable to translate macro: undefined identifier `__fastcall__`");
// (no file):457:9
pub const __fastcall = @compileError("unable to translate macro: undefined identifier `__fastcall__`");
// (no file):458:9
pub const _thiscall = @compileError("unable to translate macro: undefined identifier `__thiscall__`");
// (no file):459:9
pub const __thiscall = @compileError("unable to translate macro: undefined identifier `__thiscall__`");
// (no file):460:9
pub const _pascal = @compileError("unable to translate macro: undefined identifier `__pascal__`");
// (no file):461:9
pub const __pascal = @compileError("unable to translate macro: undefined identifier `__pascal__`");
// (no file):462:9
pub const __STDC__ = @as(c_int, 1);
pub const __STDC_HOSTED__ = @as(c_int, 1);
pub const __STDC_VERSION__ = @as(c_long, 201710);
pub const __STDC_UTF_16__ = @as(c_int, 1);
pub const __STDC_UTF_32__ = @as(c_int, 1);
pub const __STDC_EMBED_NOT_FOUND__ = @as(c_int, 0);
pub const __STDC_EMBED_FOUND__ = @as(c_int, 1);
pub const __STDC_EMBED_EMPTY__ = @as(c_int, 2);
pub const _DEBUG = @as(c_int, 1);
pub const gr_context_DEFINED = "";
pub const sk_types_DEFINED = "";
pub const __CLANG_STDINT_H = "";
pub const __int_least64_t = i64;
pub const __uint_least64_t = u64;
pub const __int_least32_t = i64;
pub const __uint_least32_t = u64;
pub const __int_least16_t = i64;
pub const __uint_least16_t = u64;
pub const __int_least8_t = i64;
pub const __uint_least8_t = u64;
pub const __uint32_t_defined = "";
pub const __int8_t_defined = "";
pub const __stdint_join3 = @compileError("unable to translate C expr: unexpected token '##'");
// C:\Users\Alpa\Documents\zig-windows-x86_64-0.14.0-dev.1730+034577555\lib\include/stdint.h:291:9
pub const __intptr_t_defined = "";
pub const _INTPTR_T = "";
pub const _UINTPTR_T = "";
pub const __int_c_join = @compileError("unable to translate C expr: unexpected token '##'");
// C:\Users\Alpa\Documents\zig-windows-x86_64-0.14.0-dev.1730+034577555\lib\include/stdint.h:328:9
pub inline fn __int_c(v: anytype, suffix: anytype) @TypeOf(__int_c_join(v, suffix)) {
    _ = &v;
    _ = &suffix;
    return __int_c_join(v, suffix);
}
pub const __uint_c = @compileError("unable to translate macro: undefined identifier `U`");
// C:\Users\Alpa\Documents\zig-windows-x86_64-0.14.0-dev.1730+034577555\lib\include/stdint.h:330:9
pub const __int64_c_suffix = __INT64_C_SUFFIX__;
pub const __int32_c_suffix = __INT64_C_SUFFIX__;
pub const __int16_c_suffix = __INT64_C_SUFFIX__;
pub const __int8_c_suffix = __INT64_C_SUFFIX__;
pub inline fn INT64_C(v: anytype) @TypeOf(__int_c(v, __int64_c_suffix)) {
    _ = &v;
    return __int_c(v, __int64_c_suffix);
}
pub inline fn UINT64_C(v: anytype) @TypeOf(__uint_c(v, __int64_c_suffix)) {
    _ = &v;
    return __uint_c(v, __int64_c_suffix);
}
pub inline fn INT32_C(v: anytype) @TypeOf(__int_c(v, __int32_c_suffix)) {
    _ = &v;
    return __int_c(v, __int32_c_suffix);
}
pub inline fn UINT32_C(v: anytype) @TypeOf(__uint_c(v, __int32_c_suffix)) {
    _ = &v;
    return __uint_c(v, __int32_c_suffix);
}
pub inline fn INT16_C(v: anytype) @TypeOf(__int_c(v, __int16_c_suffix)) {
    _ = &v;
    return __int_c(v, __int16_c_suffix);
}
pub inline fn UINT16_C(v: anytype) @TypeOf(__uint_c(v, __int16_c_suffix)) {
    _ = &v;
    return __uint_c(v, __int16_c_suffix);
}
pub inline fn INT8_C(v: anytype) @TypeOf(__int_c(v, __int8_c_suffix)) {
    _ = &v;
    return __int_c(v, __int8_c_suffix);
}
pub inline fn UINT8_C(v: anytype) @TypeOf(__uint_c(v, __int8_c_suffix)) {
    _ = &v;
    return __uint_c(v, __int8_c_suffix);
}
pub const INT64_MAX = INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const INT64_MIN = -INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const UINT64_MAX = UINT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const __INT_LEAST64_MIN = INT64_MIN;
pub const __INT_LEAST64_MAX = INT64_MAX;
pub const __UINT_LEAST64_MAX = UINT64_MAX;
pub const __INT_LEAST32_MIN = INT64_MIN;
pub const __INT_LEAST32_MAX = INT64_MAX;
pub const __UINT_LEAST32_MAX = UINT64_MAX;
pub const __INT_LEAST16_MIN = INT64_MIN;
pub const __INT_LEAST16_MAX = INT64_MAX;
pub const __UINT_LEAST16_MAX = UINT64_MAX;
pub const __INT_LEAST8_MIN = INT64_MIN;
pub const __INT_LEAST8_MAX = INT64_MAX;
pub const __UINT_LEAST8_MAX = UINT64_MAX;
pub const INT_LEAST64_MIN = __INT_LEAST64_MIN;
pub const INT_LEAST64_MAX = __INT_LEAST64_MAX;
pub const UINT_LEAST64_MAX = __UINT_LEAST64_MAX;
pub const INT_FAST64_MIN = __INT_LEAST64_MIN;
pub const INT_FAST64_MAX = __INT_LEAST64_MAX;
pub const UINT_FAST64_MAX = __UINT_LEAST64_MAX;
pub const INT32_MAX = INT32_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal));
pub const INT32_MIN = -INT32_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal)) - @as(c_int, 1);
pub const UINT32_MAX = UINT32_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 4294967295, .decimal));
pub const INT_LEAST32_MIN = __INT_LEAST32_MIN;
pub const INT_LEAST32_MAX = __INT_LEAST32_MAX;
pub const UINT_LEAST32_MAX = __UINT_LEAST32_MAX;
pub const INT_FAST32_MIN = __INT_LEAST32_MIN;
pub const INT_FAST32_MAX = __INT_LEAST32_MAX;
pub const UINT_FAST32_MAX = __UINT_LEAST32_MAX;
pub const INT16_MAX = INT16_C(@as(c_int, 32767));
pub const INT16_MIN = -INT16_C(@as(c_int, 32767)) - @as(c_int, 1);
pub const UINT16_MAX = UINT16_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal));
pub const INT_LEAST16_MIN = __INT_LEAST16_MIN;
pub const INT_LEAST16_MAX = __INT_LEAST16_MAX;
pub const UINT_LEAST16_MAX = __UINT_LEAST16_MAX;
pub const INT_FAST16_MIN = __INT_LEAST16_MIN;
pub const INT_FAST16_MAX = __INT_LEAST16_MAX;
pub const UINT_FAST16_MAX = __UINT_LEAST16_MAX;
pub const INT8_MAX = INT8_C(@as(c_int, 127));
pub const INT8_MIN = -INT8_C(@as(c_int, 127)) - @as(c_int, 1);
pub const UINT8_MAX = UINT8_C(@as(c_int, 255));
pub const INT_LEAST8_MIN = __INT_LEAST8_MIN;
pub const INT_LEAST8_MAX = __INT_LEAST8_MAX;
pub const UINT_LEAST8_MAX = __UINT_LEAST8_MAX;
pub const INT_FAST8_MIN = __INT_LEAST8_MIN;
pub const INT_FAST8_MAX = __INT_LEAST8_MAX;
pub const UINT_FAST8_MAX = __UINT_LEAST8_MAX;
pub const __INTN_MIN = @compileError("unable to translate macro: undefined identifier `INT`");
// C:\Users\Alpa\Documents\zig-windows-x86_64-0.14.0-dev.1730+034577555\lib\include/stdint.h:875:10
pub const __INTN_MAX = @compileError("unable to translate macro: undefined identifier `INT`");
// C:\Users\Alpa\Documents\zig-windows-x86_64-0.14.0-dev.1730+034577555\lib\include/stdint.h:876:10
pub const __UINTN_MAX = @compileError("unable to translate macro: undefined identifier `UINT`");
// C:\Users\Alpa\Documents\zig-windows-x86_64-0.14.0-dev.1730+034577555\lib\include/stdint.h:877:9
pub const __INTN_C = @compileError("unable to translate macro: undefined identifier `INT`");
// C:\Users\Alpa\Documents\zig-windows-x86_64-0.14.0-dev.1730+034577555\lib\include/stdint.h:878:10
pub const __UINTN_C = @compileError("unable to translate macro: undefined identifier `UINT`");
// C:\Users\Alpa\Documents\zig-windows-x86_64-0.14.0-dev.1730+034577555\lib\include/stdint.h:879:9
pub const INTPTR_MIN = -__INTPTR_MAX__ - @as(c_int, 1);
pub const INTPTR_MAX = __INTPTR_MAX__;
pub const UINTPTR_MAX = __UINTPTR_MAX__;
pub const PTRDIFF_MIN = -__PTRDIFF_MAX__ - @as(c_int, 1);
pub const PTRDIFF_MAX = __PTRDIFF_MAX__;
pub const SIZE_MAX = __SIZE_MAX__;
pub const INTMAX_MIN = -__INTMAX_MAX__ - @as(c_int, 1);
pub const INTMAX_MAX = __INTMAX_MAX__;
pub const UINTMAX_MAX = __UINTMAX_MAX__;
pub const SIG_ATOMIC_MIN = __INTN_MIN(__SIG_ATOMIC_WIDTH__);
pub const SIG_ATOMIC_MAX = __INTN_MAX(__SIG_ATOMIC_WIDTH__);
pub const WINT_MIN = __UINTN_C(__WINT_WIDTH__, @as(c_int, 0));
pub const WINT_MAX = __UINTN_MAX(__WINT_WIDTH__);
pub const WCHAR_MAX = __WCHAR_MAX__;
pub const WCHAR_MIN = __UINTN_C(__WCHAR_WIDTH__, @as(c_int, 0));
pub inline fn INTMAX_C(v: anytype) @TypeOf(__int_c(v, __INTMAX_C_SUFFIX__)) {
    _ = &v;
    return __int_c(v, __INTMAX_C_SUFFIX__);
}
pub inline fn UINTMAX_C(v: anytype) @TypeOf(__int_c(v, __UINTMAX_C_SUFFIX__)) {
    _ = &v;
    return __int_c(v, __UINTMAX_C_SUFFIX__);
}
pub const __need_ptrdiff_t = "";
pub const __need_size_t = "";
pub const __need_wchar_t = "";
pub const __need_NULL = "";
pub const __need_max_align_t = "";
pub const __need_offsetof = "";
pub const __STDDEF_H = "";
pub const _PTRDIFF_T = "";
pub const _SIZE_T = "";
pub const _WCHAR_T = "";
pub const NULL = @import("std").zig.c_translation.cast(?*anyopaque, @as(c_int, 0));
pub const __CLANG_MAX_ALIGN_T_DEFINED = "";
pub const offsetof = @compileError("unable to translate C expr: unexpected token 'an identifier'");
// C:\Users\Alpa\Documents\zig-windows-x86_64-0.14.0-dev.1730+034577555\lib\include/__stddef_offsetof.h:16:9
pub const __STDBOOL_H = "";
pub const __bool_true_false_are_defined = @as(c_int, 1);
pub const @"bool" = bool;
pub const @"true" = @as(c_int, 1);
pub const @"false" = @as(c_int, 0);
pub const SK_C_PLUS_PLUS_BEGIN_GUARD = "";
pub const SK_C_PLUS_PLUS_END_GUARD = "";
pub const SK_C_API = "";
pub const VKAPI_ATTR = "";
pub const VKAPI_CALL = @compileError("unable to translate C expr: unexpected token '__stdcall'");
// skia/include/c/sk_types.h:44:13
pub const VKAPI_PTR = VKAPI_CALL;
pub inline fn SK_TO_STRING(X: anytype) @TypeOf(SK_TO_STRING_IMPL(X)) {
    _ = &X;
    return SK_TO_STRING_IMPL(X);
}
pub const SK_TO_STRING_IMPL = @compileError("unable to translate C expr: unexpected token '#'");
// skia/include/c/sk_types.h:65:13
pub const SK_C_INCREMENT = @as(c_int, 0);
pub inline fn sk_color_set_argb(a: anytype, r: anytype, g: anytype, b: anytype) @TypeOf((((a << @as(c_int, 24)) | (r << @as(c_int, 16))) | (g << @as(c_int, 8))) | b) {
    _ = &a;
    _ = &r;
    _ = &g;
    _ = &b;
    return (((a << @as(c_int, 24)) | (r << @as(c_int, 16))) | (g << @as(c_int, 8))) | b;
}
pub inline fn sk_color_get_a(c: anytype) @TypeOf((c >> @as(c_int, 24)) & @as(c_int, 0xFF)) {
    _ = &c;
    return (c >> @as(c_int, 24)) & @as(c_int, 0xFF);
}
pub inline fn sk_color_get_r(c: anytype) @TypeOf((c >> @as(c_int, 16)) & @as(c_int, 0xFF)) {
    _ = &c;
    return (c >> @as(c_int, 16)) & @as(c_int, 0xFF);
}
pub inline fn sk_color_get_g(c: anytype) @TypeOf((c >> @as(c_int, 8)) & @as(c_int, 0xFF)) {
    _ = &c;
    return (c >> @as(c_int, 8)) & @as(c_int, 0xFF);
}
pub inline fn sk_color_get_b(c: anytype) @TypeOf((c >> @as(c_int, 0)) & @as(c_int, 0xFF)) {
    _ = &c;
    return (c >> @as(c_int, 0)) & @as(c_int, 0xFF);
}
pub const FONTMETRICS_FLAGS_UNDERLINE_THICKNESS_IS_VALID = @as(c_uint, 1) << @as(c_int, 0);
pub const FONTMETRICS_FLAGS_UNDERLINE_POSITION_IS_VALID = @as(c_uint, 1) << @as(c_int, 1);
pub const gr_mtl_handle_t = @compileError("unable to translate C expr: unexpected token 'const'");
// skia/include/c/sk_types.h:745:9
pub const sk_canvas_DEFINED = "";
pub const sk_colorspace_DEFINED = "";
pub const sk_data_DEFINED = "";
pub const sk_image_DEFINED = "";
pub const sk_paint_DEFINED = "";
pub const sk_path_DEFINED = "";
pub const sk_surface_DEFINED = "";
