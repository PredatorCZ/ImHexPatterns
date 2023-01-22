struct Vector4A16 {
    float x, y, z, w;
};

struct Vector {
    float x, y, z;
};

struct Matrix44 {
    Vector4A16 r0, r1, r2, r3;
};

struct MODBoneV1_5 {
    u8 index;
    u8 parentIndex;
    u8 mirrorIndex;
    padding[1];
    float furthestVertexDistance;
    float parentDistance;
    Vector absolutePosition;
};

struct MODBoneV2 {
    u16 index;
    u8 parentIndex;
    u8 mirrorIndex;
    float furthestVertexDistance;
    float parentDistance;
    Vector absolutePosition;
};

struct MODBounds {
    Vector4A16 boundingSphere;
    Vector4A16 bboxMin;
    Vector4A16 bboxMax;
};

struct MODEnvelope {
    u32 boneIndex;
    padding[12];
    MODBounds bounds;
    Matrix44 localTransform;
    Vector4A16 absolutePosition;
};

struct MODGroup {
    u32 index;
    padding[12];
    Vector4A16 boundingSphere;
};

struct MODMetaDataV1 {
    u32 middleDistance;
    u32 lowDistance;
    u32 lightGroup;
    u8 boundaryJoint; //??
    padding[3];
};

struct MODMetaDataV2 : MODMetaDataV1 {
    u32 numEnvelopes;
};

enum PrimitiveType : u8 {
    Points,
    Lines,
    LineStrips,
    Triangles,
    Strips,
};

bitfield BitField00 {
    groupID : 12;
    materialIndex : 12;
    lodFlags : 8;
};

bitfield BitField01 {
    visible : 1;
    flag0 : 1;
    flag1 : 1;
    unk0 : 5;
    unk1 : 8;
    vtBuffStride : 8;
    primitiveType : 5;
    unk2 : 3;
};

struct MODMeshXC3 {
    s16 unk;
	u16 numVertices;
	BitField00 data0;
	BitField01 data1;
	u32 vertexBaseOffset;
	u32 vertexOffset;
	u32 vertexFormat;
	u32 faceBaseOffset;
	u32 numFaces;
	u32 faceOffset;
    u16 numEnvelopes;
	u16 meshIndex;
	u16 minVertex;
	u16 maxVertex;
	u32 unk02; // envelopes ptr?
};


struct MODMeshXD3 {
    s16 unk;
	u16 numVertices;
	BitField00 data0;
	BitField01 data1;
	u32 vertexBaseOffset;
	u32 vertexOffset;
	u32 vertexFormat;
	u32 faceBaseOffset;
	u32 numFaces;
	u32 faceOffset;
	u8 skinBoneOffset;
    u8 numEnvelopes;
	u16 meshIndex;
	u16 minVertex;
	u16 maxVertex;
	u32 unk02; // envelopes ptr?
};

struct MODMeshXD3PSN : MODMeshXD3 {
    padding[8];
};

struct MODMeshX2CFF {
    s16 unk;
	u16 numVertices;
    BitField00 data0;
	BitField01 data1;
	u32 vertexBaseOffset;
	u32 vertexOffset;
	u32 vertexFormat;
	u32 faceBaseOffset;
	u32 numFaces;
	u32 faceOffset;
	u8 skinIndex;
    u8 numEnvelopes;
	u16 meshIndex;
	u16 minVertex;
	u16 maxVertex;
	u32 unk02; // envelopes ptr?
    u32 null[2];
};

struct MODHeaderCommon {
    u32 id;
    s16 version;
    u16 numBones;
    u16 numMeshes;
    u16 numMaterials;
    u32 numVertices;
    u32 numIndices;
    u32 numEdges;
};


struct SkinX2C {
    u8 usedNodes;
    u8 nodes[42];
};

struct MODBonesX2CFF {
    MODBoneV2 bones[parent.numBones];
    Matrix44 refPoses[parent.numBones];
    Matrix44 ibms[parent.numBones];
    u8 remaps[0x100];
    SkinX2C skins[parent.numSkins];
};

struct MODModelXC3 {
    MODMeshXC3 meshes[parent.numMeshes];
    u32 numEnvelopes;
    MODEnvelope envelopes[numEnvelopes];
};

struct MODModelX2CFF {
    MODMeshX2CFF meshes[parent.numMeshes];
    u32 numEnvelopes;
    MODEnvelope envelopes[numEnvelopes];
};

struct MODHeaderXC3 : MODHeaderCommon {
    u32 vertexBufferSize;
    u32 numTextures;
    u32 numGroups;
    u32 bones;
    MODGroup *groups[numGroups] : u32;
    u32 *materials : u32;
    MODModelXC3 *meshes : u32;
    u32 vertexBuffer;
    u32 indices;
    padding[4];
    MODBounds bounds;
    MODMetaDataV1 meta;
};

struct MaterialName {
    char name[128];
};

struct MODHeaderXD3 : MODHeaderCommon {
    u32 vertexBufferSize;
    u32 numTextures;
    u32 numGroups;
    padding[sizeof(PT) - 4];
    PT bones;
    MODGroup *groups[numGroups] : PT;

    if (sizeof(PT) == 8) {
        MaterialName *materials[numMaterials] : PT;
    } else {
        u32 *materials[numMaterials] : PT;
    }

    MODMeshXD3PSN *meshes[numMeshes] : PT;
    PT vertexBuffer;
    PT indices;
    PT fileSize;
    MODBounds bounds;
    MODMetaDataV2 meta;

    MODEnvelope envelopes[meta.numEnvelopes] @ addressof(meshes) + sizeof(MODMeshXD3PSN) * numMeshes;
};

struct MODHeaderXD2 : MODHeaderCommon {
    u32 vertexBufferSize;
    u32 numTextures;
    u32 numGroups;
    u32 bones;
    MODGroup *groups[numGroups] : u32;
    MaterialName *materials[numMaterials] : u32;

    if (LE) {
        MODMeshXD3 *meshes[numMeshes] : u32;
    } else {
        MODMeshXD3PSN *meshes[numMeshes] : u32;
    }

    u32 vertexBuffer;
    u32 indices;
    u32 fileSize;
    MODBounds bounds;
    MODMetaDataV2 meta;

    MODEnvelope envelopes[meta.numEnvelopes] @ addressof(meshes) + sizeof(meshes);
};

struct SkinXEx {
    u32 usedNodes;
    u8 nodes[24];
};

struct MODBonesXEx {
    MODBoneV1_5 bones[parent.numBones];
    Matrix44 refPoses[parent.numBones];
    Matrix44 ibms[parent.numBones];
    u8 remaps[0x100];
    SkinXEx skins[parent.numSkins];
};

struct MODModelXEx {
    MODMeshXD3 meshes[parent.numMeshes];
    u32 numEnvelopes;
    MODEnvelope envelopes[numEnvelopes];
};

struct MODHeaderXE6 : MODHeaderCommon {
    u32 vertexBufferSize;
    u32 numTextures;
    u32 numGroups;
    u32 numSkins;
    MODBonesXEx *bones : u32;
    MODGroup *groups[numGroups] : u32;
    MaterialName *materials[numMaterials] : u32;
    MODModelXEx *meshes : u32;
    u32 vertexBuffer;
    u32 indices;
    MODBounds bounds;
    MODMetaDataV1 meta;
};

struct MODHeaderXD6 : MODHeaderCommon {
    u32 vertexBufferSize;
    u32 numTextures;
    u32 numGroups;
    padding[4];
    u64 bones;
    MODGroup *groups[numGroups] : u64;
    MaterialName *materials[numMaterials] : u64;
    MODMeshXD3 *meshes[numMeshes] : u64;
    u64 vertexBuffer;
    u64 indices;
    u64 fileSize;
    MODBounds bounds;
    MODMetaDataV2 meta;

    MODEnvelope envelopes[meta.numEnvelopes] @ addressof(meshes) + sizeof(meshes);
};

struct SkinX06 {
    u32 usedNodes;
    u8 nodes[32];
};

struct MODBonesX06 {
    MODBoneV1_5 bones[parent.numBones];
    Matrix44 refPoses[parent.numBones];
    Matrix44 ibms[parent.numBones];
    u8 remaps[0x100];
    SkinX06 skins[parent.numSkins];
};

struct MODModelX06 {
    MODMeshXD3PSN meshes[parent.numMeshes];
    u32 numEnvelopes;
    MODEnvelope envelopes[numEnvelopes];
};

struct MODHeaderX06 : MODHeaderCommon {
    u32 vertexBufferSize;
    u32 numTextures;
    u32 numGroups;
    u32 numSkins;
    MODBonesX06 *bones : u64;
    MODGroup *groups[numGroups] : u64;
    MaterialName *materials[numMaterials] : u64;
    MODModelX06 *meshes : u64;
    u64 vertexBuffer;
    u64 indices;
    u64 fileSize;
    MODBounds bounds;
    MODMetaDataV1 meta;
};

struct MODHeaderX2CFF : MODHeaderCommon {
    u32 vertexBufferSize;
    u32 numTextures;
    u32 numGroups;
    u32 numSkins;
    MODBonesX2CFF *bones : u32;
    MODGroup *groups[numGroups] : u32;
    u32 *materials[numMaterials] : u32;
    MODModelX2CFF *meshes : u32;
    u32 vertexBuffer;
    u32 indices;
    u32 fileSize;
    padding[12];
    MODBounds bounds;
    MODMetaDataV1 meta;
};

struct RMDBones {
    MODBoneV1_5 bones[parent.numBones];
    Matrix44 refPoses[parent.numBones];
    Matrix44 ibms[parent.numBones];
    u8 remaps[0x100];
};

struct RMDModel {
    MODMeshXD3 meshes[parent.numMeshes];
    u32 numEnvelopes;
    MODEnvelope envelopes[numEnvelopes];
};

struct RMDHeader : MODHeaderCommon {
    u32 vertexBufferSize;
    u32 numGroups;
    u32 numSkins;
    RMDBones *bones : u32;
    MODGroup *groups : u32;
    u32 *materials : u32;
    RMDModel *meshes : u32;
    u32 vertexBuffer;
    u32 indices;
    u32 unkSize;
    u32 *unkOffset : u32;
    padding[8];
    MODBounds bounds;
    MODMetaDataV1 meta;
};

bitfield BitFieldX99 {
    unk0 : 10;
    unk1 : 6;
    boneRemapIndex : 8;
    numEnvelopes : 8;
};


struct MODMeshX99 {
    u16 unk;
    u16 materialIndex;
    u8 visible;
    u8 visibleLOD; // only 3 LODs
    u8 unk02[2];              // 0: opacity flags?
    u8 buffer0Stride;
    u8 buffer1Stride;
    u8 unk01;
    u8 pad;
    u16 numVertices;
    u16 endIndex;
    u32 vertexStart;
    u32 vertexStreamOffset;
    u32 vertexStream2Offset;
    u32 indexStart;
    u32 numIndices;
    u32 indexValueOffset;
    u8 unk050[2];
    u16 startIndex;
    BitFieldX99 bf;
    u32 firstEnvelope; // assigned at runtime
};

struct MODModelX99 {
    MODMeshX99 meshes[parent.numMeshes];
    u32 numEnvelopes;
    MODEnvelope envelopes[numEnvelopes];
};

struct MODHeaderX99 : MODHeaderCommon {
    u32 vertex0BufferSize;
    u32 vertex1BufferSize;
    u32 numTextures;
    u32 numGroups;
    u32 numSkins;
    u32 *bones : u32;
    MODGroup *groups[numGroups] : u32;
    u32 *materials : u32;
    MODModelX99 *meshes : u32;
    u32 vertex0Buffer;
    u32 vertex1Buffer;
    u32 indices;
    MODBounds bounds;
    MODMetaDataV1 meta;
};

MODHeaderCommon hdrCmn @0 [[hidden]];

u32 curVtx;
curVtx = 0;
u32 curFormat;
u32 curNumVertices;
u32 curVtOffset;

struct VTA8FAB009 {
    s16 vertexQPos[3];
    s16 null;
    s8 normal[4];
    u8 boneIndex[4];
    u8 boneWeight[4];
    u8 tangent[4];
}[[static]];

struct VTAE62600B {
    s16 vertexQPos[3];
    s16 null;
    s8 normal[4];
    u8 tangent[4];
    u8 boneIndex[4];
    u8 boneWeight[4];
    u16 texCoord[2];
}[[static]];

struct VertexWrap {
    curFormat = parent.hdr.meshes.meshes[curVtx].vertexFormat;
    curNumVertices = parent.hdr.meshes.meshes[curVtx].numVertices;
    curVtOffset = parent.hdr.vertexBuffer + parent.hdr.meshes.meshes[curVtx].vertexOffset +
    (parent.hdr.meshes.meshes[curVtx].vertexBaseOffset * parent.hdr.meshes.meshes[curVtx].data1.vtBuffStride);
    curVtx = curVtx + 1;


    if (curFormat == 0xA8FAB009) {
        VTA8FAB009 v[curNumVertices] @ curVtOffset;
    } else if (curFormat == 0xAE62600B) {
        VTAE62600B v[curNumVertices] @ curVtOffset;
    }
};

struct MODWrap {
    if (hdrCmn.version == 0xD3) {
        MODHeaderXD3 hdr;
    } else if (hdrCmn.version == 0xD2 || hdrCmn.version == 0xD4) {
        MODHeaderXD2 hdr;
    } else if (hdrCmn.version == -212) {
        MODHeaderX2CFF hdr;
    } else if (hdrCmn.version == 0xC3 || hdrCmn.version == 0xC5) {
        MODHeaderXC3 hdr;
    } else if (hdrCmn.version == 0x21) {
        RMDHeader hdr;
    } else if (hdrCmn.version == 0xD6) {
        MODHeaderXD6 hdr;
    } else if (hdrCmn.version == 0xE6 || hdrCmn.version == 0xE5 || hdrCmn.version == 0xE7) {
        MODHeaderXE6 hdr;
    } else if (hdrCmn.version == 0x06 || hdrCmn.version == 0x05) {
        MODHeaderX06 hdr;
    } else if (hdrCmn.version == 0x99) {
        MODHeaderX99 hdr;
    }

    /*if (hdrCmn.version < 0x70 || hdrCmn.version >= 0xC3) {
        VertexWrap vertices[hdr.numMeshes] @ hdr.vertexBuffer;
    }*/
};

MODWrap hdr @0;
