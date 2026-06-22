//
// Created by os on 6/1/26.
//

#include "../h/MemoryAllocator.hpp"


FreeMemBlock* MemoryAllocator::free_mem_head = nullptr;

void MemoryAllocator::init() {
    static bool is_initialised = false;

    if (is_initialised) return;

    free_mem_head = (FreeMemBlock*)HEAP_START_ADDR;
    size_t total_bytes = (char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR;
    free_mem_head->next = nullptr;
    free_mem_head->size = total_bytes/MEM_BLOCK_SIZE;
    is_initialised = true;
}

void* MemoryAllocator::mem_alloc(size_t size_in_blocks) {
    if (size_in_blocks == 0) return nullptr;
    FreeMemBlock* curr = free_mem_head;
    FreeMemBlock* prev = nullptr;


    while (curr){
        if (curr->size >= size_in_blocks){
            break;
        }
        prev = curr;
        curr = curr->next;
    }

    if (!curr) return nullptr;

    if (curr->size > size_in_blocks){
        FreeMemBlock *remainder = (FreeMemBlock*)((char*)curr + size_in_blocks*MEM_BLOCK_SIZE);
        remainder->size = curr->size - size_in_blocks;
        remainder->next = curr->next;

        if (prev){
            prev->next = remainder;
        }else{
            free_mem_head = remainder;
        }
    }else{
        if (prev){
            prev->next = curr->next;
        }else{
            free_mem_head = curr->next;
        }
    }

    curr->next = nullptr;
    return (char*)curr+sizeof(FreeMemBlock);
}

int MemoryAllocator::mem_free(void *ptr) {
    if (!ptr) return 0;

    FreeMemBlock* blk = (FreeMemBlock*)((char*)ptr - sizeof(FreeMemBlock));

    if (blk->next != nullptr){
        return -2;
    }

    FreeMemBlock* curr = free_mem_head;
    FreeMemBlock* prev = nullptr;

    while (curr != nullptr && curr < blk){
        prev = curr;
        curr = curr->next;
    }


    if (curr && ((char*)blk + blk->size*MEM_BLOCK_SIZE)== (char*)curr){
        blk->next = curr->next;
        blk->size +=curr->size;
    }else{
        blk->next = curr;
    }

    if (prev && ((char*)prev + prev->size*MEM_BLOCK_SIZE)== (char*)blk){
        prev->size +=blk->size;
        prev->next = blk->next;
    }else{
        if (prev){
            prev->next = blk;
        } else{
            free_mem_head = blk;
        }
    }

    return 0;
}
