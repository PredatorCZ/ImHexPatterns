struct Track {
    u16 numFrames;
    u16 frames[numFrames];
};

struct TrackPtr {
    Track *track : u32[[inline]];
};

enum AnimType : u8 {
    HermiteFloat = 0,
    HermiteValueSInt16SlopesFloat = 4, // 0100
    HermiteSInt16 = 5, // 0101
    LinearSInt16 = 6, // 0110
    HermiteSInt8 = 10, // 1010
};

bitfield TrackInfo {
    translation : 1;
    rotation0 : 1;
    rotation1 : 1;
    unl12 : 1;
    unk0 : 1;
    rotation2 : 1;
    unk2 : 1;
    unk3 : 1;
    unk4 : 1;
    unk5 : 1;
    unk6 : 1;
    unk7 : 1;
    animType : 4;
};

struct FCV {
    u16 maxFrames;
    u8 numBones;
    TrackInfo types[numBones];
    u8 boneIds[numBones];
    padding[4 - ($ % 4)];
    be u32 fileSize;
    TrackPtr tracks[numBones];
};

FCV hdr @0;
