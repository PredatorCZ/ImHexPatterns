
bitfield Tier0 {
    version : 8;
    unk : 6; // subversion? bits? 0x20
    unk0 : 14; // platform? 0 = pc, 2 = ps3
    textureType : 4; // TextureTypeV2
};

bitfield Tier1 {
  numMips : 6;
  height : 13;
  width : 13;
};

bitfield Tier2 {
  numFaces : 8;
  format : 5;
  unk : 3;
  depth : 16;
};

struct TEXx9D {
    u32 id;
    Tier0 tier0;
    Tier1 tier1;
    Tier2 tier2;
};
