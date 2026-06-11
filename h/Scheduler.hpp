//
// Created by os on 6/11/26.
//

#ifndef OS_PROJEKAT_SCHEDULER_HPP
#define OS_PROJEKAT_SCHEDULER_HPP

class TCB;

class Scheduler {
public:
    static TCB* get();
    static void put(TCB* tcb);

private:
    static TCB* head;
    static TCB* tail;
};
#endif //OS_PROJEKAT_SCHEDULER_HPP
