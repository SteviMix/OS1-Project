//
// Created by os on 6/10/26.
//

#ifndef OS_PROJEKAT_TCB_HPP
#define OS_PROJEKAT_TCB_HPP

#include "../lib/hw.h"



extern "C" void contextSwitch(uint64* oldSP, uint64* newSP);


class TCB {
public:
    TCB();
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

private:
    TCB (void (*body)(void*), void* arg, void* stackSpace, void* kernelStack);

    uint64 sp;
    void* userStack;
    void* kernelStack;
    bool finished;
    void (*body) (void*);
    void *arg;

    friend void contextSwitch(uint64* oldSP, uint64* newSP);

    static void threadWrapper();
};

#endif //OS_PROJEKAT_TCB_HPP
