//
// Created by os on 6/23/26.
//

#include "../h/ConsoleHandler.hpp"
#include "../lib/hw.h"
#include "../h/syscall_cpp.hpp"
#include "../lib/console.h"
BoundedBuffer* ConsoleHandler::inputBuffer = nullptr;
BoundedBuffer* ConsoleHandler::outputBuffer = nullptr;

void ConsoleHandler::init() {
    inputBuffer = new BoundedBuffer(256);
    outputBuffer = new BoundedBuffer(1024);

    Thread* printerThread = new Thread(printerThreadBody, nullptr);

    printerThread->start();
}

void ConsoleHandler::putc(char c) {
    outputBuffer->put(c);
}

char ConsoleHandler::getc() {
    return inputBuffer->get();
}

void ConsoleHandler::handleConsoleInterrupt() {
    while (*((volatile uint8*)CONSOLE_STATUS)&CONSOLE_RX_DATA) {
        char c = *((volatile char*)CONSOLE_RX_DATA);
        if (c!= 0) {
            inputBuffer->put(c);
        }

    }
}

void ConsoleHandler::printerThreadBody(void* arg) {
    while (true) {
        char c = outputBuffer->get();

        while ((*((volatile uint8*)CONSOLE_STATUS)&CONSOLE_TX_STATUS_BIT) == 0) {
            Thread::dispatch();
        }
        *((volatile char*)CONSOLE_TX_DATA) = c;
    }

}
