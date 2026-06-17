//
// Created by os on 6/15/26.
//

#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.hpp"
#include "../lib/hw.h"


void* operator new(size_t size) {
    return mem_alloc(size);
}

void operator delete(void* ptr) {
    mem_free(ptr);
}


void* operator new[](size_t size) {
    return mem_alloc(size);
}

void operator delete[](void* ptr) noexcept {
    mem_free(ptr);
}
class ThreadHelper : public Thread {
    public:
    static void invokeRun(Thread* t) {
        ((ThreadHelper*)t)->run();
    }
};
static void threadWrapper(void* arg) {
    Thread* t = (Thread*) arg;
    if (t != nullptr) {
        ThreadHelper::invokeRun(t);
    }
    thread_exit();
}

Thread::Thread (void (*body)(void*), void* arg):myHandle(nullptr), body(body), arg(arg) {

}

Thread::Thread(): myHandle(nullptr), body(nullptr), arg(nullptr) {

}
int Thread::start() {
    if (myHandle != nullptr) {
        return -1;
    }
    if (body != nullptr) {
        return thread_create(&myHandle, body, arg);
    }else {
        return thread_create(&myHandle, threadWrapper, this);
    }
    return 0;
}

int Thread::sleep(time_t time) {
    return 0;
}

void Thread::dispatch () {
    thread_dispatch();
}

Thread::~Thread () {
}