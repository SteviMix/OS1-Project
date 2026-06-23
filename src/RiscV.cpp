//
// Created by os on 6/9/26.
//
#include "../h/RiscV.hpp"

#include "../h/ConsoleHandler.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/Scheduler.hpp"
#include "../lib/console.h"
#include "../h/tcb.hpp"
#include "../h/syscall_c.hpp"
#include "../h/_sem.hpp"
#include "../test/printing.hpp"
#include "../h/ConsoleHandler.hpp"

void RiscV::popSppSpie() {
    __asm__ volatile ("csrw sepc, ra");
    __asm__ volatile ("sret");
}
void PrintHex(uint64 val) {
    const char hexchars[] = "0123456789ABCDEF";
    for (int i = 15; i >=0;i--) {
        uint64 nibble = (val>>(i*4))&0xF;
        putc(hexchars[nibble]);
    }
    putc('\n');
}
void RiscV::handleTrap(uint64* sp) {
    uint64 sstatus = r_sstatus();
    uint64 scause = r_scause();
    uint64 sepc = r_sepc();

    uint64 isInterrupt = scause & 0x8000000000000000UL;
    uint64 causecode = scause & 0x7FFFFFFFFFFFFFFFUL;


    if (isInterrupt) {
        if (causecode == 1) {
            __asm__ volatile ("csrc sip, 0x02");
            TCB::updateSleeping();
            if (TCB::timeSliceTick()) {
                TCB::dispatch();
                w_sstatus(sstatus);
                w_sepc(sepc);
            }
        }
        if (causecode == 9) {
            int irq = plic_claim();

            if (irq == 0x0a) {
                ConsoleHandler::handleConsoleInterrupt();
            }

            plic_complete(irq);
        }

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
                case 0x21: {
                    sem_t* handle = (sem_t*)sp[11];
                    unsigned init = (unsigned)sp[12];
                    sem_t newSem = new _sem(init);
                    if (handle != nullptr) {
                        *handle = newSem;
                    }
                    sp[10] = (newSem != nullptr) ? 0 : -1;
                    break;
                }
                case 0x22: {

                    sem_t handle = (sem_t)sp[11];
                    if (handle != nullptr) {
                        sp[10] = handle->close();
                        delete handle;
                    }else {
                        sp[10] = -1;
                    }
                    break;
                }
                case 0x23:
                case 0x25: {
                    sem_t handle = (sem_t)sp[11];
                    unsigned n = (unsigned) sp[12];
                    if (handle != nullptr) {
                        sp[10] = handle->wait(n);
                    }
                    else sp[10] = -1;
                    break;
                }
                case 0x24:
                case 0x26: {
                    sem_t handle = (sem_t)sp[11];
                    unsigned n = (unsigned) sp[12];
                    if (handle != nullptr) {
                        handle->signal(n);
                    }else {
                        sp[10] = -1;
                    }
                    break;
                }
                case 0x31: {
                    time_t time = (time_t)sp[11];

                    TCB::sleep(time);
                    sp[10] = 0;
                    break;
                }
                case 0x41: {
                    char c = ConsoleHandler::getc();
                    sp[10] = (uint64)c;
                    break;
                }
                case 0x42: {
                    uint64 c;
                    c = sp[11];
                    ConsoleHandler::putc((char)c);
                    break;
                }


            }
            w_sepc(sepc+4);
        }
        else {

            uint64 scause = r_scause();
            uint64 stval = r_stval();
            uint64 stvec = r_stvec();
            uint64 sepc = r_sepc();
            PrintHex(scause);
            PrintHex(stval);
            PrintHex(stvec);

            w_sepc(sepc+4);
        }
    }
}

void trap_handler(uint64 *sp) {
    RiscV::handleTrap(sp);
}
