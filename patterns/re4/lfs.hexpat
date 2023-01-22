

struct Chunk {
    u16 compressedSize;
    u16 uncompressedSize;
    u32 offset;
};

struct Header {
    u32 id;
    u32 id2;
    u32 uncompressedSize;
    u32 compressedSize;
    u32 numChunks;
    Chunk chunks[numChunks];
};

Header hdr @0;
