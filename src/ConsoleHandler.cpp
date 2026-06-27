//
// Created by os on 6/23/26.
//

#include "../h/ConsoleHandler.hpp"
#include "../lib/hw.h"

BoundedBuffer* ConsoleHandler::inputBuffer = nullptr;
BoundedBuffer* ConsoleHandler::outputBuffer = nullptr;

void ConsoleHandler::init() {
    inputBuffer = new BoundedBuffer(256);
    outputBuffer = new BoundedBuffer(1024);
}

void ConsoleHandler::putc(char c) {
    outputBuffer->put(c);
    flushOutput();
}

char ConsoleHandler::getc() {
    return inputBuffer->get();
}

void ConsoleHandler::flushOutput() {
    char c;
    while ((*((volatile char*)CONSOLE_STATUS) & CONSOLE_TX_STATUS_BIT)
           && outputBuffer->getNonBlocking(c)) {
        *((volatile char*)CONSOLE_TX_DATA) = c;
           }
}
void ConsoleHandler::handleConsoleInterrupt() {

    while (*((volatile char*)CONSOLE_STATUS) & CONSOLE_RX_STATUS_BIT) {
        char c = *((volatile char*)CONSOLE_RX_DATA);
        if (c != 0) inputBuffer->putNonBlocking(c);
    }

    flushOutput();
}
