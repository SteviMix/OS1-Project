//
// Created by os on 6/1/26.
//

#include "../lib/console.h"
#include "../h/MemoryAllocator.hpp"

void printString(const char*str){
    while (*str){
        __putc(*str);
        str++;
    }
}

void printHex(size_t n){
    char hexDigits[] = "0123456789ABCDEF";
    char buffer[16];

    int i= 0;

    while (n > 0){
        buffer [i++] = hexDigits[n%16];
        n/= 16;
    }

    while (--i>=0){
        __putc(buffer[i]);
    }
}


void pokrenitest(){
    printString("\n============ MOJ MEMORY ALOKATOR TEST =============\n");
    printString("TEST1\n");
    char *ptr1 = (char*)MemoryAllocator::mem_alloc(64);
    if (ptr1 == nullptr){
        printString("PRVI MALLOC VRATIO NULL");
        return;
    }

    printString("ADRESA PTR1 = ");
    printHex((size_t)ptr1);
    printString("\n");

    for (int i = 0; i < 64; i++){
        ptr1[i] = 'X';
    }
    printString("UPIS U PTR1 USPESAN\n");

    printString("TEST2/\n");
    char* ptr2 = (char*)MemoryAllocator::mem_alloc(100);
    if (!ptr2){
        printString("DRUGI MEMALPC VRATIO NULL");
        return;
    }

    printString("ADRESA PTR2 = ");
    printHex((size_t)ptr2);
    printString("\n");

    if (ptr2 < ptr1){
        printString("GRESKA PTR2 < PTR1");
        return;
    }

    size_t razlika = (size_t)ptr2-(size_t)ptr1;
    printString("RASLIKA PTR2 i PTR1 = ");
    printHex(razlika);
    printString("\n");

    printString("TEST 3");

    char* ptr3 = (char*)MemoryAllocator::mem_alloc(MEM_BLOCK_SIZE*2);
    if (!ptr3){
        printString("TRECI MEMALLOC VRATIO NLL");
        return;
    }
    printString("ADRESA PTR3 =");
    printHex((size_t)ptr3);
    printString("\n");


    printString("TETS 4");
    if (MemoryAllocator::mem_free(ptr2)){
        printString("NEUSPESNO OSLOBODJEN PTR2");
        return;
    }

    if (MemoryAllocator::mem_free(ptr3)){
        printString("NEUSPESNO OSLOBODJEN PTR3");
        return;
    }

    if (MemoryAllocator::mem_free(ptr1)){
        printString("NEUSPESNO OSLOBODJEN PTR1");
        return;
    }

    printString("PROVERA SPAJANJA\n");

    char* provera =(char*)MemoryAllocator::mem_alloc(MEM_BLOCK_SIZE*3);

    if (!provera){
        printString("NEUSPELA PROVERA");
        return;
    }

    printString("ADRWSA PROVERE = ");
    printHex((size_t)provera);
    printString("\n");

    MemoryAllocator::mem_free(provera);
}

void main(){
    MemoryAllocator::init();
    pokrenitest();

    while(true){}
}