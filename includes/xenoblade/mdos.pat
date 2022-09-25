#pragma once

enum VertexDescriptorType : u16 {
    POSITION,
    WEIGHT32,
    BONEID,
    WEIGHTID,
    VERTEXCOLOR2,
    UV1,
    UV2,
    UV3,
    UNK = 14,
    NORMAL32,
    TANGENT16, // NoFunc
    VERTEXCOLOR,
    NORMAL = 28,
    TANGENT, // NoFunc
    NORMAL2 = 32,
    REFLECTION, // NoFunc
    WEIGHT16 = 41,
    BONEID2,
};

struct Descriptor {
    VertexDescriptorType vtType;
    u16 vtSize;
};

struct VertexBuffer {
    u32 vertices;
    u32 numVertices;
    u32 stride;
    u32 descriptorsOffset;
    u32 numDescriptors;
    u32 null;

    Descriptor descriptors[numDescriptors] @ addressof(parent) + descriptorsOffset;
};

struct IndexBuffer {
    u32 indices;
    u32 numIndices;
    u32 null;
};

struct Stream {
    u32 vertexBufferOffset;
    u32 numVertexBuffers;
    u32 indexBufferOffset;
    u32 numIndexBuffers;
    s16 mergeData[16];

    VertexBuffer vertexBuffers[numVertexBuffers] @ addressof(this) + vertexBufferOffset;
    IndexBuffer indexBuffers[numIndexBuffers] @ addressof(this) + indexBufferOffset;
};
