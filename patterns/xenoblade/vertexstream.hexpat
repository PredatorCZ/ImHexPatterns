
fn Pp(u128) { return addressof(parent.parent); };

fn p(u128) { return addressof(parent); };

struct VertexDescriptor {
    u16 type;
    u16 size;
};

struct VertexBuffer {
    u32 data;
    u32 dataSize;
    u32 dataStride;
    u32 descriptors;
    u32 numDescriptors;
    u32 unk[3];

    VertexDescriptor vertexDescriptors[numDescriptors] @ descriptors;
};

struct IndexBuffer {
    u32 indices;
    u32 numIndices;
    u32 unk[3];
};

struct MorphBuffer {
    u32 vertexBufferOffset;
    u32 vertexBufferSize;
    u32 stride;
    u16 unk;
    u16 type;
};

struct MorphDescriptor {
    u32 vertexBufferIndex;
    u32 bufferIndexBegin;
    u32 numBuffers;
    u16 *targetIds[numBuffers] : u32;
    u32 unk01;
};

struct MorphsHeader {
    u32 numDescs;
    MorphDescriptor *descs[numDescs] : u32;
    u32 numBuffers;
    MorphBuffer *buffers[numBuffers] : u32;
};

struct WeightPalette {
    u32 bufferVertexBegin;
    u32 vertexIndexSubstract;
    u32 count;
    u32 unk00[4];
    u8 indexWithinMergeTable;
    u8 mergeTableIndex;
    u16 unk02;
    u32 unk03[2];
};

struct MergeTable {
    u16 data[9];
};

struct BufferManager {
    u32 numWeightPalettes;
    WeightPalette *weightPalettes[numWeightPalettes] : u32;
    u16 weightBufferID;
    u16 numLODs;
    MergeTable *mergeTables[numLODs] : u32;
};

struct Stream {
    u32 vertexBuffersPtr;
    u32 numVertexBuffers;
    u32 indexBuffersPtr;
    u32 numIndexBuffers;
    u16 unk00[2];
    u32 null00[2];
    u32 unk01;
    u32 unkOffset00;
    u32 unkCount00;
    u32 morphsPtr;
    u32 bufferSize;
    u32 bufferOffset;
    u32 voxelizedModelOffset;
    BufferManager *bufferManager : u32;

    VertexBuffer vertexBuffers[numVertexBuffers] @ vertexBuffersPtr;
    IndexBuffer indexBuffers[numIndexBuffers] @ indexBuffersPtr;

    if (morphsPtr) {
        MorphsHeader morphs @ morphsPtr;
    }
};

Stream stream @0;
