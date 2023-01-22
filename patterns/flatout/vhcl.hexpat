#pragma endian big
#include <std/io.pat>

struct PString {
    u32 len;
    char name[len];
};

struct Matrix {
    float r0[4];
    float r1[4];
    float r2[4];
    float r3[4];
};

struct BBOX {
    float min[3];
    float max[3];
};

struct BoundSphere {
    float center[3];
    float radius;
};

struct BMAP {
    u32 slot;
    u32 type;
    PString path;
};

struct Vert {
    u16 pos[4];
    u16 tex[4];
}[[static]];

struct BatchChunk {
    char type[4];
    u32 null;
    u32 numItems;

    if (type == "mtrl") {
        PString name;
        u32 unk[6];
    } else if (type == "txtr") {
        BMAP bmaps[numItems];
    } else if (type == "vert") {
        Vert verts[numItems];
    } else if (type == "tria") {
        u16 tris[numItems * 3];
    }
}[[format("BatchChunkfmt")]];

fn BatchChunkfmt(ref BatchChunk input) {
    return std::format("{}[{}] {}", input.type, input.numItems, input.null);
};

struct Batch {
    BoundSphere sphere;
    BBOX bbox;
    BatchChunk chunk[5];
};

struct Dummy {
    Matrix tm;
    PString name;
};

struct Anim {
    char type[4];
    u32 null;
    u32 numItems;

    if (type == "kfra") {

    } else if (type == "dmmy") {
        Dummy node[numItems];
    }
};

struct Shape {
    u32 unk;
    u32 dataSize;
    u8 shapeData[dataSize];
};

struct Mesh {
    PString name;

    char type[4];
    u32 null;
    u32 numItems;

    Batch batches[numItems];
};

struct PolyMeshMesh {
    BBOX bbox;
    char type[4];
    u32 null;
    u32 numItems;

    if (type == "mesh") {
        Mesh meshes[numItems];
    }
};

struct PolyMesh {
    char type[4];
    u32 null;
    u32 numItems;

    if (type == "pmsh") {
        PolyMeshMesh pmesh[numItems];
    } else if (type == "shpe") {
        Shape shape[numItems];
    } else if (type == "anim") {
        Anim anims[2];
    }
};

struct Model {
    PString name0;
    PString name1;
    Matrix mtx;
    BBOX bbox;
    PolyMesh meshes[4];
    u32 unk[3];
};

struct Light {
    Matrix tm;
    float unk[11];
};

struct SSCE {
    Matrix tm;
    float unk[2];
    PString name;
    u32 type;
    PString path;
};

struct Chunk {
    char type[4];
    u32 null;
    u32 numItems;

    if (type == "modl") {
        Model model[numItems];
    } else if (type == "dmmy") {
        Dummy node[numItems];
    } else if (type == "ltpd") {
        Light node[numItems];
    } else if (type == "ssce") {
        SSCE node[numItems];
    }
}[[format("Chunkfmt")]];

fn Chunkfmt(ref Chunk input) {
    return std::format("{}[{}] {}", input.type, input.numItems, input.null);
};

struct Header {
    u32 id;
    u32 version; // or type

    Chunk chunk[3] [[inline]];
};

Header hdr @0;
