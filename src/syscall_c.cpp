//
// Created by os on 6/9/26.
//

#include "../h/syscall_c.hpp"
#include "../lib/hw.h"
#include "../lib/console.h"
void* mem_alloc(size_t size) {
    void* ptr;
    __asm__ volatile (
        "li a0, 1\n"        // hardkodirano 0x01
        "mv a1, %1\n"       // size
        "ecall\n"
        "mv %0, a0\n"
        : "=r"(ptr)
        : "r"(size)
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

int thread_create(thread_t *handle, void (*start_routine)(void *), void *arg) {
    int ret;
    void* stack_space = mem_alloc(DEFAULT_STACK_SIZE);
    if (stack_space == nullptr) {
        return -1;
    }
    __asm__ volatile (
        "mv a1, %1\n\t"
        "mv a2, %2\n\t"
        "mv a3, %3\n\t"
        "mv a4, %4\n\t"
        "li a0, 0x11\n\t"
        "ecall\n\t"
        "mv %0, a0"
        : "=r"(ret)
        : "r"(handle), "r"(start_routine), "r"(arg), "r"(stack_space)
        : "a0", "a1", "a2", "a3"
    );
    return ret;
}

void thread_dispatch() {
    __asm__ volatile (
        "li a0, 0x13\n\t"
        "ecall"
        : : : "a0"
    );
}

int thread_exit() {
    int ret;
    __asm__ volatile (
        "li a0, 0x12\n\t"
        "ecall\n\t"
        "mv %0, a0"
        : "=r"(ret)
        :
        : "a0"
    );
    return ret;
}

int thread_start(thread_t handle) {
    int ret;
    __asm__ volatile (
        "mv a1, %1 \t\n"
        "li a0, 0x14 \t\n"
        "ecall \n"
        "mv %0, a0 \n"
        : "=r"(ret)
        : "r" (handle)
        );
    return ret;
}

int sem_open(sem_t *handle, unsigned init) {
    int ret;
    __asm__ volatile (
        "mv a1, %1 \t\n"
        "mv a2, %2\t\n"
        "mv a0, 0x21\t\n"
        "ecall \n\t"
        "mv %0, a0 \n"
        : "=r"(ret)
        : "r"(handle), "r"(init)
        : "a0", "a1", "a2"
        );
    return ret;
}

int sem_close(sem_t id) {
    int ret;

    __asm__ volatile(
        "mv a1, %1 \n\t"
        "mv a0, 0x22 \n\t"
        "ecall \n\t"
        "mv %0, a0 \n\t"
        : "=r"(ret)
        : "r"(id)
        : "a0", "a1"
        );
    return ret;
}

int sem_wait_n(sem_t id, unsigned n) {
    int ret;

    __asm__ volatile (
        "mv a1, %1 \t\n"
        "mv a2, %2\t\n"
        "mv a0, 0x25 \n\t"
        "ecall \n\t"
        "mv %0, a0 \n\t"
        : "=r"(ret)
        : "r"(id), "r"(n)
        : "a0", "a1", "a2"
        );
    return ret;
}

int sem_signal_n(sem_t id, unsigned n) {
    int ret;

    __asm__ volatile (
        "mv a1, %1 \t\n"
        "mv a2, %2\t\n"
        "mv a0, 0x26 \n\t"
        "exall \n\t"
        "mv %0, a0 \n\t"
        : "=r"(ret)
        : "r"(id), "r"(n)
        : "a0", "a1", "a2"
        );
    return ret;
}


int sem_wait(sem_t id) {
    return sem_wait_n(id, 1);
}

int sem_signal(sem_t id) {
    return sem_signal_n(id, 1);
}
