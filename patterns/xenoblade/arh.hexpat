#include <std/io.pat>
#pragma pattern_limit 1000000
#pragma array_limit 80000

struct FileEntry {
    u64 dataOffset;
    u32 compressedSize;
    u32 uncompressedSize;
    u32 compressed;
    u32 index;
}[[static]];

struct Nodes {
    u32 a;
    u32 b;
}[[static]];

struct Header {
    u32 id;
    u32 keySeed;
    u32 numNodes;
    u32 offset1;
    u32 size1;
    u32 offset2;
    u32 size2;
    u32 fileEntries;
    u32 numFiles;

    FileEntry entries[numFiles] @ fileEntries;
    Nodes nodes[numNodes] @ offset2;
};

Header hdr @ 0;




