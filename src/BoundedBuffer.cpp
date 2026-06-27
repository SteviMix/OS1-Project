//
// Created by os on 6/22/26.
//

#include "../lib/hw.h"
#include "../h/BoundedBuffer.hpp"
#include "../h/MemoryAllocator.hpp"
BoundedBuffer::BoundedBuffer(int capacity): capacity(capacity), head(0), tail(0) {
    size_t BufferBlocks = (capacity*sizeof(char) + MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE;
    buffer = (char*) MemoryAllocator::mem_alloc(BufferBlocks);
    spaceAvailable = new _sem(capacity);
    itemAvailable = new _sem(0);
}

BoundedBuffer::~BoundedBuffer() {
    MemoryAllocator::mem_free(buffer);
    itemAvailable->close();
    spaceAvailable->close();
}

void BoundedBuffer::put(char c) {
    spaceAvailable->wait(1);
    buffer[tail] = c;
    tail = (tail + 1) % capacity;
    itemAvailable->signal(1);
}

char BoundedBuffer::get() {
    itemAvailable->wait(1);
    char c = buffer[head];
    head = (head + 1) % capacity;
    spaceAvailable->signal(1);
    return c;
}
bool BoundedBuffer::putNonBlocking(char c) {
    int next = (tail + 1) % capacity;
    if (next == head) {
        return false;
    }
    buffer[tail] = c;
    tail = next;
    itemAvailable->signal(1);
    return true;
}

bool BoundedBuffer::getNonBlocking(char& out) {
    if (head == tail) {
        return false;
    }
    out = buffer[head];
    head = (head + 1) % capacity;
    spaceAvailable->signal(1);
    return true;
}