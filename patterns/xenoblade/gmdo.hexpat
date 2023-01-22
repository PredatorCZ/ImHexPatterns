#pragma endian big
#include "xenoblade/mdo.pat"
#include "xenoblade/texres.pat"
#include "xenoblade/mdos.pat"

struct Material {
    char *name[] : u32 [[pointer_base("Pp")]];
    u32 unktype1;
    u32 null;
    float ufloat1;
    u16 unk[10];
};

struct MaterialsHeader {
    Material *material : u32 [[pointer_base("p")]];
	u32 null[5];
};

struct Unk01 {
    u32 unk[6];
};

struct Unk02 {
    u32 unk[8];
};

struct Unk03 {
    u32 unk[6];
};

struct Unk00 {
    u32 count0;
    u32 offset0;
    u32 count1;
    u32 offset1;
    u32 count2;
    u32 offset2;
    u32 count3;
    u32 offset3;

    Unk01 unk01[count0] @ addressof(this) + offset0;
    Unk02 unk02[count2] @ addressof(this) + offset2;
    Unk03 unk03[count3] @ addressof(this) + offset3;

};

struct Header {
	Model *models : u32;
	MaterialsHeader *materials : u32;
	Unk00 *unk : u32;
    Stream *streams : u32;
	CASMTGroup *cachedTextures : u32;
};

Header hdr @0;
