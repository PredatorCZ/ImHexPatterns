#pragma MIME xenoblade-x/bdat-collection
#define BE be
#include <xenoblade/bdat.pat>

u32 numDatas @0;
u32 fileSize @$;
u32 dataOffsets[numDatas] @$;

u32 dataIndex in;

headerBegin = dataOffsets[dataIndex] + 8 + 4 * dataIndex;
Header header @headerBegin;
