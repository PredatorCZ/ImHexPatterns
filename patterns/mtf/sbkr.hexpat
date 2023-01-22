struct UnkStruct0 {
    u32 unk[6];
};

struct UnkStruct1 {
    char name[];
    u32 unk[20];
};

struct Header {
    u32 id;
    u32 version;
    u32 unkCount0;
    u32 unkCount1;
    u32 unkCount2;

    UnkStruct0 unk0[unkCount0];
    UnkStruct1 unk1[unkCount1];
};

Header hdr @0;
