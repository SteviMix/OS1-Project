//
// Created by os on 6/11/26.
//

#include "../h/tcb.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/RiscV.hpp"
#include "../h/Scheduler.hpp"

inline void* operator new(size_t, void* ptr) {
    return ptr;
}

TCB* TCB::running = nullptr;


TCB::TCB(void (*body)(void*), void* arg, void* stackSpace)
    : next(nullptr), nextGlobal(nullptr), sp(0), stack(stackSpace), finished(false), blocked(false),requestedRes(0)  ,body(body), arg(arg)
{
    if (body != nullptr) {

        uint64* stackTop = (uint64*)((char*)stackSpace + DEFAULT_STACK_SIZE);
        this->sp = (uint64)(stackTop - 13);
        ((uint64*)this->sp)[12] = (uint64)&TCB::threadWrapper;
    } else {

        this->sp = 0;
    }
}


void TCB::threadWrapper() {
    if (running->body != nullptr) {
        running->body(running->arg);
    }


    running->setFinished(true);

    TCB::dispatch();
}


TCB* TCB::createThread(void (*body)(void*), void* arg, void* stackSpace) {

    void* tcbSpace = MemoryAllocator::mem_alloc(sizeof(TCB));
    if (tcbSpace == nullptr) {
        return nullptr;
    }
    return new (tcbSpace) TCB(body, arg, stackSpace);
}

void TCB::dispatch() {
    TCB* oldTCB = running;

    TCB* newTCB = Scheduler::get();

    if (oldTCB && !oldTCB->isFinished() && !oldTCB->isBlocked()) {
        Scheduler::put(oldTCB);
    }

    if (newTCB != nullptr && oldTCB != newTCB) {
        running = newTCB;
        contextSwitch(&oldTCB->sp, &newTCB->sp);
    }
}

TCB::~TCB() {
    if (stack != nullptr) {
        MemoryAllocator::mem_free(stack);
    }
}

