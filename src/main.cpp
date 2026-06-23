#include "../h/MemoryAllocator.hpp"
#include "../h/tcb.hpp"
#include "../lib/console.h"
#include "../h/Scheduler.hpp"
#include "../h/RiscV.hpp"
#include "../h/syscall_cpp.hpp"
#include "../h/ConsoleHandler.hpp"
#include "../h/syscall_cpp.hpp"
#include "../lib/hw.h" // Koristimo __putc iz hw.lib za štampanje

// Pravimo klasu koja nasleđuje Thread (testira zaštićeni konstruktor i run metodu)
Semaphore* mainSem;
class TestThread : public Thread {
private:
    char id;
    time_t sleeptime;
public:
    // Konstruktor postavlja ID i automatski zove zaštićeni Thread()
    TestThread(char id, time_t time) : Thread(), id(id), sleeptime(time) {}
    int count = 0;
    // Polimorfna metoda koju jezgro treba da izvrši
    void run() override {
        __putc(id);
        __putc('s');
        time_sleep(sleeptime);
        __putc(id);
        __putc('w');
        __putc('\n');

        mainSem->signal();

    }
};
void userMainMoj() {
    putc('S'); __putc('t'); __putc('a'); __putc('r'); __putc('t'); __putc('\n');
    mainSem = new Semaphore(0);
    // Test operatora new (alokator memorije)
    __putc('1');
    TestThread* t1 = new TestThread('A', 200);

    __putc('2');
    TestThread* t2 = new TestThread('B', 30);

    __putc('3');
    TestThread* t3 = new  TestThread('C', 100);


    // Ubacujemo ih u red spremnih
    t1->start();
    t2->start();
    t3->start();


    // userMain mora da prepušta procesor kako bi t1 i t2 dobili šansu da rade.
    // Vrtimo dovoljno iteracija da niti stignu da završe svoj posao.
    for (int i = 0; i < 3; i++) {
        mainSem->wait();
    }



    // Oslobađamo objekte (test operatora delete)
    delete t1;
    delete t2;
    delete t3;
    delete mainSem;
    __putc('\n'); __putc('E'); __putc('n'); __putc('d'); __putc('\n');

}
extern "C" void trap();
extern void userMain();
int main() {

    MemoryAllocator::init();

    RiscV::w_stvec((uint64) &trap);
    ConsoleHandler::init();


    TCB::running = TCB::createThread(nullptr,nullptr,nullptr);
    putc('D');

    Thread* userThread = new Thread(reinterpret_cast<void(*)(void*)>(userMainMoj), nullptr);

    userThread->start();

    __putc('\n');
    while (true) {
        Thread::dispatch();
    }
    return 0;
}