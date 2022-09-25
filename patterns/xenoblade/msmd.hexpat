#pragma endian big

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

struct EmbededHKX {
  Bounds bounds;
  float unk03[4];
  StreamEntry entry;
  u32 unk00[3];
  u32 nameOffset;
  u32 unk01[3];
};

struct SkyboxModel {
  Bounds bounds;
  float unk03[4];
  StreamEntry entry;
};

struct DataEntry {
  u32 *data : u32;
  u32 size;
};

struct ObjectTextureFile {
  StreamEntry midMap;
  StreamEntry highMap;
  u32 unk;
};

struct TGLDEntry {
  BBOX bounds;
  StreamEntry entry;
  u32 unk01[6];
};

struct TerrainLODModel {
  Bounds bounds;
  float unk00;
  StreamEntry entry;
  u32 unk01[2];
  float unk02[4];
};

struct Grass {
  Bounds bounds;
  float unk03[4];
  StreamEntry entry;
};

struct TGLDNamePtr {
   char *name[] : u32;
};

struct BlockEntry {
  DataEntry data;
  u32 index;
  u32 null[4];
};

struct BVSCBlock {
  u32 hash;
  u32 offset0;
  u32 count0;
  DataEntry data0;

  BlockEntry data1[count0] @ offset0;
};

struct Header {
  u32 id;
  u32 version;
  u32 null00[4];

  u32 terrainModelsCount[[hidden]];
  TerrainModel *terrainModels[terrainModelsCount] : u32;
  u32 objectsCount[[hidden]];
  ObjectModel *objects[objectsCount] : u32;
  u32 hkColisionsCount[[hidden]];
  EmbededHKX *hkColisions[hkColisionsCount] : u32;
  u32 skyboxModelsCount[[hidden]];
  SkyboxModel *skyboxModels[skyboxModelsCount] : u32;
  u32 null00[6];
  u32 objectStreamsCount[[hidden]];
  StreamEntry *objectStreams[objectStreamsCount] : u32;
  u32 objectTexturesCount[[hidden]];
  ObjectTextureFile *objectTextures[objectTexturesCount] : u32;
  char *havokNames[] : u32;
  u32 grassCount[[hidden]];
  Grass *grass[grassCount] : u32;
  u32 unk00Count[[hidden]];
  StreamEntry *unk00[unk00Count] : u32;
  u32 unk01Count[[hidden]];
  StreamEntry *unk01[unk01Count] : u32;
  u32 tgldNamesCount[[hidden]];
  TGLDNamePtr *tgldNames[tgldNamesCount] : u32;
  char *cachedTGLD : u32;
  u32 tgldsCount[[hidden]];
  TGLDEntry *tglds[tgldsCount] : u32;
  u32 terrainCachedTexturesCount[[hidden]];
  StreamEntry *terrainCachedTextures[terrainCachedTexturesCount] : u32;
  u32 terrainStreamingTexturesCount[[hidden]];
  StreamEntry *terrainStreamingTextures[terrainStreamingTexturesCount] : u32;
  DataEntry bvscBlock;
  DataEntry LCMD;
  u32 effectsCount[[hidden]];
  StreamEntry *effects[effectsCount] : u32;
  u32 terrainLODModelsCount[[hidden]];
  TerrainLODModel *terrainLODModels[terrainLODModelsCount] : u32;
  u32 null02;
  u32 unk02Count[[hidden]];
  StreamEntry *unk02[unk02Count] : u32;
  u32 mapTerrainBuffersCount[[hidden]];
  StreamEntry *mapTerrainBuffers[mapTerrainBuffersCount] : u32;
  char *CESM : u32;

  BVSCBlock bvsc @ addressof(bvscBlock.data);
};

Header hdr @0;
