#pragma MIME catboost/cbm
#include <std/ptr.pat>
#define RA [[single_color, pointer_base("std::ptr::relative_to_pointer")]]
#define RP u32 [[single_color, pointer_base("std::ptr::relative_to_pointer")]]
//#pragma array_limit 10000000


struct Header {
    u32 id;
    u32 modelSize;
};

struct FlatBufferVTable {
    u16 size;
    u16 dataSize;
    u16 vtable[(size - 4) / 2];
};


struct FlatBufferTable {
    s32 vtableOffset;
    FlatBufferVTable vtable @addressof(vtableOffset) - vtableOffset;
};

struct FlatBufferString {
    u32 numItems;
    char string[numItems];
};

struct FlatBufferStringPtr {
    FlatBufferString *partId : RP;
};

struct TModelPartIds {
    u32 count;
    FlatBufferStringPtr partdIds[count];
};

struct TInfoTable : FlatBufferTable {
    FlatBufferString *key : RP;
    FlatBufferString *value : RP;
};

struct TInfoTablePtr {
    TInfoTable *infoTable : RP;
};

struct TInfoMap {
    u32 count;
    TInfoTablePtr infoTable[count];
};

struct FlatBufferIntArray {
    u32 count;
    s32 items[count];
};

struct FlatBufferUIntArray {
    u32 count;
    u32 items[count];
};

struct FlatBufferDoubleArray {
    u32 count;
    double items[count];
};

struct FlatBufferFloatArray {
    u32 count;
    float items[count];
};

#define CHECK_TABLE_0  if (vtable.size > 4 ) if (vtable.vtable[0] > 0)
#define CHECK_TABLE_1  if (vtable.size > 6 ) if (vtable.vtable[1] > 0)
#define CHECK_TABLE_2  if (vtable.size > 8 ) if (vtable.vtable[2] > 0)
#define CHECK_TABLE_3  if (vtable.size > 10) if (vtable.vtable[3] > 0)
#define CHECK_TABLE_4  if (vtable.size > 12) if (vtable.vtable[4] > 0)
#define CHECK_TABLE_5  if (vtable.size > 14) if (vtable.vtable[5] > 0)
#define CHECK_TABLE_6  if (vtable.size > 16) if (vtable.vtable[6] > 0)
#define CHECK_TABLE_7  if (vtable.size > 18) if (vtable.vtable[7] > 0)
#define CHECK_TABLE_8  if (vtable.size > 20) if (vtable.vtable[8] > 0)
#define CHECK_TABLE_9  if (vtable.size > 22) if (vtable.vtable[9] > 0)
#define CHECK_TABLE_10 if (vtable.size > 24) if (vtable.vtable[10] > 0)
#define CHECK_TABLE_11 if (vtable.size > 26) if (vtable.vtable[11] > 0)
#define CHECK_TABLE_12 if (vtable.size > 28) if (vtable.vtable[12] > 0)
#define CHECK_TABLE_13 if (vtable.size > 30) if (vtable.vtable[13] > 0)
#define CHECK_TABLE_14 if (vtable.size > 32) if (vtable.vtable[14] > 0)
#define CHECK_TABLE_15 if (vtable.size > 34) if (vtable.vtable[15] > 0)
#define CHECK_TABLE_16 if (vtable.size > 36) if (vtable.vtable[16] > 0)
#define CHECK_TABLE_17 if (vtable.size > 38) if (vtable.vtable[17] > 0)
#define CHECK_TABLE_18 if (vtable.size > 40) if (vtable.vtable[18] > 0)
#define CHECK_TABLE_19 if (vtable.size > 42) if (vtable.vtable[19] > 0)

struct TCatFeature : FlatBufferTable {
    CHECK_TABLE_0
        s32 index;
    CHECK_TABLE_1
        s32 flatIndex;
    CHECK_TABLE_2
        FlatBufferString featureId;
    if (vtable.size > 10)
        bool usedInModel;
};

struct ICatFeaturePtr {
    TCatFeature *item : RP;
};

struct TCatFeatures  {
    u32 count;
    ICatFeaturePtr items[count];
};

enum ENanValueTreatment : u8 {
    AsIs,
    AsFalse,
    AsTrue
};

struct TFloatFeature : FlatBufferTable {
    CHECK_TABLE_0 {
        bool hasNans;
        padding[3];
    }
    CHECK_TABLE_1
        s32 index;
    CHECK_TABLE_2
        s32 flatIndex;
    CHECK_TABLE_3
        FlatBufferFloatArray *borders : RP;
    CHECK_TABLE_4
        FlatBufferString *featureId : RP;
    if (vtable.size > 14)
        ENanValueTreatment nanValueTreatment;
};

struct TFloatFeaturePtr {
    TFloatFeature *item : RP;
};

struct TFloatFeatures {
    u32 count;
    TFloatFeaturePtr items[count];
};

// test me
struct FlatBufferStringArray {
    u32 count;
    FlatBufferString items[count];
};

struct TOneHotFeature : FlatBufferTable {
    CHECK_TABLE_0
        s32 index;
    CHECK_TABLE_1
        FlatBufferIntArray *values : RP;
    if (vtable.size > 8)
        FlatBufferStringArray *stringValues : RP;
};

struct TOneHotFeaturePtr {
    TOneHotFeature *item : RP;
};

struct TOneHotFeatures {
    u32 count;
    TOneHotFeaturePtr items[count];
};

// test me
struct TNonSymmetricTreeStepNode {
    u16 leftSubtreeDiff;
    u16 rightSubtreeDiff;
};

struct TNonSymmetricTreeStepNodePtr {
    TNonSymmetricTreeStepNode *item : RP;
};

struct TNonSymmetricTreeStepNodes {
    u32 count;
    TNonSymmetricTreeStepNodePtr items[count];
};


struct TModelTrees : FlatBufferTable {
    CHECK_TABLE_0
        s32 approxDimension;
    CHECK_TABLE_1
        FlatBufferIntArray *timeSplits : RP;
    CHECK_TABLE_2
        FlatBufferIntArray *treeSizes : RP;
    CHECK_TABLE_3
        FlatBufferIntArray *treeStartOffsets : RP;
    CHECK_TABLE_4
        TCatFeatures *catFeatures : RP;
    CHECK_TABLE_5
        TFloatFeatures *floatFeatures : RP;
    CHECK_TABLE_6
        TOneHotFeatures *oneHotFeatures : RP;
    CHECK_TABLE_7
        padding[4]; // TCtrFeature ctrFeatures;
    CHECK_TABLE_8
        FlatBufferDoubleArray *leafValues : RP;
    CHECK_TABLE_9
        FlatBufferDoubleArray *leafWeights : RP;
    CHECK_TABLE_10
        TNonSymmetricTreeStepNodes *nonSymmetricStepNodes : RP;
    CHECK_TABLE_11
        FlatBufferUIntArray *nonSymmetricNodeIdToLeafId : RP;
    CHECK_TABLE_12
        padding[4]; // TextFeatures:[TTextFeature];
    CHECK_TABLE_13
        padding[4]; // EstimatedFeatures:[TEstimatedFeature];
    CHECK_TABLE_14
        double scale;
    CHECK_TABLE_15
        double bias;
    CHECK_TABLE_16
        FlatBufferDoubleArray *multiBias : RP;
    CHECK_TABLE_17
        padding[4]; // RepackedBins:[TRepackedBin];
    CHECK_TABLE_18
        padding[4]; // EmbeddingFeatures:[TEmbeddingFeature];
};

struct TModelCore : FlatBufferTable {
    CHECK_TABLE_0
        FlatBufferString *versionString : RP;
    CHECK_TABLE_1
        TModelTrees *modelTrees : RP;
    CHECK_TABLE_2
        TInfoMap *infoMap : RP;
    CHECK_TABLE_3
        TModelPartIds *modelPartIds : RP;
};


Header header @0;
TModelCore *pointer : u32 @$ RA;
