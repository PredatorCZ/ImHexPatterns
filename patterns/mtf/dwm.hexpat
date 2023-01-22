struct Unk0 {
    float unk[4];
}[[static]];

struct Unk1 {
    float unk[2];
}[[static]];

struct Unk2 {
    float unk[3];
}[[static]];

struct Unk3 {
    u32 unk[2];
}[[static]];

struct Unk4 {
   float unk[12];
   u32 index;
}[[static]];

struct Unk5 {
    u32 id0;
    u32 id1;
    float unk[2];
}[[static]];

struct Unk6 {
    u16 unk[4]; // half float
}[[static]];

struct DeformWeightModel {
    u32 id;
    u32 version;
    u32 numWeights;
    float weights[numWeights];
    u32 unk0[14];

    Unk0 positions[unk0[2]];
    Unk1 unk2[unk0[2]];
    Unk1 unk3[unk0[2]];
    Unk1 unk4[unk0[2]];
    Unk1 unk5[unk0[2]];
    Unk1 unk6[unk0[2]];
    Unk1 unk7[unk0[2]];
    Unk1 unk8[unk0[2]];
    Unk1 unk9[unk0[2]];
    Unk0 normal[unk0[2]];
    Unk0 boneIds[unk0[2]];
    Unk0 boneWeights[unk0[2]];
    Unk3 unk13[unk0[12]];
    u32 unk14;
    Unk6 unk15[unk14];

    /*u32 unk16[8];
    Unk4 unk17[unk16[0]];
    Unk5 unk18[unk16[1]];

    u8 shader0[unk16[2]];
    u8 shader1[unk16[3]];
    u8 shader2[unk16[4]];
    u8 shader3[unk16[5]];
    u8 shader4[unk16[6]];
    u8 shader5[unk16[7]];

    Unk0 unk19[unk0[0]];*/

};

DeformWeightModel dwm @0;
