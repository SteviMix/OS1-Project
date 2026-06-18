#include "../h/MemoryAllocator.hpp"
#include "../h/tcb.hpp"
#include "../lib/console.h"
#include "../h/Scheduler.hpp"
#include "../h/RiscV.hpp"
#include "../h/syscall_cpp.hpp"

#include "../h/syscall_cpp.hpp"
#include "../lib/hw.h" // Koristimo __putc iz hw.lib za štampanje

// Pravimo klasu koja nasleđuje Thread (testira zaštićeni konstruktor i run metodu)
class TestThread : public Thread {
private:
    char id;
public:
    // Konstruktor postavlja ID i automatski zove zaštićeni Thread()
    TestThread(char id) : Thread(), id(id) {}

    // Polimorfna metoda koju jezgro treba da izvrši
    void run() override {
        for (int i = 0; i < 5; i++) {
            __putc(id);
            Thread::dispatch(); // Eksplicitno sinhrono prepuštanje procesora
        }
    }
};
void worker_c(void* arg) {
    char id = (char)(uint64)arg;
    for (int i = 0; i<5; i++) {
        __putc(id);
        thread_dispatch();
    }
    thread_exit();
};
void userMain() {
    __putc('S'); __putc('t'); __putc('a'); __putc('r'); __putc('t'); __putc('\n');

    // Test operatora new (alokator memorije)
    __putc('1');
    TestThread* t1 = new TestThread('A');

    __putc('2');
    TestThread* t2 = new TestThread('B');

    __putc('3');
    thread_t t3;
    thread_create(&t3, worker_c, (void*)(uint64)'C');


    // Ubacujemo ih u red spremnih
    t1->start();
    t2->start();


    // userMain mora da prepušta procesor kako bi t1 i t2 dobili šansu da rade.
    // Vrtimo dovoljno iteracija da niti stignu da završe svoj posao.
    for (int i = 0; i < 20; i++) {
        Thread::dispatch();
    }


    // Oslobađamo objekte (test operatora delete)
    delete t1;
    delete t2;

    __putc('\n'); __putc('E'); __putc('n'); __putc('d'); __putc('\n');

}
extern "C" void trap();
int main() {
    MemoryAllocator::init();

    RiscV::w_stvec((uint64) &trap);
    TCB::running = TCB::createThread(nullptr,nullptr,nullptr);
    __putc('X'); __putc('\n');

    void* ptr = mem_alloc(50);
    __putc('Z');__putc('\n');
    mem_free(ptr);
    __putc('C');__putc('\n');

    Thread* userThread = new Thread(reinterpret_cast<void(*)(void*)>(userMain), nullptr);
    __putc('X');__putc('\n');
    userThread->start();
    __putc('\n');
    while (true) {
        Thread::dispatch();
    }
    return 0;
}