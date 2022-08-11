#pragma MIME xenoblade-x/bdat-collection-encrypted
#pragma endian big
#define BE be
#include <xenoblade/bdat.pat>

u32 numDatas @0;
u32 fileSize @$;
u32 dataOffsets[numDatas] @$;

u32 dataIndex in;

headerBegin = dataOffsets[dataIndex];
encrypted = true;
Header header @headerBegin;
