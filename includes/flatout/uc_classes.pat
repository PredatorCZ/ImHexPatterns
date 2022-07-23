#pragma once

#include "flatout/classes.pat"

struct Vertex16 {
  u16 pos[4];
  u8 normal[4];
  u8 tagent[4];
  u8 bitangent[4];
  u32 color;
  u16 uv1[2];
  u16 uv2[2];
}[[static]];

struct Vertex18 {
  u16 pos[4];
  u8 normal[4];
  u8 tagent[4];
  u8 bitangent[4];
  u16 uv1[2];
}[[static]];

struct Vertex19 {
  u16 pos[4];
}[[static]];

struct Vertex1A {
  u16 pos[4];
  u8 normal[4];
  u16 uv1[2];
  u16 uv2[2];
}[[static]];

struct Stream {
  u32 type;
  u32 subType;
  u32 numItems;

  if (type == 1) {
    u32 stride;
    u32 formatFlags;

    if ((subType == 0x16) || (subType == 0x17)) {
      Vertex16 vertex[numItems];
    } else if (subType == 0x18) {
      Vertex18 vertex[numItems];
    } else if (subType == 0x19) {
      Vertex19 vertex[numItems];
    } else if (subType == 0x1A) {
      Vertex1A vertex[numItems];
    }
  } else if (type == 2) {
    u16 indices[numItems];
  }
} [[single_color]];

struct PrimitiveStream {
  u32 streamIndex;
  u32 streamOffset;
}[[static]];

struct Primitive {
  u32 flags;
  u32 materialIndex;
  u32 numVertices;
  u32 formatFlags;
  u32 numPolys;
  u32 indexType; // 4 tris, 5 strip
  u32 numIndices;
  float scales[4];
  u32 numStreams;
  PrimitiveStream streams[numStreams];
};
