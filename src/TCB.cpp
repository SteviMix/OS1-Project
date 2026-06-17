//
// Created by os on 6/11/26.
//

#include "../h/tcb.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/RiscV.hpp"
#include "../h/Scheduler.hpp"
#include "../h/syscall_c.hpp"
inline void* operator new(size_t, void* ptr) {
    return ptr;
}

TCB* TCB::running = nullptr;

TCB::TCB() {
    body = nullptr;
    userStack = nullptr;
    kernelStack = nullptr;
    finished = false;
    next = nullptr;
    nextGlobal = nullptr;
}
TCB::TCB(void (*body)(void*), void* arg, void* stackSpace, void* kernelStack)
{
    this->body= body;
    this->arg = arg;
    this->userStack = stackSpace;
    this->kernelStack = kernelStack;

    if (kernelStack != nullptr) {
        this->sysStackTop = (uint64*)((char*)kernelStack+DEFAULT_STACK_SIZE);
    }else {
        this->sysStackTop = nullptr;
    }
    if (body != nullptr) {

        this->context.ra = (uint64) &threadWrapper;
        this->context.sp = (uint64)userStack+DEFAULT_STACK_SIZE;
        this->context.sscratch = 0;
    } else {
        this->context.ra = 0;
        this->context.sp = 0;
        this->context.sscratch = 0;
    }
}


void TCB::threadWrapper() {

    __asm__ volatile ("csrw sscratch, %0" : : "r" (running->sysStackTop));

    uint64 sstatus = RiscV::r_sstatus();
    sstatus &= ~(1<<8); // SPP = 0 (Korisnički mod)
    sstatus |= (1<<5);  // SPIE = 1 (Uključeni prekidi)
    RiscV::w_sstatus(sstatus);

    running->body(running->arg);
    thread_exit();
}


TCB* TCB::createThread(void (*body)(void*), void* arg, void* stackSpace) {

    void* tcbSpace = MemoryAllocator::mem_alloc(sizeof(TCB));

    void* kernelStack = nullptr;
    if (body != nullptr) {
        kernelStack = MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE);
    }
    if (tcbSpace == nullptr) {
        if (kernelStack) MemoryAllocator::mem_free(kernelStack);
        return nullptr;
    }
    return new (tcbSpace) TCB(body, arg, stackSpace, kernelStack);
}

void TCB::dispatch() {
    TCB* oldTCB = running;
    TCB* newTCB = Scheduler::get();

    if (oldTCB && !oldTCB->isFinished()) {
        Scheduler::put(oldTCB);
    }

    if (newTCB != nullptr && oldTCB != newTCB) {
        running = newTCB;
        contextSwitch(&oldTCB->sp, &newTCB->sp);

        RiscV::w_sscratch((uint64)running->kernelStack+DEFAULT_STACK_SIZE);
    }
}

TCB::~TCB() {
    if (userStack != nullptr) {
        MemoryAllocator::mem_free(userStack);
    }
    if (kernelStack != nullptr) {
        MemoryAllocator::mem_free(kernelStack);
    }
}

