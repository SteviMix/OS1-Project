//
// Created by os on 6/15/26.
//

#include "../h/syscall_c.hpp"
#include "../lib/hw.h"


void* operator new(size_t size) {
    return mem_alloc(size);
}

void operator delete(void* ptr) noexcept {
    mem_free(ptr);
}

// Globalni new za nizove (npr. int* arr = new int[10];)
void* operator new[](size_t size) {
    return mem_alloc(size);
}

void operator delete[](void* ptr) noexcept {
    mem_free(ptr);
}