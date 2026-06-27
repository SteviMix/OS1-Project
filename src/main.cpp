

#include "../h/MemoryAllocator.hpp"
#include "../h/tcb.hpp"
#include "../h/RiscV.hpp"
#include "../h/syscall_cpp.hpp"
#include "../h/ConsoleHandler.hpp"
#include "../h/syscall_c.hpp"
#include "../lib/hw.h"
extern "C" void trap();
extern void userMain();
static void idleBody(void*) {
    while (true) thread_dispatch();
}
int main() {

    MemoryAllocator::init();

    RiscV::w_stvec((uint64) &trap);
    ConsoleHandler::init();


    TCB::running = TCB::createThread(nullptr,nullptr,nullptr);
    thread_t idle;
    thread_create(&idle, idleBody, nullptr);
    thread_t userThread;

    thread_create(&userThread, reinterpret_cast<void(*)(void*)>(userMain), nullptr);


    while (((TCB*)userThread)->isFinished() == false) {
        Thread::dispatch();
    }

    *((volatile uint32*)0x100000) = 0x5555;
    return 0;
}