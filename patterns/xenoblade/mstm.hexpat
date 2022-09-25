#pragma endian big
#include "xenoblade/mdo.pat"

fn p(u128) {
	return addressof(parent);
};

struct TerrainBufferLookup {
    float bbox[6];
    u32 bufferIndex0;
    u32 bufferIndex1;
    u32 null;
};

struct TerrainBufferLookupHeader {
    u32 bufferLookupsOffset;
    u32 bufferLookupCount;
    u32 groupIndicesOffset;
    u32 groupIndicesCount;
    u32 unk00;
    u32 null00[6];

    TerrainBufferLookup lookups[bufferLookupCount] @ bufferLookupsOffset + addressof(this);
    u16 indices[groupIndicesCount] @ groupIndicesOffset + addressof(this);
};

struct Header {
    u16 unk00;
    u16 unk01;
    u32 null02[2];
    Model *models : u32;
    u32 materials;
    u32 unk02;
    u32 unk03;
    u32 externalTexturesOffset;
    u32 numExternalTextures;
    u32 unkoffsets01[2];
    u32 shaders;
    u32 textureContainerIds;
    u32 numTextureContainerIds;
    TerrainBufferLookupHeader *bufferHeader : u32;
    u32 unkoffsets02[7];

    ExternalTexture externalTextures[numExternalTextures] @ externalTexturesOffset;
};

Header hdr @0;
