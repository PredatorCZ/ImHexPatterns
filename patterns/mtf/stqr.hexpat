
struct Str0 {
    char *name[] : u64;
    u32 unk1[4];
    u32 unk2[2];
    u32 unk3[2];
};

struct Str1 {

};

struct Header {
    u32 id;
    u32 version;
    u32 numUnk0;
    u32 numUnk1;
    Str0 *unk0[numUnk0] : u64;
    Str1 *unk1[numUnk1] : u64;
};

Header hdr @0;
