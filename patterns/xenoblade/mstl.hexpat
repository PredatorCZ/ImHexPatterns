#pragma endian big
#include "xenoblade/mdo.pat"
#include "xenoblade/mdos.pat"

struct Header {
    u32 null[2];
    Model *models : u32;
    u32 materials;
    u32 unkOffset0;
    u32 null00;
    Stream *streams : u32;
    u32 cachedTexturesOffset;
    u32 shadersOffset;
    u32 indicesOffset;
    u32 indicesCount;
    u32 null01[7];
};

Header hdr @0;
