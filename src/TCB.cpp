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


TCB::TCB(void (*body)(void*), void* arg, void* stackSpace, void* kernelStack)
{
    this->body= body;
    this->arg = arg;
    this->userStack = stackSpace;
    this->kernelStack = kernelStack;
    this->finished = false;
    this->next = nullptr;
    this->nextGlobal = nullptr;


    if (body != nullptr) {

        uint64* kernelStackTop = (uint64*)((char*)kernelStack + DEFAULT_STACK_SIZE);

        this->sp = (uint64)(kernelStackTop-13);
        ((uint64*)this->sp)[12] = (uint64)&threadWrapper;
    } else {
        this->sp = 0;
    }
}


void TCB::threadWrapper() {

    uint64 kernelStackTop = (uint64)running->kernelStack+ DEFAULT_STACK_SIZE;
    __asm__ volatile ("csrw sscratch, %0" : : "r" (kernelStackTop));

    uint64 sstatus = RiscV::r_sstatus();
    sstatus &= ~(1<<8); // SPP = 0 (Korisnički mod)
    sstatus |= (1<<5);  // SPIE = 1 (Uključeni prekidi)

    uint64 arg = (uint64)running->arg;
    uint64 userStackTop = (uint64)running->userStack+DEFAULT_STACK_SIZE;
    uint64 retAddr = (uint64)&thread_exit;
    RiscV::w_sepc((uint64)running->body);

    __asm__ volatile (
        "csrw sstatus, %[sstatus] \n\t"
        "mv a0, %[arg] \n\t"
        "mv ra, %[ra] \n\t"
        "mv sp, %[usp] \n\t"
        "sret \n\t"
        :
        : [sstatus] "r" (sstatus), [arg] "r" (arg), [usp] "r" (userStackTop), [ra] "r" (retAddr)
        );
}


TCB* TCB::createThread(void (*body)(void*), void* arg, void* stackSpace) {

    void* tcbSpace = MemoryAllocator::mem_alloc(sizeof(TCB));

    void* kernelStack = MemoryAllocator::mem_alloc(DEFAULT_STACK_SIZE);
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

