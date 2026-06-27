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
uint64 TCB::timeSliceCounter = 0;
TCB* TCB::sleepingHead = nullptr;

TCB::TCB(void (*body)(void*), void* arg, void* stackSpace)
    : next(nullptr), nextGlobal(nullptr), sp(0), stack(stackSpace), finished(false), blocked(false),requestedRes(0)  ,body(body), arg(arg)
{
    this->timeslice = DEFAULT_TIME_SLICE;
    this->timeToSleep = 0;

    if (body != nullptr) {

        uint64* stackTop = (uint64*)((char*)stackSpace + DEFAULT_STACK_SIZE);
        this->sp = (uint64)(stackTop - 13);
        ((uint64*)this->sp)[12] = (uint64)&TCB::threadWrapper;
    } else {

        this->sp = 0;
    }
}


void TCB::threadWrapper(){
    if(running->body)
        RiscV::mc_sstatus(RiscV::SSTATUS_SPP);
    else
        RiscV::ms_sstatus(RiscV::SSTATUS_SPP);
    RiscV::ms_sstatus(RiscV::SSTATUS_SPIE);
    RiscV::popSppSpie();
    running->body(running->arg);
    thread_exit();
}


TCB* TCB::createThread(void (*body)(void*), void* arg, void* stackSpace) {

    TCB* newThread = new TCB(body, arg, stackSpace);
    return  newThread;
}

void TCB::dispatch() {
    TCB* oldTCB = running;

    TCB* newTCB = Scheduler::get();

    if (oldTCB && !oldTCB->isFinished() && !oldTCB->isBlocked()) {
        Scheduler::put(oldTCB);
    }

    if (newTCB != nullptr && oldTCB != newTCB) {
        running = newTCB;
        timeSliceCounter = 0;
        contextSwitch(&oldTCB->sp, &newTCB->sp);
    }
}

TCB::~TCB() {
    if (stack != nullptr) {
        MemoryAllocator::mem_free(stack);
    }
}

bool TCB::timeSliceTick() {
    timeSliceCounter++;
    if (running->timeslice > 0 && timeSliceCounter >= running->timeslice) {
        return true;
    }
    return false;
}

void TCB::updateSleeping() {
    TCB* curr = sleepingHead;
    TCB* prev = nullptr;

    while (curr != nullptr) {
        curr->timeToSleep--;

        if (curr->timeToSleep <= 0) {
            if (prev == nullptr) sleepingHead = curr->next;
            else prev->next = curr->next;

            TCB* wakeUp = curr;
            curr = curr->next;

            wakeUp->setBlocked(false);
            Scheduler::put(wakeUp);
        }else {
            prev = curr;
            curr = curr->next;
        }
    }
}

void TCB::sleep(uint64 time) {
    if (time == 0) return;

    running->setBlocked(true);

    running->timeToSleep = time;
    running->next = sleepingHead;
    sleepingHead = running;

    TCB::dispatch();
}
