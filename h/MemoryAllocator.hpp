//
// Created by os on 6/1/26.
//

#ifndef OS_PROJEKAT_MEMORYALLOCATOR_HPP
#define OS_PROJEKAT_MEMORYALLOCATOR_HPP

#include "../lib/hw.h"

struct FreeMemBlock{
    size_t size;
    FreeMemBlock* next;
};


class MemoryAllocator{
public:
    MemoryAllocator() = delete;

    static void init();
    static void* mem_alloc(size_t size);
    static int mem_free(void* ptr);

private:
    static FreeMemBlock* free_mem_head;

};

#endif //OS_PROJEKAT_MEMORYALLOCATOR_HPP
