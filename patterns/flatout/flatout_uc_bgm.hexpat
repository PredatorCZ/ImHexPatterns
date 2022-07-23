#include <flatout/uc_classes.pat>
#pragma array_limit 100000
#pragma pattern_limit 100000000
#pragma endian little

u32 modelType @ 0x0;
u32 numMaterials @$;
Material materials[numMaterials] @$;
u32 numStreams @$;
Stream streams[numStreams] @$;
u32 numPrimitives @$;
Primitive primitives[numPrimitives] @$;
u32 numBMODs @$;
BMOD bmods[numBMODs] @$;
u32 numMeshes @$;
MESH meshes[numMeshes] @$;
u32 numOBJCs @$;
OBJC objects[numOBJCs] @$;
