#pragma once

struct Primitive {
	u32 flags;
	u32 skinDescriptor;
	u32 bufferID;
	u32 UVFacesID;
	u32 unk00;
	u32 materialID;
	u32 null00[2];
	u32 gibID;
	u32 null01;
	u32 meshFacesID;
	u32 null02[5];
  };

struct Mesh {
	u32 primitivesPtr;
	u32 numPrimitives;
	u32 null0;
	float bboxMax[3];
	float bboxMin[3];
	float boundingRadius;
	u32 null[7];

	Primitive primitives[numPrimitives] @ addressof(parent) + primitivesPtr;
};

struct Model {
	float bboxMin[3];
	float bboxMax[3];
	u32 meshesPtr;
	u32 numMeshes;
	u32 skins;
	u32 numSkins;
	u32 unk00[3];
	u32 attachmentsOffset2;
	u32 unk01[6]; // TODO
	u32 bones;
	u32 numBones;
	u32 floats;
	u32 numFloat;
	u32 unk02;
	u32 boneNames;
	u32 numBoneNames;
	u32 unk03;
	u32 attachmentsOffset;
	u32 attachmentsCount;
	u32 unkOffset00;
	u32 unk04[4];
	u32 unkOffset01;
	u32 unk05; // TODO

	Mesh meshes[numMeshes] @ addressof(this) + meshesPtr;
};

struct ExternalTexture {
	u16 textureID;
	u16 containerID;
	u16 externalTextureID;
	u16 unk;
};
