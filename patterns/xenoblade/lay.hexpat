struct Unk00 {
    u8 d;
};

struct Texture {
    u32 unk;
    u32 offset;
    u32 size;
};

struct Unk01 {
    u32 texturesOffset;
    u32 numTextures;

    Texture textures[numTextures] @ texturesOffset + addressof(this);
};

struct Image {
    u32 offset;
    u32 size;
    u32 unk0;
    u32 unk1;
};


struct Unk02 {
    u32 texturesOffset;
    u32 numTextures;

    Image textures[numTextures] @ texturesOffset;
};


struct Header {
    u32 id;
    u32 version;
    u32 numTextures;
    Unk00 *unk00 : u32;
    u32 null00;
    Unk00 *unk01 : u32;
    Unk00 *unk02 : u32;
    Unk00 *unk03 : u32;
    Unk00 *unk04 : u32;
    Unk01 *unk05 : u32;
    u32 unk01;
    Unk00 *unk06 : u32;
    u32 offset[5];
    Unk02 *unk07 : u32;
};

Header hdr @0;
