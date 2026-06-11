#include "../h/MemoryAllocator.hpp"
#include "../h/RiscV.hpp"
#include "../h/syscall_c.hpp"
#include "../lib/console.h"

extern "C" void trap();

int main() {
    MemoryAllocator::init();
    __putc('a');
    RiscV::w_stvec((uint64)&trap);
    __putc('A');
    void * ptr = mem_alloc(64);
    __putc('B');
    if (ptr != nullptr) {
        __putc('D');
        mem_free(ptr);
    }else {
        __putc('E');
    }
    __putc('v');
    while (1);
}