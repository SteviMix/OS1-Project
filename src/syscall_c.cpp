//
// Created by os on 6/9/26.
//

#include "../h/syscall_c.hpp"
#include "../lib/hw.h"
#include "../lib/console.h"
void* mem_alloc(size_t size) {

    void* volatile ptr;
    __asm__ volatile (
        "mv a0, %1\t\n"
        "mv a1, %2\t\n"
        "ecall\t\n"
        "mv %0, a0"
        : "=r"(ptr)
        : "r"(0x01), "r" (size)
        : "a0", "a1"
        );

    return ptr;
}

int mem_free(void* ptr) {
    int ret;

    __asm__ volatile (
        "mv a0, %1\t\n"
        "mv a1, %2\t\n"
        "ecall\t\n"
        "mv %0, a0"
        : "=r"(ret)
        : "r"(0x02), "r" (ptr)
        : "a0", "a1", "memory"
        );
    return  ret;
}
