#include <std/io.pat>
#include <std/ptr.pat>
#pragma array_limit 10000
#pragma pattern_limit 10000

fn Pp(u128) { return addressof(parent.parent); };

fn p(u128) { return addressof(parent); };

struct Primitive {
  u32 drawFlags;
  u32 flags;
  u16 bufferID;
  u16 meshFacesID;
  u16 groupID;
  u16 materialID;
  u32 null00[3];
  u16 unk01;
  u16 LOD;
  u16 meshFacesID;
  u16 unk06;
  s32 parentPrimitive;
  u32 null01[2];
}[[single_color]];

struct Mesh {
  u32 primitivesPtr;
  u32 numPrimitives;
  u32 unk00;
  float bboxMax[3];
  float bboxMin[3];
  float boundingRadius;

  Primitive primitives[numPrimitives] @addressof(parent) + primitivesPtr;
};

struct BoneIBM {
  float data[16];
};

struct BoneTM {
  float pos[4];
  float rot[4];
};

enum BoneTMType : u32 {
    Null,
    Unk, // Local?
    Global,
};

struct Bone {
  char *name[] : u32 [[pointer_base("Pp")]];
  float boundingRadius;
  BoneTMType tmType;
  u32 tmId;
  u32 null[2];
};

struct Skin {
  u32 count1;
  u32 count2;
  u32 nodesPtr;
  u32 nodesIBMPtr;
  u32 nodesTMs0Ptr;
  u32 nodesTMs1Ptr;

  BoneIBM ibms[count1] @addressof(this) + nodesIBMPtr;
  Bone bones[count1] @addressof(this) + nodesPtr;

};

struct MorphControl {
  u32 name1;
  u32 name2;
  u32 data[5];
};

struct Morphs {
  u32 controlsPtr;
  u32 numControls;
  u32 unk[4];
};

struct Model {
  u32 unk00;
  float bboxMin[3];
  float bboxMax[3];
  u32 meshesPtr;
  u32 numMeshes;
  u32 null00;
  Skin *skin : u32 [[pointer_base("p")]];
  u32 null01[10];
  u32 unkCount00;
  u32 null02[10];
  Morphs *morphs : u32 [[pointer_base("p")]];
  u32 unkOffset00;
  u32 unkOffset01;
  u32 unkOffset02;
  u32 unkOffset03;
  u32 unkCount01;

  Mesh meshes[numMeshes] @addressof(this) + meshesPtr;
};

struct Header {
  u32 id;
  u32 version;
  Model *models : u32;
  u32 *materials : u32;
  u32 unk00;
  u32 streams;
  u32 shaders;
  u32 *cachedTextures : u32;
  u32 unk01;
  u32 *uncachedTextures : u32;
};

Header hdr @0;
