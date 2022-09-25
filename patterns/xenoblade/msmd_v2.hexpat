#pragma endian little
#include "xenoblade/texres.pat"

struct StreamEntry {
  u32 offset;
  u32 size;
};

struct BBOX {
  float min[3];
  float max[3];
};

struct Bounds {
  BBOX bbox;
  float center[3];
};

struct TerrainModel {
  Bounds bounds;
  float unk03[4];
  StreamEntry entry;
  float unk04[4];
};

struct ObjectModel {
  Bounds bounds;
  float unk03[4];
  StreamEntry entry;
  u32 unk01;
};

struct SkyboxModel {
  Bounds bounds;
  float unk03[4];
  StreamEntry entry;
};

struct ObjectTextureFile {
  StreamEntry midMap;
  StreamEntry highMap;
  u32 unk;
};

struct Tm {
    float m[16];
};

struct Mdo {
    u32 *mdo : u32 [[pointer_base("Pp")]];
    char *mdoName[] : u32 [[pointer_base("Pp")]];
    u32 unk[5];
};

struct Unk00 {
    u32 offset0;
    u32 count0;
    u32 numTms;
    Tm *tms[numTms] : u32 [[pointer_base("p")]];
    u32 offset1;

    Mdo mdos[count0] @ addressof(this) + offset0;
};

struct Unk010 {
    u32 unk;
    u32 null[2];
};

struct Unk011 {
    char *name[] : u32 [[pointer_base("Pp")]];
    u32 count0;
    u16 unk0;
    u16 unk1;
    u32 null[3];
};

struct Unk01 {
    u32 offset0;
    u32 count0;
    u32 count1;
    u32 null00[4];
    u32 count2;
    u32 offset1;
    u32 count3;
    u32 count4;
    u32 offset2;
    u32 count5;
    Tm tms[count5] @ addressof(this) + offset2;
    Unk010 unk010[count3] @ addressof(this) + offset1;
    Unk011 unk011[count0] @ addressof(this) + offset0;
};


struct Unk021 {
    u32 null;
    char *name[] : u32 [[pointer_base("Pp")]];
    u32 *data : u32[[pointer_base("Pp")]];
    u32 size;
    u32 null[6];
};

struct Unk02 {
    u32 count0;
    Unk021 *offset0[count0] : u32 [[pointer_base("p")]];
    u32 null[4];
};

struct Header {
    u32 id;
    u32 version;
    u32 null00[4];

    u32 terrainModelsCount[[hidden]];
    TerrainModel *terrainModels[terrainModelsCount] : u32;
    u32 objectsCount[[hidden]];
    ObjectModel *objects[objectsCount] : u32;
    u32 null0;
    u32 null1;
    u32 skyboxModelsCount[[hidden]];
    SkyboxModel *skyboxModels[skyboxModelsCount] : u32;
    u32 unk01;
    u32 null00[5];
    u32 objectStreamsCount[[hidden]];
    StreamEntry *objectStreams[objectStreamsCount] : u32;
    u32 objectTexturesCount[[hidden]];
    ObjectTextureFile *objectTextures[objectTexturesCount] : u32;
    u32 null00;
    u32 null10;
    u32 null20;
    u32 null30;
    u32 null40;
    u32 null50;
    u32 null60;
    Unk00 *unk : u32;
    u32 null80;
    char *cachedTGLD : u32;
    u32 null81;
    u32 null91;
    u32 terrainCachedTexturesCount[[hidden]];
    StreamEntry *terrainCachedTextures[terrainCachedTexturesCount] : u32;
    u32 null02;
    u32 null12;
    u32 null22;
    u32 null32;
    u32 null42;
    u32 null52;
    Unk01 *null62 : u32;
    u32 null72;
    u32 null82;
    u32 null92;
    u32 null82;
    u32 null92;
    u32 null01;
    u32 unkCount0[[hidden]];
    StreamEntry *unk0[unkCount0] : u32;
    char *nerd : u32;
    u32 null14;
    u32 null24;
    u32 null34;
    Unk02 *lbig : u32;
    char *dlcm : u32;
    u32 null64;
    u32 null74;
    u32 null84;
    u32 null94;
    u32 null84;
    u32 null94;
    u32 null04;
  };

  Header hdr @0;
