#pragma MIME xenoblade-x/bdat-collection-encrypted
#pragma endian big
#include <xenoblade/bdat.pat>

u32 numDatas @0;
u32 fileSize @$;
u32 dataOffsets[numDatas] @$;

Header header @dataOffsets[0];
