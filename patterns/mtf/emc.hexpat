struct ItemsItem {
    u32 count;
    u8 *data : u32;
    u64 null;
};

struct Item {
    u32 count;
    ItemsItem *data[count] : u32;
    u64 null;
};

struct Header {
    u32 id1;
    u32 id2;
    u64 numItems;
    Item items[numItems];
};


Header hdr @0;
