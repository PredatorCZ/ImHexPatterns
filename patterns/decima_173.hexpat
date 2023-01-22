#pragma MIME decima/core-173
#pragma endian big
#pragma pattern_limit 1000000
#include <std/sys.pat>

struct PackedInt {
    u8 _index0;

    if (_index0 == 0x81) {
        s16 _index1;
    } else if (_index0 == 0x80) {
        s32 _index2;
    }
}[[transform("fmtPackedInt"), format("fmtPackedInt"), sealed]];

fn fmtPackedInt(PackedInt input) {
    if (input._index0 == 0x81) {
        return input._index1;
    } else if (input._index0 == 0x80) {
        return input._index2;
    } else {
        return input._index0;
    }
};

struct PackedUInt {
    u8 _index0;

    if (_index0 == 0xfe) {
        u16 _index1;
    } else if (_index0 == 0xff) {
        u32 _index2;
    }
}[[format("fmtPackedUInt"), sealed]];

fn fmtPackedUInt(PackedUInt input) {
    if (input._index0 == 0xfe) {
        return input._index1;
    } else if (input._index0 == 0xff) {
        return input._index2;
    } else {
        return input._index0;
    }
};

fn getPackedUIntSize(PackedUInt input) {
    if (input._index0 == 0xfe) {
        return 2;
    } else if (input._index0 == 0xff) {
        return 4;
    } else {
        return 1;
    }
};

struct ClassName {
    PackedInt len;
    char name[len];
}[[transform("fmtClassName"), format("fmtClassName"), sealed]];

fn fmtClassName(ClassName input) {
    return input.name;
};

struct InstanceDesc {
    u128 hash;
    u32 dataSize;
};

struct Unk00 {
    PackedInt unk0;
    u32 check0;
    u16 check1;
};

struct String {
    PackedInt blockSize;
    PackedUInt strLen;
    char data[blockSize - getPackedUIntSize(strLen)];
};

struct StringGroup {
    if (parent.numClasses > 0x100)
        u16 type;
    else
        u8 type;
    PackedInt numStrings;
    String strings[numStrings];
};

struct Instance {
    PackedInt unk00;
    u8 h_10;
    u8 h_81;
    u8 h_00;
    u16 h_FFFF;
    PackedInt index;
};

struct Heap {
    PackedInt chSize;
	PackedInt unk02; //alignment?
	u8 h_81;
	u8 h_00;
	u16 h_FFFF;
	PackedInt instanceIndex;
};

struct Heaps {
    PackedInt count;
    Heap heaps[count];
};

struct ResourceLink {
    u8 type;
    if (type == 0) {
        if (hdr.numInstances > 256)
            u16 instanceID;
        else
            u8 instanceID;
    } else if (type == 2) {
        u8 hSize;
        char objectHash[hSize];
    }
}[[format("fmtResourceLink")]];

fn fmtResourceLink(ResourceLink input) {
    if (input.type == 0) {
        if (input.instanceID) {
            return hdr.classNames[hdr.classIndex[input.instanceID - 1]];
        } else {
            return "null";
        }
    } else {
        return input.objectHash;
    }
};

struct Name {
    if (hdr.groups[0].numStrings > 0x100)
        u16 nameID;
    else
        u8 nameID;
}[[format("fmtName"), sealed]];

fn fmtName(Name input) {
    return hdr.groups[0].strings[input.nameID].data;
};

s32 curInstance;
curInstance = 0;

fn isClass(str name) {
    return hdr.classNames[hdr.classIndex[curInstance]] == name;
};

struct VertexWeight {
    u16 pos[3];
    u8 weight[2];
    u8 unk[12];
};

struct SkinInfo {
    u8 unk[21];
    PackedInt numWeights;
    VertexWeight unk05[numWeights];
};

struct SKD {
    float unk0;
    float unk1;
    u16 unk2;
    u16 unk3;
};

struct SMUnk00 {
    float unk18[12];
};

struct Matrix44 {
    float data[16];
};

struct BBOX {
    float min[3];
    float max[3];
};

struct Lod {
    ResourceLink mesh;
    float distance;
};

struct MultiMesh {
    ResourceLink mesh;
    float tm[16];
};

struct Shader {
    u32 dataSize;
    u8 data[dataSize];
};

struct InstanceData {
    Heaps cpuHeaps;
    Heaps gpuHeaps;

    if (isClass("Texture")) {
        u32 null0;
        u8 width;
        u8 height;
        u16 numMips;
        u8 format;
        u16 unk0;
        u8 unk1;
        u32 totalTexelSize;
        u32 null1;
        if (totalTexelSize != gpuHeaps.heaps[0].chSize)
            u32 streamOffset;
        u8 cachedTexels[gpuHeaps.heaps[0].chSize];
    } else if (isClass("RegularSkinnedMeshResourceSkinInfo")) {
        u8 numSkins;
        SkinInfo info[numSkins];
        PackedInt null;
    } else if (isClass("SKDTreeResource")) {
        float min[3];
        float max[3];
        PackedInt unk;
        SKD skd[unk];
    } else if (isClass("RenderingPrimitiveResource")) {
        u32 unk00;
        ResourceLink vertexArray;
        ResourceLink indexArray;
        u32 unk;
        float bbox[6];
        ResourceLink skdTree;
        u8 null[4];
        u32 numIndices;
        ResourceLink renderEffect;
    } else if (isClass("SkinnedModelResource")) {
        Name name;
        u8 unk00;
		PackedInt numModels;
		ResourceLink model[numModels];
		u8 null00[6];
		ResourceLink skeleton;
		u8 null01[6];
		u8 unk100;
        std::assert(unk100 == 0, "");
        //TODO

        s16 unk121[2];
		ResourceLink abilityAnimation;
		ResourceLink abilityUnk;
		ResourceLink abilitySimpleAnimation;
		ResourceLink abilityRagdoll;
		ResourceLink abilityFootPlacement;
		ResourceLink abilityTwoBoneIK;
		ResourceLink abilityShaderAnimation;
		ResourceLink link0;
		ResourceLink link1;
        u8 unk0122;
		u8 unk0123;
		ResourceLink lookats[unk0122];

        s32 unk17;
		SMUnk00 unk18[unk17];
		Matrix44 matrices[unk17];
		s32 unk19;
		s32 unk20[unk19];
		BBOX bbox;
    } else if (isClass("ModelPartResource")) {
        Name name;
        PackedInt numParts;
		ResourceLink mesh;
        ResourceLink boneBBoxes;
        ResourceLink collision;
        bool unk0;
        u32 unk1;
    } else if (isClass("RegularSkinnedMeshResource")) {
		ResourceLink link0;
        BBOX bbox;
        u8 unk0[5];
        ResourceLink link1;
        char unk1[14];
        ResourceLink boneBindings;
        ResourceLink boneBBoxes;
        ResourceLink skinInfo;
        PackedInt numRenderPrimitives;
        ResourceLink renderPrimitives[numRenderPrimitives];
        PackedInt numRenderEffects;
        ResourceLink renderEffects[numRenderEffects];
        BBOX bbox1;
    } else if (isClass("LodMeshResource")) {
        ResourceLink link0;
        BBOX bbox;
        u32 unk0;
        bool unk1;
        PackedInt numLods;
        Lod lods[numLods];
        float unk2;
    } else if (isClass("MultiMeshResource")) {
        ResourceLink link0;
        BBOX bbox;
        u32 unk0;
        bool unk1;
        PackedInt numMeshes;
        MultiMesh meshes[numMeshes];
    } else if (isClass("ShaderResource")) {
        u8 unk[7];
        Name name0;
        Name name1;
        u32 unk1;
        Shader vp;
        Shader fp;
    }
    else {
        padding[hdr.instanceDescs[curInstance].dataSize];
    }

    curInstance += 1;
};

struct InstanceDataSkip {
    Heaps cpuHeaps;
    Heaps gpuHeaps;
    padding[hdr.instanceDescs[curInstance].dataSize];
    curInstance += 1;
};

using CI8 = u8 [[format("fmtClassIndex")]];
using CI16 = u16 [[format("fmtClassIndex")]];

fn fmtClassIndex(auto idx) {
    return hdr.classNames[idx];
};

struct Header {
    char id[15];
    bool unk0;
    u32 unk1[3];
    u16 unk2[2];
    PackedInt numClasses;
    ClassName classNames[numClasses];
    PackedInt numInstances;

    if (numClasses > 0x100) {
        CI16 classIndex[numInstances];
    } else {
        CI8 classIndex[numInstances];
    }

    PackedInt numUsedObjects;
    InstanceDesc instanceDescs[numInstances];

    PackedInt numUnk00;
    Unk00 unk00[numUnk00];

    PackedInt numGroups;
    StringGroup groups[numGroups];

    PackedInt numUnk01;
    PackedInt numInstances_;
    Instance instances[numInstances];
};

Header hdr @0;
InstanceDataSkip skips[146] @$ [[hidden]];
InstanceData instanceData[10] @$;
