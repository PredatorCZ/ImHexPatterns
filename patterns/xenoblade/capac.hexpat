#pragma MIME xenoblade-x/pac
#pragma endian big
#pragma array_limit 10000
#pragma pattern_limit 200000

// Contains packed files, custom compression for file data

struct Group {
    u32 unk0;
    u32 pathName; // relative to strings
    u32 start;
    u32 count;
};

struct UnkStruct {
    u16 start;
    u16 count;
};

struct File {
    u16 unkStructStart;
    u8 unk0;
    u8 unk0;
    u32 fileName; // relative to strings
    u32 huffmanData;
    u32 fileSize;
}[[single_color]];

struct Header {
    u32 id;
    u32 version; // 0x1004
    u32 numFolders;
    Group *folders[numFolders] : u32;
    u32 numFileGroups;
    Group *fileGroups[numFileGroups] : u32;
    u32 count2;
    UnkStruct *offset2[count2] : u32;
    u32 numFiles;
    File *files[numFiles] : u32;
    u32 strings;
    u32 dataChunks;
    u32 numDataChunks;
    u32 count6;
};

Header header @0;
u32 dataChunks[header.numDataChunks] @header.dataChunks;
