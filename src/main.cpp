#include "../h/MemoryAllocator.hpp"
#include "../h/tcb.hpp"
#include "../h/RiscV.hpp"
#include "../h/syscall_cpp.hpp"
#include "../h/ConsoleHandler.hpp"
#include "../h/syscall_c.hpp"
#include "../lib/hw.h"
extern "C" void trap();
extern void userMain();
int main() {

    MemoryAllocator::init();

    RiscV::w_stvec((uint64) &trap);
    ConsoleHandler::init();


    TCB::running = TCB::createThread(nullptr,nullptr,nullptr);

    Thread* userThread = new Thread(reinterpret_cast<void(*)(void*)>(userMain), nullptr);

    userThread->start();

    putc('\n');
    while (true) {
        Thread::dispatch();
    }
    return 0;
}