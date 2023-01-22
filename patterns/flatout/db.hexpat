#pragma pattern_limit 1000000
#include <std/io.pat>

fn HeaderBase(auto) {
    return addressof(parent);
};

enum DBValueType : u8 {
    None,
    UINT8,
    STRING,
    BOOL32 = 5,
    INT32,
    FLOAT,
    COLOR,
    VECTOR2,
    VECTOR3,
    VECTOR4,
    REF,
};

enum DBValueSubType : u8 {
    Simple,
    Array,
    CString,
};

struct DBValue {
    char *name[] : u32 [[pointer_base("HeaderBase"), inline]];
    DBValueType type;
    u16 dataSize;
    DBValueSubType subType;
    u32 tag; // 0xA data, 0x165c7a0 ref
    u8 data[dataSize];
};

struct DBNode {
    u32 null;
    s16 parentNodeSkipIndex; // relative to this node
    u16 numChildren;
    s16 prevEntrySkipIndex; // previous entry on the same level, relative to this node
    u16 numValues;
    char *nodeName[] : u32 [[pointer_base("HeaderBase"), inline]];
    DBValue *dataOffset[numValues] : u32 [[pointer_base("HeaderBase"), inline]];
};

struct Header {
    u32 id;
    u32 version;
    u32 numNodes;
    DBNode nodes[numNodes];
};

Header hdr @0;
