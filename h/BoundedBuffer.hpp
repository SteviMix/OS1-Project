//
// Created by os on 6/22/26.
//

#ifndef OS1_PROJECT_BOUNDEDBUFFER_HPP
#define OS1_PROJECT_BOUNDEDBUFFER_HPP


#include "MemoryAllocator.hpp"
#include "_sem.hpp"
class BoundedBuffer {
    public:
    BoundedBuffer(int capacity);
    ~BoundedBuffer();

    void put(char c);
    char get();
    static void* operator new(size_t size){

        size_t size_in_blocks = (size + sizeof(FreeMemBlock) + MEM_BLOCK_SIZE - 1)/MEM_BLOCK_SIZE;
        return MemoryAllocator::mem_alloc(size_in_blocks);

    }

    static void operator delete(void* ptr){
        if (ptr == nullptr) return;
        MemoryAllocator::mem_free(ptr);
    }
private:
    char* buffer;
    int capacity;
    int head, tail;

    _sem* spaceAvailable;
    _sem* itemAvailable;
};
#endif //OS1_PROJECT_BOUNDEDBUFFER_HPP
