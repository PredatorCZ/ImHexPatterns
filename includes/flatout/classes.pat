#pragma once

struct Material {
  u32 id;
  char type[];
  u32 null[2];
  u32 usedTextures;
  u32 unk0;
  u32 unk1[25];
  char texture0[];
  char texture1[];
  char texture2[];
} [[single_color]];

struct MapMesh {
  u32 primitiveIndex;
  u32 unk;
  u32 trackBVHItem; // natvis group?
  float bbox[6];
}[[static]];

struct FoliageLOD {
  float pos[3];
  float size[2];
  u32 unk[2];
}[[static]];

struct BMOD {
  u32 id;
  u32 null;
  char partName[];
  float bboxCenter[3];
  float bboxMax[3];
  float boundingRadius;
  u32 numPrimitives;
  u32 primitiveIndex[numPrimitives];
};

bitfield MeshFlags {
  padding: 15;
  castShadow: 1;
  padding: 16;
};

struct MESH {
  u32 id;
  char meshName[];
  char dynamicObject[];
  be MeshFlags flags;
  s32 triggerGroup;
  float tm[16];
  u32 numBMODs;
  u32 BMODIndices[numBMODs];
};

struct OBJC {
  u32 id;
  char name[];
  char unk[];
  u32 flag;
  float tm[16];
};

struct Dynamic {
  u32 numMeshes;
  u32 meshIndex[numMeshes];
  float bboxCenter[3];
  float bboxMax[3];
};

struct DynamicLods {
  char name[];
  s32 lod0;
  s32 lod1;
};
