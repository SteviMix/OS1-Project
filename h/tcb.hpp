//
// Created by os on 6/10/26.
//

#ifndef OS_PROJEKAT_TCB_HPP
#define OS_PROJEKAT_TCB_HPP

#include "../lib/hw.h"

class TCB {
public:

    ~TCB();

    //Constructor for creating threads
    static TCB* createThread(void (*body)(void*), void* arg);

    // Method for contextSwitch
    static void dispatch();

    static TCB* running;


    TCB* next;
    TCB* nextGlobal;
    struct Context {
        uint64 ra;
        uint64 sp;
    };

    bool isFinished() const {return finished;}

    void setFinished(bool val){ finished = val;}

private:
    TCB (void (*body)(void*), void* arg, void* stack);

    Context context;
    void* stack;
    bool finished;
    void (*body) (void*);
    void *arg;

    static void contextSwitch(Context* oldContext, Context* newContext);

    static void threadWrapper();
};OS_PROJEKAT_TCB_HPP
