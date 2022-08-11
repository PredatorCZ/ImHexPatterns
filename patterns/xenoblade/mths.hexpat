#pragma MIME xenoblade-x/shader
#pragma endian big

#define NAME u32 name;
//char *name[] : u32 [[pointer_base("pname")]]

fn pname(u32) {
    return this.varsNames;
};

enum SamplerType : u32 {
    Type1D,
    Type2D,
    Type3D,
    TypeCube,
};

struct Sampler {
    NAME;
    SamplerType type;
    u32 location;
};

enum ShaderVarType : u32 {
    Void,
    Bool,
    Int,
    uint,
    Float,
    Double,
    dvec2,
    dvec3,
    dvec4,
    vec2,
    vec3,
    vec4,
    bvec2,
    bvec3,
    bvec4,
    ivec2,
    ivec3,
    ivec4,
    uvec2,
    uvec3,
    uvec4,
    mat2,
    mat2x3,
    mat2x4,
    mat3x2,
    mat3,
    mat3x4,
    mat4x2,
    mat4x3,
    mat4,
    dmat2,
    dmat2x3,
    dmat2x4,
    dmat3x2,
    dmat3,
    dmat3x4,
    dmat4x2,
    dmat4x3,
    dmat4,
};

struct UniformValue {
    NAME;
    ShaderVarType type;
    u32 count;
    u32 offset;
    u32 blockIndex;
};

struct Attribute {
    NAME;
    ShaderVarType type;
    u32 count;
    u32 location;
};

struct UniformBlock {
    NAME;
    u32 offset;
    u32 size;
};

enum ShaderMode : u32 {
   UniformRegister,
   UniformBlock,
   GeometryShader,
   ComputeShader,
};

struct FragmentShader {
    u32 registryOffset;
    u32 registryCount;
    u32 programSize;
    u32 programOffset;
    ShaderMode shaderMode;
    u32 samplersCount;
    u32 samplersOffset;
    u32 uniformVarsCount;
    u32 uniformVarsOffset;
    u32 null01[4];
    u32 uniformBlocksCount;
    u32 uniformBlocksOffset;
};

struct VertexShader : FragmentShader {
    u32 attributesCount;
    u32 attributesOffset;
    u32 null02[6];
};

struct Header {
    u32 id;
    u32 version;
    VertexShader *vertexShader : u32;
    FragmentShader *fragmentShader : u32;
    u32 geometryShader;
    Sampler *samplers : u32;
    UniformValue *uniformVars : u32;
    Attribute *attributes : u32;
    UniformBlock *uniformBlocks : u32;
    u32 registers;
    u32 varsNames;
    u32 programs;
};

Header hdr @0;
