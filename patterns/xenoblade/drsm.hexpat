#pragma MIME xenoblade/drsm
#pragma endian little
#include "xenoblade/resources.pat"

struct Header {
    u32 id;
    u32 version;
    u32 headerSize;
    u32 headerOffset;
};

Header hdr @0;
ResHeader txHdr @$;
