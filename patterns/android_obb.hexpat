//#pragma pattern_limit 150000

struct File {
    u32 hash;
    u32 offset;
    u32 size;
    u32 crc;
}[[static]];

struct Header {
    u32 id;
    u32 version;
    u32 numFiles;
    u32 filesCRC;

    File files[numFiles];
};

Header hdr @0;
