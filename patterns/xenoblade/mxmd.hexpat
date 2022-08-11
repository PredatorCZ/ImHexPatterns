#include <std/ptr.pat>
#include <std/io.pat>
#pragma endian big
#pragma array_limit 10000
#pragma pattern_limit 10000

fn Pp(u128) {
	return addressof(parent.parent);
};

fn p(u128) {
	return addressof(parent);
};

fn t(u128) {
	return addressof(this);
};

struct CString {
	char text[];
};

struct CASMTTexture {
	u32 unk;
	u32 dataSize;
	u32 dataOffset;
	CString *name : u32 [[inline, pointer_base("Pp")]];
};

struct CASMTGroup {
	u32 numTextures;
	CASMTTexture *textures[numTextures] : u32[[inline, pointer_base("p")]];
	u32 unk;
	u32 nameBufferSize;
};

struct CASMTGroupPtr {
	CASMTGroup *group : u32 [[inline, pointer_base("Pp")]];
};

struct CASMTHeader {
	u32 data;
	u32 numGroups;

	CASMTGroupPtr group[2] [[inline]];
	u16 *ids0[group[0].group.numTextures] : u32 [[pointer_base("p")]];
	u16 *ids1[group[1].group.numTextures] : u32 [[pointer_base("p")]];
	u32 datasOffsets[2] [[inline]];
	u32 dataSizes[2] [[inline]];
};

struct ShaderBinding {
	u16 unk0;
	u16 unk1;
	u16 unk2;
	u16 unk3;
};

struct Shader00 {
	u16 unk0;
	u16 unk1;
};

struct Shader {
	u32 samplerBindings[[hidden]];
	u32 numSamplers[[hidden]];
	u32 uniformValueBindings[[hidden]];
	u32 numUniformVars[[hidden]];
	u32 uoff3;
	u32 uoff4;
	u32 ucnt4;
	u32 unk3;
	u32 uoff5[[hidden]];
	u32 ucnt5[[hidden]];
	u32 unkarr[7];

	ShaderBinding samplerBindings[numSamplers] @ addressof(parent) + samplerBindings;
	ShaderBinding uniformVarBindings[numUniformVars] @ addressof(parent) + uniformValueBindings;
	Shader00 shader00 @ addressof(parent) + uoff4;
	ShaderBinding bind00[ucnt5] @ addressof(parent) + uoff5;
};

// Hierarchy header where 1 is ucnt1+uoff2 and 0 is ucnt2+uoff3
struct Material001 {
	u16 startIndex0;
	u16 startIndex1;
	u8 count0;
	u8 count1;
	u8 null[2];
};

struct Material002 {
	u16 unk0;
	u16 unk1;
};

struct Material003 {
	u32 shaderIndex;
	u16 unk2;
	u16 materialIndex;
	u32 unk4;
};

struct Material00 {
	u32 numMaterials;
	Material001 *materialBinds[numMaterials] : u32[[pointer_base("Pp")]];
	u32 ucnt1;
	Material002 *uoff2[ucnt1] : u32 [[pointer_base("Pp")]];
	u32 ucnt2;
	Material003 *uoff3[ucnt2] : u32[[pointer_base("Pp")]];
};

struct Texture {
	u16 textureIndex;
	u16 unk;
};

struct Unkn {
	u16 unk1;
	u16 unk2;
	u16 unk3;
	u16 unk4;
	u16 unk5;
	u16 unk6;
};

struct Material {
    char *name[] : u32 [[pointer_base("Pp")]];
    u32 unktype1;
    float ufloat1[13];
    u32 texturesPtr;
    u32 numTextures;
    u32 uint2[9];
    u32 offset2;
    u32 count2;
    u32 null[6];

	Texture textures[numTextures] @ addressof(parent) + texturesPtr;
	Unkn unk[count2] @ addressof(parent) + offset2;
};

struct MaterialsHeader {
	u32 materialsPtr;
	u32 numMaterials;
	u32 unk00[2];
	u32 floatsPtr[[hidden]];
	u32 numFloats[[hidden]];
	u32 uintsPtr[[hidden]];
	u32 numUints[[hidden]];
	u32 unk01;
	u32 unkOffset00;
	u32 shadersPtr[[hidden]];
	u32 numShaders[[hidden]];
	u32 unk02[3];
	u32 unkOffset02;
	u32 unk03[3];
	u32 unkOffset03;
	u32 unk04[2];
	Material00 *unkOffset04 : u32[[pointer_base("p")]];
	u32 unk05[3];

	Material masterials[numMaterials] @ addressof(this) + materialsPtr;
	Shader shaders[numShaders] @ addressof(this) + shadersPtr;
	float floats[numFloats] @ addressof(this) + floatsPtr;
	u32 uints[numUints] @ addressof(this) + uintsPtr;
};

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

struct Header {
	u32 id;
	u32 version;
	Model *models : u32;
	MaterialsHeader *materials : u32;
	u32 unk00;
	u32 streams;
	u32 shaders;
	CASMTGroup *cachedTextures : u32;
	u32 unk01;
	CASMTHeader *uncachedTextures : u32;
};

Header hdr @0;
