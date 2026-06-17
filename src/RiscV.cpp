//
// Created by os on 6/9/26.
//
#include "../h/RiscV.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/Scheduler.hpp"
#include "../lib/console.h"
#include "../h/tcb.hpp"
#include "../h/syscall_c.hpp"
void RiscV::handleTrap(uint64* sp) {

    uint64 scause = r_scause();
    uint64 sepc = r_sepc();

    uint64 isInterrupt = scause & 0x8000000000000000UL;
    uint64 causecode = scause & 0x7FFFFFFFFFFFFFFFUL;


    if (isInterrupt) {
        w_sepc(sepc+4);

    }else {
        if (causecode == 8 || causecode == 9) {
            uint64 operationCode = sp[10];

            switch (operationCode) {
                case 0x01:{
                    size_t size = sp[11];
                    void *ptr = MemoryAllocator::mem_alloc(size);
                    sp[10] = (uint64) ptr;
                    break;
                }
                case 0x02: {
                    void* ptr = (void*)sp[11];

                    int ret = MemoryAllocator::mem_free(ptr);

                    sp[10] = (uint64) ret;
                    break;

                }
                case 0x11:
                {
                    thread_t* handle = (thread_t*)sp[11];
                    void (*body)(void*) = (void (*)(void*))sp[12];
                    void* arg = (void*)sp[13];
                    void* stackSpace = (void*)sp[14];

                    TCB* newThread = TCB::createThread(body, arg, stackSpace);


                    if (handle != nullptr) {
                        *handle = (thread_t)newThread;
                    }

                    if (newThread != nullptr) {
                        Scheduler::put(newThread);
                    }

                    sp[10] = (newThread != nullptr) ? 0 : -1;

                    break;
                }
                case 0x12:
                {
                    if (TCB::running != nullptr) {
                        TCB::running->setFinished(true);
                    }
                    TCB::dispatch();
                    sp[10] = 0;
                    break;
                }
                case 0x13:
                {
                    TCB::dispatch();
                    break;
                }

            }

            w_sepc(sepc+4);
        }
        else {
            w_sepc(sepc+4);
        }
    }
}

void trap_handler(uint64 *sp) {
    RiscV::handleTrap(sp);
}
