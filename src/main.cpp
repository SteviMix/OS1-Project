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
}


void nit2_body(void* arg) {
    for (int i = 5; i < 10; i++) {
        __putc('0'+(char)i);
        TCB::dispatch();
    }
    TCB::running->setFinished((true));
    Thread::dispatch();
}
extern "C" void trap();
int main() {
    MemoryAllocator::init();

    RiscV::w_stvec((uint64) &trap);
    // Kreiraj nit 1
    TCB* nit1 = TCB::createThread(nit1_body, nullptr);
    // Kreiraj nit 2
    TCB* nit2 = TCB::createThread(nit2_body, nullptr);

    // Ubaci ih u scheduler
    Scheduler::put(nit1);
    Scheduler::put(nit2);

    // Prvi dispatch pokreće nit1
    TCB::dispatch();

    // Ako sve radi, program će se "vrteti" između nit1 i nit2
    // dok ne završe posao.
    while (1);
}