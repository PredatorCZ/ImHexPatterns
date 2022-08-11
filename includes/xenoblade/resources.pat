#include <std/ptr.pat>
#define RA [[pointer_base("std::ptr::relative_to_parent")]]
#define RAA [[pointer_base("Pp")]]

fn Pp(u128) {
	return addressof(parent.parent);
};

struct ResourceStream {
    u32 compressedSize;
    u32 uncompressedSize;
    u32 offset;
};

enum ResourceEntryType : u16 {
    Model,
    Shaders,
    LowTextures,
    HighTextures,
};

struct ResourceStreamEntry {
    u32 offset;
    u32 size;
    u16 streamIndex;
    ResourceEntryType entryType;
    u32 null[2];
};

struct ResourceTexture {
    u32 unk;
    u32 lowSize;
    u32 lowOffset;
    char *nameOffset[] : u32 RAA;
};

struct ResourceTextures {
    u32 numTextures;
    ResourceTexture *textures[numTextures] : u32 RA;
    u32 null;
    char *names[] : u32 RA;
};

struct ExternalResource {
    u32 hash;
    u32 mediumUncompressedSize;
    u32 unk0;
    u32 highUncompressedSize;
    u32 unk1;
};

struct ResHeader {
    u32 tag;
    u32 revision;
    u32 numStreamEntries;
    ResourceStreamEntry *streamEntries[numStreamEntries] : u32 RA;
    u32 numInternalStreams;
    ResourceStream *internalStreams[numInternalStreams] : u32 RA;
    u32 modelStreamEntryIndex;
    u32 shaderStreamEntryIndex;
    u32 lowTexturesStreamEntryIndex;
    u32 lowTexturesStreamIndex;
    u32 middleTexturesStreamIndex;
    u32 highTexturesStreamEntryBeginIndex;
    u32 numHighTexturesStreamEntries;
    u32 numTextureIds;
    s16 *textureIndices[numTextureIds] : u32 RA;
    ResourceTextures *textureTable : u32 RA;
    u32 null0;
    u32 numExternalResources;
    ExternalResource *externalResources[numExternalResources] : u32 RA;
    u32 null[4];
};
