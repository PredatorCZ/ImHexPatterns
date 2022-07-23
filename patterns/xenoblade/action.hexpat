#pragma MIME xenoblade-x/action-script
#pragma endian big
#pragma pattern_limit 30000

struct MotionResource {
    char resourceName[32];
    char animationName[68];
    float unk[9];
}[[static]];

struct Unk0 {
    u32 unk0;
    u32 unk1;
    u32 unk3;
    float unk4;
};

struct Motions {
    u32 numResources;
    u32 unkCount;
    MotionResource res[numResources];
    Unk0 unk0[unkCount];
};

struct Data0 {
    u32 index;
    u32 unk[2];
};

struct Data1 {
    u32 index;
    s32 unk[2];
};

struct Data2 {
    u16 index0; // if 3 data is ref to offsets[4]
    u16 unk0; // padding?
    float data0;
    u16 index1;
    u16 unk1; // padding?
    float data1;
    u32 unk2;
    s32 unk3;
};

struct SecondaryHeader {
    s32 offsets[5];
    u32 counts[5];

    if (offsets[0] >= 0) {
        Data0 data0[counts[0]] @$ + offsets[0];
    }

    if (offsets[1] >= 0) {
        Data1 data1[counts[1]] @$ + offsets[1];
    }

    if (offsets[2] >= 0) {
        Data2 data2[counts[2]] @$ + offsets[2];
    }

    if (offsets[3] >= 0) {
        u32 ids[counts[3]] @$ + offsets[3];
    }
};

fn anp(s128) {
    return addressof(parent.parent) + (parent.parent.numNames + 1) * 4;
};

struct ActionName {
    char *name[] : u32 [[pointer_base("anp")]];
};

struct ActionNames {
    u32 numNames;
    ActionName names[numNames];
};

struct Header {
    u32 id;
    char name[16];
    Motions *motions : u32;
    u32 unk[2];
    u32 null0[2];

    u32 tag; // 0x10a00
    u32 null1;
    SecondaryHeader *secondaryHeader : u32;
    ActionNames *actionNames : u32;
};

struct Node {
    u16 blockSize;
    u16 nodeType;

    if (blockSize == 8 && nodeType == 1)
        break;

    char data[blockSize - 8];
    u16 returnNum; // negative relative return address?
    u16 null;
};

struct ControlFlow {
    u32 unk0[5];
    u32 count; // number of entries?
    u32 unk1[5];

    Node nodes0[while(true)];
};

Header hdr @0;
ControlFlow controlFlow @$;
