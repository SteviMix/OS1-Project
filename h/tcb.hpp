//
// Created by os on 6/10/26.
//

#ifndef OS_PROJEKAT_TCB_HPP
#define OS_PROJEKAT_TCB_HPP

#include "../lib/hw.h"
#include "MemoryAllocator.hpp"


extern "C" void contextSwitch(uint64* oldSP, uint64* newSP);


class TCB {
public:

    ~TCB();

    //Constructor for creating threads
    static TCB* createThread(void (*body)(void*), void* arg, void* stackSpace);

    // Method for contextSwitch
    static void dispatch();

    static TCB* running;

    TCB* next;
    TCB* nextGlobal;

    bool isFinished() const {return finished;}

    void setFinished(bool val){ finished = val;}

    bool isBlocked() const {return blocked;}

    void setBlocked(bool val){ blocked = val;}

    int getRequestedRes() const {return requestedRes;}

    void setRequestedRes(int val){ requestedRes = val;}

    static void* operator new(size_t size){

        size_t size_in_blocks = (size + sizeof(FreeMemBlock) + MEM_BLOCK_SIZE - 1)/MEM_BLOCK_SIZE;
        return MemoryAllocator::mem_alloc(size_in_blocks);

    }

    static void operator delete(void* ptr){
        if (ptr == nullptr) return;
        MemoryAllocator::mem_free(ptr);
    }

private:
    TCB (void (*body)(void*), void* arg, void* stack);

    uint64 sp;
    void* stack;
    bool finished;
    bool blocked;
    unsigned requestedRes;
    void (*body) (void*);
    void *arg;

    friend void contextSwitch(uint64* oldSP, uint64* newSP);

    static void threadWrapper();
};

#endif //OS_PROJEKAT_TCB_HPP
