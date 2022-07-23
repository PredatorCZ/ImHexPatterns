#include <flatout/uc_classes.pat>
#pragma array_limit 100000
#pragma pattern_limit 100000000
#pragma endian little

struct Foliage {
  u32 unk0[3];
  u32 trackBVHItem; // natvis group?
  float tm[16];
  float unk[3];
  s32 trunkPrimitiveIndex;
  s32 branchesPrimitiveIndex;
  s32 spritePrimitiveIndex;
  s32 spriteIndices;
  s32 lodSpriteIndex;
  s32 lodMaterialIndex;
  s32 indices[19];
}[[static]];

u32 modelType @ 0x0;
u32 unk @$;
u32 numMaterials @$;
Material materials[numMaterials] @$;
u32 numStreams @$;
Stream streams[numStreams] @$;
u32 numPrimitives @$;
Primitive primitives[numPrimitives] @$;
u32 numMapMeshes @$;
MapMesh mapMeshes[numMapMeshes] @$;
u32 numFoliageLods @$;
FoliageLOD foliageLods[numFoliageLods] @$;
u32 numFoliages @$;
Foliage foliages[numFoliages] @$;
float tm[16] @$;
u32 numBMODs @$;
BMOD bmods[numBMODs] @$;
u32 numOBJCs @$;
OBJC objects[numOBJCs] @$;
u32 numDynamics @$;
Dynamic dynamics[numDynamics] @$;
u32 numDynamicLods @$;
DynamicLods dynamicLods[numDynamicLods] @$;
u32 numMeshTriggerGroups @$;
u32 numMeshes @$;
MESH meshes[numMeshes] @$;
