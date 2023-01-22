struct Header {
    char id[24];
    u64 blockStart;
    u64 blockEnd;
    u64 numBlocks;
};

struct Node {
    char id[24];
    u32 nextBlock;
    u32 nextChild;
    u32 data;
    u32 dataSize;
    u32 dataCount;
    u32 unk;
};

Header hdr @0;

Node nodes[(hdr.blockEnd - hdr.blockStart) / 48] @ hdr.blockStart;
/*
struct UnkStr0 {
    u32 blockIndex;
    u16 unk1;
    u16 unk2;
};

struct XcrUnk0 {
    u32 unk0;
    u32 unk1;
    u32 unk2;
};

struct XcrUnk1 {
    u32 unk0;
    u32 unk1;
    u32 unk2;
};

struct XcrLe {
    u32 unk0;
    XcrUnk0 unk1[unk0];
    u32 unk4;
    XcrUnk1 unk5[unk4];

    u32 unk6Size;
    u16 unk6[unk1[0].unk1];

    padding[$ % 4];

    UnkStr0 unk7[unk1[0].unk1];

    u32 blockSize;
};


XcrLe xcrLe @$;
*/
