#pragma pattern_limit 1000000
#define TH : u32 [[inline, pointer_base("t")]]

fn t(u128) {
	return $;
};

enum VtViewSlot : u8 {
    Float3,
    Float2,
    Short2,
    Short4,
    Byte4,
    IndexShort,
    IndexInt,
    NumSlots,
};

enum VtType : u8 {
    Position,
    Normal,
    Tangent,
    TexCoord,
    TexCoordUnsigned,
    Color,
};

struct VtView {
    u32 offset;
    u32 size;
};

struct VtAttr {
    u32 viewOffset;
    VtType type;
    VtViewSlot viewSlot;
    padding[2];
};

struct VtIndex {
    u32 viewOffset;
    u32 count;
    VtViewSlot viewSlot;
    padding[3];
};

struct VertexBlock {
    float bboxMax[3];
    float bboxMin[3];
    u32 numVertices;
    u32 numVerticesAttrs;
    VtAttr *attributes[numVerticesAttrs] TH;
};

struct Stream {
    u32 numIndices;
    VtIndex *indices[numIndices] TH;
    u32 numVertices;
    VertexBlock *vertices[numVertices] TH;
    VtView views[VtViewSlot::NumSlots];
};

struct Header {
    u32 id;
    u32 version;
    u32 bufferSize;
    u32 numStreams;
    Stream *streams[numStreams] TH;
};

Header hdr @0;
