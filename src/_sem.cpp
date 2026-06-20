//
// Created by os on 6/20/26.
//

#include "../h/_sem.hpp"

int _sem::wait(unsigned n) {
    if (isClosed) return -1;

    if (val >= (int) n) {
        val -= n;
        return 0;
    }

    TCB::running->setBlocked(true);
    TCB::running->setReqestedRes(n);

    if (head == nullptr) {
        head = tail = TCB::running;
    }else {
        tail->next = TCB::running;
        tail = tail->next;
    }
    TCB::running->next = nullptr;
    TCB::dispatch();

    if (isClosed) return -1;
    return 0;
}

int _sem::signal(unsigned n) {
    if (isClosed) return -1;
    val += n;
    while (head != nullptr && val >= (int)head->getReqestedRes()) {
        val -= head->getReqestedRes();
        TCB* wakeUp = head;
        head = head->next;
        if (head == nullptr) {
            tail = nullptr;
        }
        wakeUp->next = nullptr;
        wakeUp->setBlocked(false);
        Scheduler::put(wakeUp);
    }
    return 0;
}

int _sem::close() {
    if (isClosed) return -1;
    isClosed = true;

    while (head != nullptr) {
        TCB* wakeUp = head;
        head = head->next;
        wakeUp->next = nullptr;
        wakeUp->setBlocked(false);
        Scheduler::put(wakeUp);
    }
    tail = nullptr;
    return 0;
}
