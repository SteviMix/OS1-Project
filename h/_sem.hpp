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

    void* operator new (size_t size){ return MemoryAllocator::mem_alloc(size); }
    void operator delete (void* ptr){ MemoryAllocator::mem_free(ptr); }
private:
    int val;
    TCB* head;
    TCB* tail;
    bool isClosed;
};

#endif //OS1_PROJECT__SEM_HPP
