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
    : next(nullptr), nextGlobal(nullptr), sp(0), userStack(stackSpace), kernelStack(kernelStack), finished(false), body(body), arg(arg)
{
    if (body != nullptr) {

        uint64* kernelStackTop = (uint64*)((char*)kernelStack + DEFAULT_STACK_SIZE);
        this->sp = (uint64)(kernelStackTop - 13);
        ((uint64*)this->sp)[12] = (uint64)&TCB::threadWrapper;
    } else {

        this->sp = 0;
    }
}


void TCB::threadWrapper() {
    RiscV::w_sepc((uint64)running->body);

    uint64 sstatus = RiscV::r_sstatus();
    sstatus &= ~(1<<8);
    sstatus |= (1<<5);
    RiscV::w_sstatus(sstatus);

    uint64 arg = (uint64) running->arg;
    uint64 userSp = (uint64)running->userStack+DEFAULT_STACK_SIZE;
    uint64 kernelsp = (uint64)running->kernelStack+DEFAULT_STACK_SIZE;
    uint64 returnAddress = (uint64)&thread_exit;

    __asm__ volatile(
        "mv a0, %0 \t\n"
        "csrw sscratch, %2 \t\n"
        "mv sp, %1 \t\n"
        "mv ra, %3 \n\t"
        "sret \n\t"
        :
        : "r"(arg), "r"(userSp), "r" (kernelsp), "r" (returnAddress)
        );

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

