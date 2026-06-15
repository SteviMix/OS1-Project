#include "../h/MemoryAllocator.hpp"
#include "../h/tcb.hpp"
#include "../lib/console.h"
#include "../h/Scheduler.hpp"
#include "../h/RiscV.hpp"
#include "../h/syscall_cpp.hpp"

void nit1_body(void* arg) {
    for (int i = 0; i < 5; i++) {
        __putc('0'+(char)i);
        TCB::dispatch();
    }
    TCB::running->setFinished(true);
    TCB::dispatch();
}


void nit2_body(void* arg) {
    for (int i = 5; i < 10; i++) {
        __putc('0'+(char)i);
        TCB::dispatch();
    }
    TCB::running->setFinished((true));
    TCB::dispatch();

}
extern "C" void trap();
int main() {
    MemoryAllocator::init();

    RiscV::w_stvec((uint64) &trap);
    Thread* glavna = new Thread(nullptr, nullptr);
    Thread* nit1 = new Thread(nit1_body, nullptr);
    Thread* nit2 = new Thread(nit2_body, nullptr);
    Scheduler::put()


    while (1) {
        TCB::dispatch();
    }
}