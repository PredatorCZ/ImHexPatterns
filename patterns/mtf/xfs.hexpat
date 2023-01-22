

fn HeaderBase(auto) {
    return 24;
};

enum Type : u8 {
    ClassRef = 1,
    RefArray = 2,
    Bool = 3,
    UInt32 = 6,
    Int32 = 10,
    UCVector4 = 15,
    String = 14,
    Float = 12,
    Matrix = 19,
    Vector4 = 20,
    Vector3 = 35,
};

struct SubType {
    char *name[] : u64 [[pointer_base("HeaderBase"), inline]];
    Type type;
    u8 flags;
    u16 dataSize;
    padding[4];
    padding[64];
};

struct Layout {
    u32 hash;
    u32 null;
    u64 numSubTypes;

    SubType members[numSubTypes];
};

struct LayoutOffset {
    Layout *layout : u64 [[pointer_base("HeaderBase"), inline]];
};

struct SubTypex10 {
    char *name[] : u32 [[pointer_base("HeaderBase"), inline]];
    Type type;
    u8 flags;
    u16 dataSize;
    padding[32];
};

struct Layoutx10 {
    u32 hash;
    u32 numSubTypes;

    SubTypex10 members[numSubTypes];
};

struct LayoutOffsetx10 {
    Layoutx10 *layout : u32 [[pointer_base("HeaderBase"), inline]];
};

struct Header {
    u32 id;
    u16 version;

    if (version == 0xf) {
        u16 unk0;
        u64 unk1;
        u32 numLayouts;
        u32 dataStart;

        LayoutOffset layoutOffsets[numLayouts] [[inline]];

        u8 data @ dataStart + 24;
    } else if (version == 0x10) {
        u16 unk0;
        u64 unk1;
        u32 numLayouts;
        u32 dataStart;

        LayoutOffsetx10 layoutOffsets[numLayouts] [[inline]];

        u8 data @ dataStart + 24;
    }
};

Header hdr @0;
