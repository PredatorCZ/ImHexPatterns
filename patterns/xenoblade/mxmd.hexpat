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

struct Header {
	u32 id;
	u32 version;
	u32 models;
	u32 materials;
	u32 unk00;
	u32 streams;
	u32 shaders;
	u32 cachedTextures;
	u32 unk01;
	CASMTHeader *uncachedTextures : u32 [[pointer_base("p")]];
};

Header hdr @0;
