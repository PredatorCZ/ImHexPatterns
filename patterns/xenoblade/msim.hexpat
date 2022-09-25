#pragma endian big
#include "xenoblade/mdo.pat"

fn p(u128) {
	return addressof(parent);
};

struct InstancedModel {
    float unk[8];
    u32 modelIndex;
};

struct InstancesHeader {
    u32 null00;
    u32 numClusters;
    u32 clusters;
    u32 numModels;
    InstancedModel *models[numModels] : u32 [[inline, pointer_base("p")]];
    u32 numMatrices;
    u32 matrices;
    u32 unk01[16];
    u32 null01[6];
};

struct Header {
    u16 unk00;
    u16 unk01;
    u32 null02[2];
    Model *models : u32;
    u32 materials;
    u32 unk02;
    InstancesHeader *instances : u32;
    u32 unk03;
    u32 externalTexturesOffset;
    u32 numExternalTextures;
    u32 bufferIndicesOffset;
    u32 numBufferIndices;
    u32 unkoffsets01[5];
    u32 shaders;
    u32 textureContainerIds;
    u32 numTextureContainerIds;
    u32 unkoffsets02[6];

    u32 bufferIndices[numBufferIndices] @ bufferIndicesOffset;
    ExternalTexture externalTextures[numExternalTextures] @ externalTexturesOffset;
};

Header hdr @0;
