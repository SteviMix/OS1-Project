#include "../h/MemoryAllocator.hpp"
#include "../h/tcb.hpp"
#include "../lib/console.h"
#include "../h/Scheduler.hpp"
#include "../h/RiscV.hpp"
#include "../h/syscall_cpp.hpp"
#include "../h/ConsoleHandler.hpp"
#include "../h/syscall_c.hpp"
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
        putc(id);
        putc('s');
        time_sleep(sleeptime);
        putc(id);
        putc('w');
        putc('\n');

        mainSem->signal();

    }
};

class getthread : public Thread {
private:
    char c;
public:

    void run() override {
        while (true) {
            putc('F');
            c = getc();
            putc(c);
        }
    }

};
void userMainMoj() {
    putc('S');putc('t'); putc('a'); putc('r'); putc('t'); putc('\n');



    // Ubacujemo ih u red spremnih
    Thread* t = new getthread();
    t->start();



    while (true) {

    }

    putc('\n'); putc('E'); putc('n'); putc('d'); putc('\n');

}
extern "C" void trap();
extern void userMain();
int main() {

    MemoryAllocator::init();

    RiscV::w_stvec((uint64) &trap);
    ConsoleHandler::init();


    TCB::running = TCB::createThread(nullptr,nullptr,nullptr);

    Thread* userThread = new Thread(reinterpret_cast<void(*)(void*)>(userMainMoj), nullptr);

    userThread->start();

    putc('\n');
    while (true) {
        Thread::dispatch();
    }
    return 0;
}