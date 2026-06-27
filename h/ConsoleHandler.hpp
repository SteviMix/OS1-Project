//
// Created by os on 6/23/26.
//

#ifndef OS1_PROJECT_CONSOLEHANDLER_H
#define OS1_PROJECT_CONSOLEHANDLER_H

#include "BoundedBuffer.hpp"

class ConsoleHandler {
public:
    static void init();

    static void putc(char c);
    static char getc();

    static void handleConsoleInterrupt();

    static void flushOutput();

private:
    static BoundedBuffer* inputBuffer;
    static BoundedBuffer* outputBuffer;
};

#endif //OS1_PROJECT_CONSOLEHANDLER_H
