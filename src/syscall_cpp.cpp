//
// Created by os on 6/15/26.
//

#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.hpp"
#include "../lib/hw.h"


void* operator new(size_t size) {
    return mem_alloc(size);
}

void operator delete(void* ptr) noexcept {
    mem_free(ptr);
}


void* operator new[](size_t size) {
    return mem_alloc(size);
}

void operator delete[](void* ptr) noexcept {
    mem_free(ptr);
}

Thread::Thread (void (*body)(void*), void* arg) {
    thread_create(&this->myHandle, body, arg);
}

int Thread::start() {
    thread_start(this->myHandle);
    return 0;
}

int Thread::sleep(time_t time) {
    return 0;
}

void Thread::dispatch () {
    thread_dispatch();
}

Thread::~Thread () {
    delete myHandle;
}