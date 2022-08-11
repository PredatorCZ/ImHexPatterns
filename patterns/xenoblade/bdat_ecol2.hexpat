#pragma MIME xenoblade-2/bdat-collection-encrypted
#define BE le
#include <xenoblade/bdat.pat>

u32 numDatas @0;
u32 fileSize @$;
u32 dataOffsets[numDatas] @$;

u32 dataIndex in;

headerBegin = dataOffsets[dataIndex];
encrypted = true;
Header header @headerBegin;
