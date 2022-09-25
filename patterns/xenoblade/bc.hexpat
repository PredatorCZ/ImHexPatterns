#include <std/io.pat>
#pragma pattern_limit 1000000

struct Block {
    u32 unk;
    u32 id;
};

struct Array {
    u64 items;
    u32 numItems;
    padding[4];
}[[hidden]];

struct CubicCurve {
    float items[4];
};

struct CubicFrame {
    float frame;
};

struct CubicVector3Frame : CubicFrame {
    CubicCurve elements[3];
}[[static]];

struct CubicQuatFrame : CubicFrame {
    CubicCurve elements[4];
}[[static]];

struct AnimationTrack {
    Array positionArray;
    Array rotationArray;
    Array scaleArray;

    CubicVector3Frame position[positionArray.numItems] @ positionArray.items;
    CubicQuatFrame rotation[rotationArray.numItems] @ rotationArray.items;
    CubicVector3Frame scaleArray[scaleArray.numItems] @ scaleArray.items;
};

struct MorphTracks {
    u64 null00;
    char *name[] : u64;
    u32 null01;
    padding[4];
    Array trackArray;

    float track[trackArray.numItems] @ trackArray.items;
};

struct MorphTacks{
    MorphTracks *null01 : u64;
    Array idsArray;

    s16 ids[idsArray.numItems] @ idsArray.items;
};

struct AnimationData {
    Array null00;
    u64 *null01 : u64;
    u64 *null02 : u64;
    Array bonesArray;
    Array controlTracksArray;
    s16 boneIds[bonesArray.numItems] @ bonesArray.items;
    MorphTacks controlTracks[controlTracksArray.numItems] @ controlTracksArray.items;
};

struct EventTracks {
    float triggerFrame;
    padding[4];
    char *groupName[] : u64;
    char *eventName[] : u64;
};

struct ANIMHeader : Block {
    AnimationData *animData : u64;
    Array null00;
    u64 *null01 : u64;
    char *animationName[] : u64;
    s16 unk01[2];
    float frameRate;
    float frameTime;
    u32 frameCount;
    Array eventsArray;
    u64 *null02 : u64;
    Array transformTracksArray;

    AnimationTrack tracks[transformTracksArray.numItems] @ transformTracksArray.items;
    EventTracks events[eventsArray.numItems] @ eventsArray.items;
};

namespace V1 {

struct Folder {
    char *name[] : u64;
};

struct VParam {
     u32 unk;
     padding[4];
     char *name[] : u64;
};

struct Unk {
    u32 unk;
    u32 unk;
};

struct Animation {
    char *animFile[] : u64;
    Array ids;

    Unk unk[ids.numItems] @ ids.items;
};

struct Group {
    char *type[] : u64;
    char *part[] : u64;
};

struct SValue {
    char *name[] : u64;
    float unk01[8]; // transitions, delays, offsets, etc?
};

struct FadeIn {
    char *name[] : u64;
};

struct Condition02 {
    u32 unk00;
    padding[4];
    SValue val;
};

struct Condition01 {
    char *name[] : u64;
    u32 type;
    padding[4];
    FadeIn val;
};

struct ConditionBlend {
    char *name0[] : u64;
    u32 unk00;
    padding[4];
    char *name1[] : u64;
    float unk01[8];
};

struct Condition {
    char *name[] : u64;
    u32 type;
    padding[4];

    if (type == 2) {
        u32 unk00;
        padding[4];
        Array arr0;
        Condition02 unk01[arr0.numItems] @ arr0.items;
    } else if (type == 0) {
        SValue val;
    } else if (type == 1) {
        Array arr0;
        ConditionBlend blends[arr0.numItems] @ arr0.items;
    }
};

struct Transition {
    Condition *cond : u64;
};

struct FallBack {
    char *name[] : u64;
    u32 unk[8];
    //std::print("{}", addressof(this));
};

struct Event {
    float triggerFrame;
    padding[4];
    Condition01 cond;
};

struct StateAnim {
    char *animFilename[] : u64;
    float unkf[6];
};

struct SequnceAnim {
    float frame;
    padding[4];
    StateAnim anim;
};

struct Sequence {
    u32 unk0;
    u32 unk1;

    if (unk1 == 0) {
        Array animsArray;
    } else if (unk1 == 1) {
        Array arr;
        Array animsArray;
        StateAnim anims0[arr.numItems] @ arr.items;
    }

    SequnceAnim anims[animsArray.numItems] @ animsArray.items;
};

enum StateType : u32 {
    Animation,
    ExitAnim,
    Sequence,
};

struct State {
    StateType type;
    padding[4];
    char *name[] : u64;
    u32 unk0[3];
    padding[4];
    Array outcomingTransitionsArray;
    FallBack *fallback : u64;
    Array inEventsArray;
    Array poseParamsArray;
    Array eventsArray;

    if (type == StateType::Animation || type == StateType::ExitAnim) {
        StateAnim anim;
    } else if (type == StateType::Sequence) {
        Sequence *seq : u64;
    }

    Transition outTransitions[outcomingTransitionsArray.numItems] @ outcomingTransitionsArray.items;
    Condition01 inEvents[inEventsArray.numItems] @ inEventsArray.items;
    Condition01 poseParams[poseParamsArray.numItems] @ poseParamsArray.items;
    Event event[eventsArray.numItems] @ eventsArray.items;
};

struct FSMPtr {
    State *state : u64;
};

u32 fsmOffset in;


struct Assembly {
    Array foldersArray;
    Array fsmArray;
    Array vParamsArray;
    Array animationsArray;
    u64 null00;
    Array arr4;

    Folder folders[foldersArray.numItems] @ foldersArray.items;
    VParam vParams[vParamsArray.numItems] @ vParamsArray.items;
    Animation animations[animationsArray.numItems] @ animationsArray.items;
    Group group[arr4.numItems] @ arr4.items;
    FSMPtr fsm[fsmArray.numItems - fsmOffset] @ fsmArray.items + fsmOffset * 8;
};
}

namespace V2 {
struct Condition {
    char *name[] : u64;
    char *targetState[] : u64;
    u32 hash;
    float unk[4];
    padding[4];
    float unk0[2];
    u32 unk1;
    s16 unk2[8];
    padding[4];
    float unk3;
    u32 unk4;
    u32 unk5;
};

struct Transition {
    Condition *cond : u64;
};

struct StateAnim {
    char *animFilename[] : u64;
    float unkf[8];
};

struct BlendAnim {
    u32 unk1[2];
    StateAnim anim;
};

struct BlendAnim2 {
    u32 unk0[4];
    Array arr0;
    Array arr1;

    BlendAnim blends[arr1.numItems] @ arr1.items;
};

struct BlendAnim2Ptr {
    BlendAnim2 *anim : u64;
};

struct ExitAnims {
    u32 unk0[4];
    Array arr0;
    Array arr1;

    BlendAnim2Ptr blends2[arr0.numItems] @ arr0.items;
    BlendAnim blends[arr1.numItems] @ arr1.items;
};

struct StateExitAnimPtr {
    ExitAnims *blend : u64;
};

struct EventData {
    u32 unk[22];
};

struct Event {
    float triggerFrame;
    float unkFrame;
    EventData data;
};

struct State {
    char *name[] : u64;
    u32 hash;
    V1::StateType type;
    u32 unk0[4];
    Array transitionsArray;
    Array arr1;
    Array arr2;
    Array arr3;
    Array evaAnimsArray;
    Array animsArray;

    /*StateAnim evaAnims[evaAnimsArray.numItems] @ evaAnimsArray.items;
    StateAnim anims[animsArray.numItems] @ animsArray.items;*/

    Transition transitions[transitionsArray.numItems] @ transitionsArray.items;

    EventData unk1[arr1.numItems] @ arr1.items;
    EventData unk2[arr2.numItems] @ arr2.items;
    Event unk3[arr3.numItems] @ arr3.items;

    if (type == V1::StateType::Animation) {
        StateAnim anim;
    } else if (type == V1::StateType::ExitAnim) {
        Array blendsArray;
        StateExitAnimPtr blends[blendsArray.numItems] @ blendsArray.items;
    }
};

struct FSMPtr {
    State *state : u64;
};

struct FSMGroup {
    Array fsmArray;
    Array transitionsArray;
    char *name1[] : u64;
    char *name2[] : u64;
    char *name3[] : u64;

    FSMPtr fsm[fsmArray.numItems] @ fsmArray.items;
    Transition transitions[transitionsArray.numItems] @ transitionsArray.items;
};

struct Assembly {
    Array foldersArray;
    Array fsmGroupsArray;
    u64 null00;
    Array arr0;

    V1::Folder folders[foldersArray.numItems] @ foldersArray.items;
    FSMGroup groups[fsmGroupsArray.numItems] @ fsmGroupsArray.items;
};

}

struct AssemblyCheck {
    u32 unk;
    s32 check;

    if (check == -1) {
        V1::Assembly v1;
    } else {
        V2::Assembly v2 @ addressof(this);
    }
};


struct ASMBHeader : Block {
    AssemblyCheck *ass : u64;
};

struct BCHeader {
    u32 id;
    u16 unk0;
    u16 numBlocks;
    u32 fileSize;
    u32 numPointers;
    Block *data : u64;
    u64 *fixups : u64;

    if (data.unk == 4) {
        ANIMHeader anim @ addressof(data);
    } else if (data.unk == 7) {
        ASMBHeader assembly @ addressof(data);
    }
};


BCHeader main @ 0;
