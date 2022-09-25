#include <std/ptr.pat>
#include <std/io.pat>
#pragma endian big
#pragma array_limit 10000
#pragma pattern_limit 10000

#include "xenoblade/mdo.pat"
#include "xenoblade/texres.pat"

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
