struct Shader {
    u32 unk;
    char meshName[];
    char materialName[];
    char shaderType[];
    char shaderName[];
    u32 unk0;

    if (shaderType == "BumpAnisotropic_Blended\x00" || shaderType == "BumpAnisotropic\x00") {
        char alebedoTexture[];
        char normalTexture[];
        char anisotropyTexture[];
        float ambient[4];
        float diffuse[4];
        float specular[4];
        float unk1[5];
        float albedoUVScale[2];
        float normalUVScale[2];
        u8 masked;
        u32 blended;
    } else if (shaderType == "Glow_Blended\x00" || shaderType == "Glow\x00") {
        char glowTexture[];
        float glowUVScale[2];
        float unk1[2];
        float velocity[2];
        float glowLevel;
        float glowFactor;
        u8 blended;
        float fogFactor;
    } else if (shaderType == "Unlit_Blended\x00" || shaderType == "Unlit\x00") {
        float ambient[4];
        float diffuse[4];
        u8 unk1[36];
        u8 generatedShadows;
        u8 translucent;
        u8 null;
        u8 unk2[8];
        char alebedoTexture[];
        float pulseFrequency;
        u8 unk3[8];
        float velocity[2];
        u8 unk4[16];
        float fogFactor;
        u8 blended;
        float fogOutFactor;
        u8 vertexAlpha;
    } else if (shaderType == "BumpSpecular_Blended\x00" || shaderType == "BumpSpecular\x00") {
        float ambient[4];
        float diffuse[4];
        float specular[4];
        float unk1[5];
        u8 generatedShadows;
        u8 translucent;
        u8 masked;
        u8 unk2[8];
        char alebedoTexture[];
        char normalTexture[];
        float albedoUVScale[2];
        float normalUVScale[2];
        float albedoUVOffset[2];
        float normalUVOffset[2];
        u32 blended;
    }
};

struct Buffers {
    u8 isUsed;
    if (isUsed) {
        u32 numVertices;
        u32 vertexStride;
        u8 vertexBuffer[numVertices * vertexStride];
        u32 numFaces;
        u32 indexBufferSize;
        u8 indexBuffer[indexBufferSize];
    }
};

struct Primitive {
    char name[];
    char materialName[];
    u32 numVertices;
    u32 unk0;
    u32 numIndices;
    u32 vertexBase;
    u32 vertexOffset;
    u32 indexOffset;
    u32 numBones;
    u32 boneOffset;
};

struct IBM {
    float tm[16];
};

struct Bound {
    float aabb[6];
};

struct SkinBone {
    u32 index;
    u32 unk;
    char name[];
};

struct RootBone {
    IBM tm;
    u32 null;
    u64 hash;
    char name[];
};

struct Bone {
    u32 numBones;
    RootBone bones[numBones];
};

struct LodModel {
    Buffers buffers[3];
    u32 numPrimitives;
    Primitive primitives[numPrimitives];
    u32 numSkinBones;
    IBM ibms[numSkinBones];
    u32 numBounds;
    Bound bounds[numBounds];
    u32 numSkinBones1;
    SkinBone skinBones[numSkinBones1];
    RootBone rootBone;
    Bone bones[1];
};

struct Header {
    u32 id;
    u8 versionMajor;
    u8 versionMinor;
    u32 numShaders;

    Shader shaders[numShaders];
    //LodModel lod0;
    //u32 numLods;
    //LodModel lods[numLods];
};

Header hdr @0;
