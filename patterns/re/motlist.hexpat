#include <std/io.pat>

struct AssetBase {
    u32 version;
    u32 id;
};

struct Motlist : AssetBase {
    padding[8];
    u64 motionsPtr;
    u64 unk0;
    char16 *fileName : u64;
    u64 unk1;
    u32 numMotions;

    u64 motions[numMotions] @ motionsPtr;
};

fn motion_base3(auto) {
    return addressof(parent.parent.parent);
};

fn motion_base2(auto) {
    return addressof(parent.parent);
};

struct MadValues {
    float mul[4];
    float add[4];
};

struct MotionCurve {
    u32 flags;
    u32 numFrames;
    u32 *frames : u32[[pointer_base("motion_base3")]];
    u32 *controlPoints : u32[[pointer_base("motion_base3")]];
    MadValues *minMaxBounds : u32[[pointer_base("motion_base3")]];
};

struct MotionTrack {
    u16 boneIndex;
    u8 usedCurves;
    u8 unk1;
    u32 boneHash;
    u32 curves;

    if (usedCurves & 1) {
        MotionCurve posCurve @ curves + addressof(parent);
    }

    if (usedCurves & 2) {
        MotionCurve rotCurve @ curves + addressof(parent) + (20 * (usedCurves & 1));
    }
};

fn motion_track(MotionTrack track) {
    str retval = std::format("Index: {}, Hash: {}", track.boneIndex, track.boneHash);
    return retval;
};

struct Bone {
    char16 *boneName[] : u64[[pointer_base("motion_base2")]];
    u8 *parentBone : u64[[pointer_base("motion_base2")]];
    u8 *firstChildBone : u64[[pointer_base("motion_base2")]];
    u8 *lastChildBone : u64[[pointer_base("motion_base2")]];
    float position[4];
    float rotation[4];
    u32 boneID;
    u32 boneHash;
    u64 unk;
};

struct Motion : AssetBase {
    padding[8];
    u64 bonesPtr;
    u64 tracksPtr;
    u64 unkOffset[7];
    u64 animationName;
    float intervals[4];
    u16 numBones;
    u16 numTracks;
    u8 numClips;
    u8 numUnk[3];
    u32 framesPerSecond;
    u16 unks00[2];

    Bone bones[numBones] @ bonesPtr + addressof(this) + 16;
    MotionTrack tracks[numTracks] @ tracksPtr + addressof(this) [[format_entries("motion_track")]];
};

Motlist hdr @0;

Motion mt @ hdr.motions[0];
