

struct BDATBase {
    u32 id;
    u8 version;
    u8 size;
    u16 type;
};

struct Key {
    u32 keyHash;
    u32 index;
};

enum DataType : u8 {
    None,
    uint8,
    uint16,
    uint32,
    int8,
    int16,
    int32,
    StringPtr, // 7
    Float,
    KeyHash,
    Unk = 11, // Pointer??
};

struct Descriptor {
    DataType baseType;
    u16 nameOffset;
};

struct BDAT : BDATBase {
    u32 numDescs;
    u32 numKeys;
    u32 unk3;
    u32 encKey; //or self hash
    u32 descriptors;
    u32 keys;
    u32 values;
    u32 kvBlockSize;
    u32 strings;
    u32 stringsSize;

    Descriptor descs[numDescs] @addressof(this) + descriptors;
    Key keys[numKeys] @addressof(this) + keys;
    u8 keyValueData[numKeys * kvBlockSize] @addressof(this) + values;
};

BDATBase base @0;
u32 numDatas @$;
u32 fileSize @$;
u32 dataOffsets[numDatas] @$;

u32 dataIndex in;

BDAT hdr @dataOffsets[dataIndex];
