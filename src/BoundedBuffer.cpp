//
// Created by os on 6/22/26.
//

#include "../lib/hw.h"
#include "../h/BoundedBuffer.hpp"
#include "../h/MemoryAllocator.hpp"
BoundedBuffer::BoundedBuffer(int capacity): capacity(capacity), head(0), tail(0) {
    size_t BufferBlocks = (capacity*sizeof(char) + MEM_BLOCK_SIZE-1)/MEM_BLOCK_SIZE;
    buffer = (char*) MemoryAllocator::mem_alloc(BufferBlocks);
    spaceAvailable = new Semaphore(capacity);
    itemAvailable = new Semaphore(0);
}

BoundedBuffer::~BoundedBuffer() {
    MemoryAllocator::mem_free(buffer);
    delete spaceAvailable;
    delete itemAvailable;
}

void BoundedBuffer::put(char c) {
    spaceAvailable->wait();
    buffer[tail] = c;
    tail = (tail + 1) % capacity;
    itemAvailable->signal();
}

char BoundedBuffer::get() {
    itemAvailable->wait();
    char c = buffer[head];
    head = (head + 1) % capacity;
    spaceAvailable->signal();
    return c;
}
