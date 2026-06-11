//
// Created by os on 6/11/26.
//



#include "../h/Scheduler.hpp"
#include "../h/tcb.hpp"


TCB* Scheduler::head = nullptr;
TCB* Scheduler::tail = nullptr;

void Scheduler::put(TCB* tcb) {
    if (tcb == nullptr) {
        return;
    }

    tcb->next = nullptr;

    if (tail != nullptr) {
        tail->next = tcb;
        tail = tcb;
    } else {
        head = tail = tcb;
    }
}

TCB* Scheduler::get() {
    if (head == nullptr) {
        return nullptr;
    }

    TCB* tcb = head;

    head = head->next;

    if (head == nullptr) {
        tail = nullptr;
    }

    tcb->next = nullptr;

    return tcb;
}