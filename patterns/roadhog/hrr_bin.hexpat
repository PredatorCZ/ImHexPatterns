#pragma array_limit 100000
#pragma pattern_limit 100000000

struct File {
    u32 fileNameLen;
    char fileName[fileNameLen];
    u32 uncompressedSize;
    u32 compressedSize;
    u64 offset;
    u64 unk;
};

u32 numFiles @ 0x0;
File files[numFiles] @$;
u32 dataOffset @$;