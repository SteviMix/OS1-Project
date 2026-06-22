//
// Created by os on 6/20/26.
//

#ifndef OS1_PROJECT__SEM_HPP
#define OS1_PROJECT__SEM_HPP

#include "MemoryAllocator.hpp"
#include "tcb.hpp"
class _sem {
public:
    _sem(unsigned init): val((int) init), head(nullptr), tail(nullptr), isClosed(false){}

    int wait(unsigned n);
    int signal(unsigned n);
    int close();

    void* operator new (size_t size){

        size_t size_in_blocks = (size + sizeof(FreeMemBlock) + MEM_BLOCK_SIZE -1)/MEM_BLOCK_SIZE;
        return MemoryAllocator::mem_alloc(size_in_blocks);
    }
    void operator delete (void* ptr){
        if (ptr == nullptr) return;
        MemoryAllocator::mem_free(ptr);
    }
private:
    int val;
    TCB* head;
    TCB* tail;
    bool isClosed;
};

#endif //OS1_PROJECT__SEM_HPP
