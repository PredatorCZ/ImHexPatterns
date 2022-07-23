#include <std/ptr.pat>
#include <std/io.pat>

u32 headerBegin;

fn header_base(u16) {
    return headerBegin;
};

enum BaseType : u8 {
    None,
    Default,
    Array,
    Flag,
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
};

struct DataDesc {
    BaseType baseType;
    if (baseType == BaseType::Flag) {
        u8 flagIndex;
        u16 null;
        BE u16 value;
        BE u16 parentDesc;
    } else {
        DataType dataType;
        BE u16 offset;
    }

    if (baseType == BaseType::Array) {
        BE u16 arrayLen;
    }
};

struct KeyDesc {
    DataDesc *desc : BE u16[[pointer_base("header_base")]];
    BE u16 null;
    BE u16 nameOffset;

    char name[] @headerBegin + nameOffset;

    if (desc.baseType == BaseType::Flag) {
        std::print("Flag{}[{}] {} = {}", desc.parentDesc, desc.flagIndex, name, desc.value);
    } else {
        std::print("{} {} {}", desc.dataType, name, desc.baseType);
    }
};

struct Header {
    u32 id;
    u16 unk0;
    u16 name;
    u16 kvBlockSize;
    u16 unk1Offset;
    u16 unk1Size;
    u16 keyValuesOffset;
    u16 numKeyValues;
    u16 unk3;
    u16 numEncKeys;
    u8 encKeys[2];
    u32 strings;
    u32 stringsSize;
    u16 keyDescsOffset;
    u16 numKeyDescs;

    u16 unk1Data[unk1Size] @addressof(unk1Offset) + unk1Offset;
    KeyDesc keyDescs[numKeyDescs] @addressof(keyDescsOffset) + keyDescsOffset;
    //KeyValue keyValues[numKeyValues] @addressof(keyValuesOffset) + keyValuesOffset;
    u8 keyValueData[numKeyValues * kvBlockSize] @addressof(keyValuesOffset) + keyValuesOffset;
};
