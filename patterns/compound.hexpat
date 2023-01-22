#pragma MIME application/CDFV2
#include <std/io.pat>

struct SectorID {
    u32 index;
}[[format("SectorIDfmt")]];

fn SectorIDfmt(SectorID input) {
    if (input.index == 0xFFFFFFFE) {
        return "ENDOFCHAIN";
    } else if (input.index == 0xFFFFFFFF) {
        return "FREESECT";
    } else if (input.index == 0xFFFFFFFD) {
        return "FATSECT";
    } else if (input.index == 0xFFFFFFFC) {
        return "DIFSECT";
    }
    return std::format("{}", input.index);
};

struct Header {
    u64 signature;
    u8 clsid[16];
    u16 minorVersion;
    u16 majorVersion;
    u16 byteOrder;
    u16 sectorShift;
    u16 miniSectorShift;
    u8 reserved[6];
    u32 numDirSectors;
    u32 numFATSectors;
    SectorID firstDirSectorIndex;
    u32 transactionSignature;
    u32 miniStreamCutoffSize;
    SectorID firstMiniFATSectorIndex;
    u32 numMiniFATSectors;
    SectorID firstDIFATSectorIndex;
    u32 numDIFATSectors;
    SectorID DIFAT[109];
};

Header header @0;
u32 SECTOR_SIZE out;
SECTOR_SIZE = 1 << header.sectorShift;

fn GetSector(SectorID input) {
    if (input.index < 0xFFFFFFFC) {
        return (input.index + 1) * SECTOR_SIZE;
    }
};

enum ObjectType : u8 {
    Unknown,
    Storage,
    Stream,
    RootStorage = 5,
};

enum TreeColor : u8 {
    Red,
    Black,
};

struct SiblingID {
    u32 index;
}[[format("SiblingIDfmt")]];

fn SiblingIDfmt(SiblingID input) {
    if (input.index == 0xFFFFFFFA) {
        return "MAXREGSID";
    } else if (input.index == 0xFFFFFFFF) {
        return "NOSTREAM";
    }
    return std::format("{}", input.index);
};

struct DirectorySector {
    char16 entryName[32];
    u16 entryNameLength;
    ObjectType objectType;
    TreeColor treeColor;
    SiblingID leftSibling;
    SiblingID rightSibling;
    SiblingID child;
    u8 clsid[16];
    u32 stateBits;
    u32 creationTime[2];
    u32 modificationTime[2];
    SectorID startingSector;
    u64 streamSize;
}[[static]];

DirectorySector rootDir[SECTOR_SIZE / sizeof(DirectorySector)] @ GetSector(header.firstDirSectorIndex);

struct FATChain {
    SectorID nextSector;
    SectorID sectors[(SECTOR_SIZE / 4) - 1];
};

FATChain miniFATs @ GetSector(header.firstMiniFATSectorIndex);

FATChain FATs @ GetSector(header.DIFAT[0]);
