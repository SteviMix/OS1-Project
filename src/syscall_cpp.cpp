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

static void threadWrapper(void* arg) {
    Thread* t = (Thread*) arg;
    if (t != nullptr) {
        t->run();
    }
}

Thread::Thread (void (*body)(void*), void* arg): body(body), arg(arg) {
    thread_create(&myHandle, body, arg);
}

Thread::Thread(): body(nullptr), arg(nullptr) {
    thread_create(&myHandle, threadWrapper, this);
}
int Thread::start() {
    thread_start(myHandle);
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