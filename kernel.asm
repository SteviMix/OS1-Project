
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	56013103          	ld	sp,1376(sp) # 80004560 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	5a0010ef          	jal	ra,800015bc <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <_Z11printStringPKc>:
//

#include "../lib/console.h"
#include "../h/MemoryAllocator.hpp"

void printString(const char*str){
    80001000:	fe010113          	addi	sp,sp,-32
    80001004:	00113c23          	sd	ra,24(sp)
    80001008:	00813823          	sd	s0,16(sp)
    8000100c:	00913423          	sd	s1,8(sp)
    80001010:	02010413          	addi	s0,sp,32
    80001014:	00050493          	mv	s1,a0
    while (*str){
    80001018:	0004c503          	lbu	a0,0(s1)
    8000101c:	00050a63          	beqz	a0,80001030 <_Z11printStringPKc+0x30>
        __putc(*str);
    80001020:	00002097          	auipc	ra,0x2
    80001024:	65c080e7          	jalr	1628(ra) # 8000367c <__putc>
        str++;
    80001028:	00148493          	addi	s1,s1,1
    while (*str){
    8000102c:	fedff06f          	j	80001018 <_Z11printStringPKc+0x18>
    }
}
    80001030:	01813083          	ld	ra,24(sp)
    80001034:	01013403          	ld	s0,16(sp)
    80001038:	00813483          	ld	s1,8(sp)
    8000103c:	02010113          	addi	sp,sp,32
    80001040:	00008067          	ret

0000000080001044 <_Z8printHexm>:

void printHex(size_t n){
    80001044:	fb010113          	addi	sp,sp,-80
    80001048:	04113423          	sd	ra,72(sp)
    8000104c:	04813023          	sd	s0,64(sp)
    80001050:	02913c23          	sd	s1,56(sp)
    80001054:	05010413          	addi	s0,sp,80
    char hexDigits[] = "0123456789ABCDEF";
    80001058:	00003797          	auipc	a5,0x3
    8000105c:	fc878793          	addi	a5,a5,-56 # 80004020 <CONSOLE_STATUS+0x10>
    80001060:	0007b703          	ld	a4,0(a5)
    80001064:	fce43423          	sd	a4,-56(s0)
    80001068:	0087b703          	ld	a4,8(a5)
    8000106c:	fce43823          	sd	a4,-48(s0)
    80001070:	0107c783          	lbu	a5,16(a5)
    80001074:	fcf40c23          	sb	a5,-40(s0)
    char buffer[16];

    int i= 0;
    80001078:	00000493          	li	s1,0

    while (n > 0){
    8000107c:	02050663          	beqz	a0,800010a8 <_Z8printHexm+0x64>
        buffer [i++] = hexDigits[n%16];
    80001080:	00f57793          	andi	a5,a0,15
    80001084:	fe040713          	addi	a4,s0,-32
    80001088:	00f707b3          	add	a5,a4,a5
    8000108c:	fe87c703          	lbu	a4,-24(a5)
    80001090:	fe040793          	addi	a5,s0,-32
    80001094:	009787b3          	add	a5,a5,s1
    80001098:	fce78c23          	sb	a4,-40(a5)
        n/= 16;
    8000109c:	00455513          	srli	a0,a0,0x4
        buffer [i++] = hexDigits[n%16];
    800010a0:	0014849b          	addiw	s1,s1,1
    while (n > 0){
    800010a4:	fd9ff06f          	j	8000107c <_Z8printHexm+0x38>
    }

    while (--i>=0){
    800010a8:	fff4849b          	addiw	s1,s1,-1
    800010ac:	0004ce63          	bltz	s1,800010c8 <_Z8printHexm+0x84>
        __putc(buffer[i]);
    800010b0:	fe040793          	addi	a5,s0,-32
    800010b4:	009787b3          	add	a5,a5,s1
    800010b8:	fd87c503          	lbu	a0,-40(a5)
    800010bc:	00002097          	auipc	ra,0x2
    800010c0:	5c0080e7          	jalr	1472(ra) # 8000367c <__putc>
    800010c4:	fe5ff06f          	j	800010a8 <_Z8printHexm+0x64>
    }
}
    800010c8:	04813083          	ld	ra,72(sp)
    800010cc:	04013403          	ld	s0,64(sp)
    800010d0:	03813483          	ld	s1,56(sp)
    800010d4:	05010113          	addi	sp,sp,80
    800010d8:	00008067          	ret

00000000800010dc <_Z11pokrenitestv>:


void pokrenitest(){
    800010dc:	fd010113          	addi	sp,sp,-48
    800010e0:	02113423          	sd	ra,40(sp)
    800010e4:	02813023          	sd	s0,32(sp)
    800010e8:	00913c23          	sd	s1,24(sp)
    800010ec:	01213823          	sd	s2,16(sp)
    800010f0:	01313423          	sd	s3,8(sp)
    800010f4:	03010413          	addi	s0,sp,48
    printString("\n============ MOJ MEMORY ALOKATOR TEST =============\n");
    800010f8:	00003517          	auipc	a0,0x3
    800010fc:	f4050513          	addi	a0,a0,-192 # 80004038 <CONSOLE_STATUS+0x28>
    80001100:	00000097          	auipc	ra,0x0
    80001104:	f00080e7          	jalr	-256(ra) # 80001000 <_Z11printStringPKc>
    printString("TEST1\n");
    80001108:	00003517          	auipc	a0,0x3
    8000110c:	f6850513          	addi	a0,a0,-152 # 80004070 <CONSOLE_STATUS+0x60>
    80001110:	00000097          	auipc	ra,0x0
    80001114:	ef0080e7          	jalr	-272(ra) # 80001000 <_Z11printStringPKc>
    char *ptr1 = (char*)MemoryAllocator::mem_alloc(64);
    80001118:	04000513          	li	a0,64
    8000111c:	00000097          	auipc	ra,0x0
    80001120:	31c080e7          	jalr	796(ra) # 80001438 <_ZN15MemoryAllocator9mem_allocEm>
    if (ptr1 == nullptr){
    80001124:	02050e63          	beqz	a0,80001160 <_Z11pokrenitestv+0x84>
    80001128:	00050493          	mv	s1,a0
        printString("PRVI MALLOC VRATIO NULL");
        return;
    }

    printString("ADRESA PTR1 = ");
    8000112c:	00003517          	auipc	a0,0x3
    80001130:	f6450513          	addi	a0,a0,-156 # 80004090 <CONSOLE_STATUS+0x80>
    80001134:	00000097          	auipc	ra,0x0
    80001138:	ecc080e7          	jalr	-308(ra) # 80001000 <_Z11printStringPKc>
    printHex((size_t)ptr1);
    8000113c:	00048513          	mv	a0,s1
    80001140:	00000097          	auipc	ra,0x0
    80001144:	f04080e7          	jalr	-252(ra) # 80001044 <_Z8printHexm>
    printString("\n");
    80001148:	00003517          	auipc	a0,0x3
    8000114c:	08850513          	addi	a0,a0,136 # 800041d0 <CONSOLE_STATUS+0x1c0>
    80001150:	00000097          	auipc	ra,0x0
    80001154:	eb0080e7          	jalr	-336(ra) # 80001000 <_Z11printStringPKc>

    for (int i = 0; i < 64; i++){
    80001158:	00000793          	li	a5,0
    8000115c:	0280006f          	j	80001184 <_Z11pokrenitestv+0xa8>
        printString("PRVI MALLOC VRATIO NULL");
    80001160:	00003517          	auipc	a0,0x3
    80001164:	f1850513          	addi	a0,a0,-232 # 80004078 <CONSOLE_STATUS+0x68>
    80001168:	00000097          	auipc	ra,0x0
    8000116c:	e98080e7          	jalr	-360(ra) # 80001000 <_Z11printStringPKc>
        return;
    80001170:	1c40006f          	j	80001334 <_Z11pokrenitestv+0x258>
        ptr1[i] = 'X';
    80001174:	00f48733          	add	a4,s1,a5
    80001178:	05800693          	li	a3,88
    8000117c:	00d70023          	sb	a3,0(a4)
    for (int i = 0; i < 64; i++){
    80001180:	0017879b          	addiw	a5,a5,1
    80001184:	03f00713          	li	a4,63
    80001188:	fef756e3          	bge	a4,a5,80001174 <_Z11pokrenitestv+0x98>
    }
    printString("UPIS U PTR1 USPESAN\n");
    8000118c:	00003517          	auipc	a0,0x3
    80001190:	f1450513          	addi	a0,a0,-236 # 800040a0 <CONSOLE_STATUS+0x90>
    80001194:	00000097          	auipc	ra,0x0
    80001198:	e6c080e7          	jalr	-404(ra) # 80001000 <_Z11printStringPKc>

    printString("TEST2/\n");
    8000119c:	00003517          	auipc	a0,0x3
    800011a0:	f1c50513          	addi	a0,a0,-228 # 800040b8 <CONSOLE_STATUS+0xa8>
    800011a4:	00000097          	auipc	ra,0x0
    800011a8:	e5c080e7          	jalr	-420(ra) # 80001000 <_Z11printStringPKc>
    char* ptr2 = (char*)MemoryAllocator::mem_alloc(100);
    800011ac:	06400513          	li	a0,100
    800011b0:	00000097          	auipc	ra,0x0
    800011b4:	288080e7          	jalr	648(ra) # 80001438 <_ZN15MemoryAllocator9mem_allocEm>
    800011b8:	00050913          	mv	s2,a0
    if (!ptr2){
    800011bc:	14050a63          	beqz	a0,80001310 <_Z11pokrenitestv+0x234>
        printString("DRUGI MEMALPC VRATIO NULL");
        return;
    }

    printString("ADRESA PTR2 = ");
    800011c0:	00003517          	auipc	a0,0x3
    800011c4:	f2050513          	addi	a0,a0,-224 # 800040e0 <CONSOLE_STATUS+0xd0>
    800011c8:	00000097          	auipc	ra,0x0
    800011cc:	e38080e7          	jalr	-456(ra) # 80001000 <_Z11printStringPKc>
    printHex((size_t)ptr2);
    800011d0:	00090513          	mv	a0,s2
    800011d4:	00000097          	auipc	ra,0x0
    800011d8:	e70080e7          	jalr	-400(ra) # 80001044 <_Z8printHexm>
    printString("\n");
    800011dc:	00003517          	auipc	a0,0x3
    800011e0:	ff450513          	addi	a0,a0,-12 # 800041d0 <CONSOLE_STATUS+0x1c0>
    800011e4:	00000097          	auipc	ra,0x0
    800011e8:	e1c080e7          	jalr	-484(ra) # 80001000 <_Z11printStringPKc>

    if (ptr2 < ptr1){
    800011ec:	12996c63          	bltu	s2,s1,80001324 <_Z11pokrenitestv+0x248>
        printString("GRESKA PTR2 < PTR1");
        return;
    }

    size_t razlika = (size_t)ptr2-(size_t)ptr1;
    800011f0:	409909b3          	sub	s3,s2,s1
    printString("RASLIKA PTR2 i PTR1 = ");
    800011f4:	00003517          	auipc	a0,0x3
    800011f8:	f1450513          	addi	a0,a0,-236 # 80004108 <CONSOLE_STATUS+0xf8>
    800011fc:	00000097          	auipc	ra,0x0
    80001200:	e04080e7          	jalr	-508(ra) # 80001000 <_Z11printStringPKc>
    printHex(razlika);
    80001204:	00098513          	mv	a0,s3
    80001208:	00000097          	auipc	ra,0x0
    8000120c:	e3c080e7          	jalr	-452(ra) # 80001044 <_Z8printHexm>
    printString("\n");
    80001210:	00003517          	auipc	a0,0x3
    80001214:	fc050513          	addi	a0,a0,-64 # 800041d0 <CONSOLE_STATUS+0x1c0>
    80001218:	00000097          	auipc	ra,0x0
    8000121c:	de8080e7          	jalr	-536(ra) # 80001000 <_Z11printStringPKc>

    printString("TEST 3");
    80001220:	00003517          	auipc	a0,0x3
    80001224:	f0050513          	addi	a0,a0,-256 # 80004120 <CONSOLE_STATUS+0x110>
    80001228:	00000097          	auipc	ra,0x0
    8000122c:	dd8080e7          	jalr	-552(ra) # 80001000 <_Z11printStringPKc>

    char* ptr3 = (char*)MemoryAllocator::mem_alloc(MEM_BLOCK_SIZE*2);
    80001230:	08000513          	li	a0,128
    80001234:	00000097          	auipc	ra,0x0
    80001238:	204080e7          	jalr	516(ra) # 80001438 <_ZN15MemoryAllocator9mem_allocEm>
    8000123c:	00050993          	mv	s3,a0
    if (!ptr3){
    80001240:	10050863          	beqz	a0,80001350 <_Z11pokrenitestv+0x274>
        printString("TRECI MEMALLOC VRATIO NLL");
        return;
    }
    printString("ADRESA PTR3 =");
    80001244:	00003517          	auipc	a0,0x3
    80001248:	f0450513          	addi	a0,a0,-252 # 80004148 <CONSOLE_STATUS+0x138>
    8000124c:	00000097          	auipc	ra,0x0
    80001250:	db4080e7          	jalr	-588(ra) # 80001000 <_Z11printStringPKc>
    printHex((size_t)ptr3);
    80001254:	00098513          	mv	a0,s3
    80001258:	00000097          	auipc	ra,0x0
    8000125c:	dec080e7          	jalr	-532(ra) # 80001044 <_Z8printHexm>
    printString("\n");
    80001260:	00003517          	auipc	a0,0x3
    80001264:	f7050513          	addi	a0,a0,-144 # 800041d0 <CONSOLE_STATUS+0x1c0>
    80001268:	00000097          	auipc	ra,0x0
    8000126c:	d98080e7          	jalr	-616(ra) # 80001000 <_Z11printStringPKc>


    printString("TETS 4");
    80001270:	00003517          	auipc	a0,0x3
    80001274:	ee850513          	addi	a0,a0,-280 # 80004158 <CONSOLE_STATUS+0x148>
    80001278:	00000097          	auipc	ra,0x0
    8000127c:	d88080e7          	jalr	-632(ra) # 80001000 <_Z11printStringPKc>
    if (MemoryAllocator::mem_free(ptr2)){
    80001280:	00090513          	mv	a0,s2
    80001284:	00000097          	auipc	ra,0x0
    80001288:	268080e7          	jalr	616(ra) # 800014ec <_ZN15MemoryAllocator8mem_freeEPv>
    8000128c:	0c051c63          	bnez	a0,80001364 <_Z11pokrenitestv+0x288>
        printString("NEUSPESNO OSLOBODJEN PTR2");
        return;
    }

    if (MemoryAllocator::mem_free(ptr3)){
    80001290:	00098513          	mv	a0,s3
    80001294:	00000097          	auipc	ra,0x0
    80001298:	258080e7          	jalr	600(ra) # 800014ec <_ZN15MemoryAllocator8mem_freeEPv>
    8000129c:	0c051e63          	bnez	a0,80001378 <_Z11pokrenitestv+0x29c>
        printString("NEUSPESNO OSLOBODJEN PTR3");
        return;
    }

    if (MemoryAllocator::mem_free(ptr1)){
    800012a0:	00048513          	mv	a0,s1
    800012a4:	00000097          	auipc	ra,0x0
    800012a8:	248080e7          	jalr	584(ra) # 800014ec <_ZN15MemoryAllocator8mem_freeEPv>
    800012ac:	0e051063          	bnez	a0,8000138c <_Z11pokrenitestv+0x2b0>
        printString("NEUSPESNO OSLOBODJEN PTR1");
        return;
    }

    printString("PROVERA SPAJANJA\n");
    800012b0:	00003517          	auipc	a0,0x3
    800012b4:	f1050513          	addi	a0,a0,-240 # 800041c0 <CONSOLE_STATUS+0x1b0>
    800012b8:	00000097          	auipc	ra,0x0
    800012bc:	d48080e7          	jalr	-696(ra) # 80001000 <_Z11printStringPKc>

    char* provera =(char*)MemoryAllocator::mem_alloc(MEM_BLOCK_SIZE*3);
    800012c0:	0c000513          	li	a0,192
    800012c4:	00000097          	auipc	ra,0x0
    800012c8:	174080e7          	jalr	372(ra) # 80001438 <_ZN15MemoryAllocator9mem_allocEm>
    800012cc:	00050493          	mv	s1,a0

    if (!provera){
    800012d0:	0c050863          	beqz	a0,800013a0 <_Z11pokrenitestv+0x2c4>
        printString("NEUSPELA PROVERA");
        return;
    }

    printString("ADRWSA PROVERE = ");
    800012d4:	00003517          	auipc	a0,0x3
    800012d8:	f1c50513          	addi	a0,a0,-228 # 800041f0 <CONSOLE_STATUS+0x1e0>
    800012dc:	00000097          	auipc	ra,0x0
    800012e0:	d24080e7          	jalr	-732(ra) # 80001000 <_Z11printStringPKc>
    printHex((size_t)provera);
    800012e4:	00048513          	mv	a0,s1
    800012e8:	00000097          	auipc	ra,0x0
    800012ec:	d5c080e7          	jalr	-676(ra) # 80001044 <_Z8printHexm>
    printString("\n");
    800012f0:	00003517          	auipc	a0,0x3
    800012f4:	ee050513          	addi	a0,a0,-288 # 800041d0 <CONSOLE_STATUS+0x1c0>
    800012f8:	00000097          	auipc	ra,0x0
    800012fc:	d08080e7          	jalr	-760(ra) # 80001000 <_Z11printStringPKc>

    MemoryAllocator::mem_free(provera);
    80001300:	00048513          	mv	a0,s1
    80001304:	00000097          	auipc	ra,0x0
    80001308:	1e8080e7          	jalr	488(ra) # 800014ec <_ZN15MemoryAllocator8mem_freeEPv>
    8000130c:	0280006f          	j	80001334 <_Z11pokrenitestv+0x258>
        printString("DRUGI MEMALPC VRATIO NULL");
    80001310:	00003517          	auipc	a0,0x3
    80001314:	db050513          	addi	a0,a0,-592 # 800040c0 <CONSOLE_STATUS+0xb0>
    80001318:	00000097          	auipc	ra,0x0
    8000131c:	ce8080e7          	jalr	-792(ra) # 80001000 <_Z11printStringPKc>
        return;
    80001320:	0140006f          	j	80001334 <_Z11pokrenitestv+0x258>
        printString("GRESKA PTR2 < PTR1");
    80001324:	00003517          	auipc	a0,0x3
    80001328:	dcc50513          	addi	a0,a0,-564 # 800040f0 <CONSOLE_STATUS+0xe0>
    8000132c:	00000097          	auipc	ra,0x0
    80001330:	cd4080e7          	jalr	-812(ra) # 80001000 <_Z11printStringPKc>
}
    80001334:	02813083          	ld	ra,40(sp)
    80001338:	02013403          	ld	s0,32(sp)
    8000133c:	01813483          	ld	s1,24(sp)
    80001340:	01013903          	ld	s2,16(sp)
    80001344:	00813983          	ld	s3,8(sp)
    80001348:	03010113          	addi	sp,sp,48
    8000134c:	00008067          	ret
        printString("TRECI MEMALLOC VRATIO NLL");
    80001350:	00003517          	auipc	a0,0x3
    80001354:	dd850513          	addi	a0,a0,-552 # 80004128 <CONSOLE_STATUS+0x118>
    80001358:	00000097          	auipc	ra,0x0
    8000135c:	ca8080e7          	jalr	-856(ra) # 80001000 <_Z11printStringPKc>
        return;
    80001360:	fd5ff06f          	j	80001334 <_Z11pokrenitestv+0x258>
        printString("NEUSPESNO OSLOBODJEN PTR2");
    80001364:	00003517          	auipc	a0,0x3
    80001368:	dfc50513          	addi	a0,a0,-516 # 80004160 <CONSOLE_STATUS+0x150>
    8000136c:	00000097          	auipc	ra,0x0
    80001370:	c94080e7          	jalr	-876(ra) # 80001000 <_Z11printStringPKc>
        return;
    80001374:	fc1ff06f          	j	80001334 <_Z11pokrenitestv+0x258>
        printString("NEUSPESNO OSLOBODJEN PTR3");
    80001378:	00003517          	auipc	a0,0x3
    8000137c:	e0850513          	addi	a0,a0,-504 # 80004180 <CONSOLE_STATUS+0x170>
    80001380:	00000097          	auipc	ra,0x0
    80001384:	c80080e7          	jalr	-896(ra) # 80001000 <_Z11printStringPKc>
        return;
    80001388:	fadff06f          	j	80001334 <_Z11pokrenitestv+0x258>
        printString("NEUSPESNO OSLOBODJEN PTR1");
    8000138c:	00003517          	auipc	a0,0x3
    80001390:	e1450513          	addi	a0,a0,-492 # 800041a0 <CONSOLE_STATUS+0x190>
    80001394:	00000097          	auipc	ra,0x0
    80001398:	c6c080e7          	jalr	-916(ra) # 80001000 <_Z11printStringPKc>
        return;
    8000139c:	f99ff06f          	j	80001334 <_Z11pokrenitestv+0x258>
        printString("NEUSPELA PROVERA");
    800013a0:	00003517          	auipc	a0,0x3
    800013a4:	e3850513          	addi	a0,a0,-456 # 800041d8 <CONSOLE_STATUS+0x1c8>
    800013a8:	00000097          	auipc	ra,0x0
    800013ac:	c58080e7          	jalr	-936(ra) # 80001000 <_Z11printStringPKc>
        return;
    800013b0:	f85ff06f          	j	80001334 <_Z11pokrenitestv+0x258>

00000000800013b4 <main>:

void main(){
    800013b4:	ff010113          	addi	sp,sp,-16
    800013b8:	00113423          	sd	ra,8(sp)
    800013bc:	00813023          	sd	s0,0(sp)
    800013c0:	01010413          	addi	s0,sp,16
    MemoryAllocator::init();
    800013c4:	00000097          	auipc	ra,0x0
    800013c8:	014080e7          	jalr	20(ra) # 800013d8 <_ZN15MemoryAllocator4initEv>
    pokrenitest();
    800013cc:	00000097          	auipc	ra,0x0
    800013d0:	d10080e7          	jalr	-752(ra) # 800010dc <_Z11pokrenitestv>

    while(true){}
    800013d4:	0000006f          	j	800013d4 <main+0x20>

00000000800013d8 <_ZN15MemoryAllocator4initEv>:
#include "../h/MemoryAllocator.hpp"


FreeMemBlock* MemoryAllocator::free_mem_head = nullptr;

void MemoryAllocator::init() {
    800013d8:	ff010113          	addi	sp,sp,-16
    800013dc:	00813423          	sd	s0,8(sp)
    800013e0:	01010413          	addi	s0,sp,16
    static bool is_initialised = false;

    if (is_initialised) return;
    800013e4:	00003797          	auipc	a5,0x3
    800013e8:	1cc7c783          	lbu	a5,460(a5) # 800045b0 <_ZZN15MemoryAllocator4initEvE14is_initialised>
    800013ec:	04079063          	bnez	a5,8000142c <_ZN15MemoryAllocator4initEv+0x54>

    free_mem_head = (FreeMemBlock*)HEAP_START_ADDR;
    800013f0:	00003797          	auipc	a5,0x3
    800013f4:	1687b783          	ld	a5,360(a5) # 80004558 <_GLOBAL_OFFSET_TABLE_+0x8>
    800013f8:	0007b703          	ld	a4,0(a5)
    800013fc:	00003697          	auipc	a3,0x3
    80001400:	1b468693          	addi	a3,a3,436 # 800045b0 <_ZZN15MemoryAllocator4initEvE14is_initialised>
    80001404:	00e6b423          	sd	a4,8(a3)
    size_t total_bytes = (char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR;
    80001408:	00003797          	auipc	a5,0x3
    8000140c:	1607b783          	ld	a5,352(a5) # 80004568 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001410:	0007b783          	ld	a5,0(a5)
    80001414:	40e787b3          	sub	a5,a5,a4
    free_mem_head->next = nullptr;
    80001418:	00073423          	sd	zero,8(a4)
    free_mem_head->size = total_bytes/MEM_BLOCK_SIZE;
    8000141c:	0067d793          	srli	a5,a5,0x6
    80001420:	00f73023          	sd	a5,0(a4)
    is_initialised = true;
    80001424:	00100793          	li	a5,1
    80001428:	00f68023          	sb	a5,0(a3)
}
    8000142c:	00813403          	ld	s0,8(sp)
    80001430:	01010113          	addi	sp,sp,16
    80001434:	00008067          	ret

0000000080001438 <_ZN15MemoryAllocator9mem_allocEm>:

void* MemoryAllocator::mem_alloc(size_t size) {
    80001438:	ff010113          	addi	sp,sp,-16
    8000143c:	00813423          	sd	s0,8(sp)
    80001440:	01010413          	addi	s0,sp,16
    if (size == 0) return nullptr;
    80001444:	0a050063          	beqz	a0,800014e4 <_ZN15MemoryAllocator9mem_allocEm+0xac>
    80001448:	00050793          	mv	a5,a0
    FreeMemBlock* curr = free_mem_head;
    8000144c:	00003517          	auipc	a0,0x3
    80001450:	16c53503          	ld	a0,364(a0) # 800045b8 <_ZN15MemoryAllocator13free_mem_headE>
    FreeMemBlock* prev = nullptr;

    size_t size_in_blocks = (size + sizeof(FreeMemBlock) + MEM_BLOCK_SIZE -1)/MEM_BLOCK_SIZE;
    80001454:	04f78693          	addi	a3,a5,79
    80001458:	0066d713          	srli	a4,a3,0x6
    FreeMemBlock* prev = nullptr;
    8000145c:	00000613          	li	a2,0

    while (curr){
    80001460:	00050c63          	beqz	a0,80001478 <_ZN15MemoryAllocator9mem_allocEm+0x40>
        if (curr->size >= size_in_blocks){
    80001464:	00053783          	ld	a5,0(a0)
    80001468:	00e7f863          	bgeu	a5,a4,80001478 <_ZN15MemoryAllocator9mem_allocEm+0x40>
            break;
        }
        prev = curr;
    8000146c:	00050613          	mv	a2,a0
        curr = curr->next;
    80001470:	00853503          	ld	a0,8(a0)
    while (curr){
    80001474:	fedff06f          	j	80001460 <_ZN15MemoryAllocator9mem_allocEm+0x28>
    }

    if (!curr) return nullptr;
    80001478:	02050a63          	beqz	a0,800014ac <_ZN15MemoryAllocator9mem_allocEm+0x74>

    if (curr->size > size_in_blocks){
    8000147c:	00053583          	ld	a1,0(a0)
    80001480:	04b77263          	bgeu	a4,a1,800014c4 <_ZN15MemoryAllocator9mem_allocEm+0x8c>
        FreeMemBlock *remainder = (FreeMemBlock*)((char*)curr + size_in_blocks*MEM_BLOCK_SIZE);
    80001484:	fc06f793          	andi	a5,a3,-64
    80001488:	00f507b3          	add	a5,a0,a5
        remainder->size = curr->size - size_in_blocks;
    8000148c:	40e58733          	sub	a4,a1,a4
    80001490:	00e7b023          	sd	a4,0(a5)
        remainder->next = curr->next;
    80001494:	00853703          	ld	a4,8(a0)
    80001498:	00e7b423          	sd	a4,8(a5)

        if (prev){
    8000149c:	00060e63          	beqz	a2,800014b8 <_ZN15MemoryAllocator9mem_allocEm+0x80>
            prev->next = remainder;
    800014a0:	00f63423          	sd	a5,8(a2)
        }else{
            free_mem_head = curr->next;
        }
    }

    curr->next = nullptr;
    800014a4:	00053423          	sd	zero,8(a0)
    return (char*)curr+sizeof(FreeMemBlock);
    800014a8:	01050513          	addi	a0,a0,16
}
    800014ac:	00813403          	ld	s0,8(sp)
    800014b0:	01010113          	addi	sp,sp,16
    800014b4:	00008067          	ret
            free_mem_head = remainder;
    800014b8:	00003717          	auipc	a4,0x3
    800014bc:	10f73023          	sd	a5,256(a4) # 800045b8 <_ZN15MemoryAllocator13free_mem_headE>
    800014c0:	fe5ff06f          	j	800014a4 <_ZN15MemoryAllocator9mem_allocEm+0x6c>
        if (prev){
    800014c4:	00060863          	beqz	a2,800014d4 <_ZN15MemoryAllocator9mem_allocEm+0x9c>
            prev->next = curr->next;
    800014c8:	00853783          	ld	a5,8(a0)
    800014cc:	00f63423          	sd	a5,8(a2)
    800014d0:	fd5ff06f          	j	800014a4 <_ZN15MemoryAllocator9mem_allocEm+0x6c>
            free_mem_head = curr->next;
    800014d4:	00853783          	ld	a5,8(a0)
    800014d8:	00003717          	auipc	a4,0x3
    800014dc:	0ef73023          	sd	a5,224(a4) # 800045b8 <_ZN15MemoryAllocator13free_mem_headE>
    800014e0:	fc5ff06f          	j	800014a4 <_ZN15MemoryAllocator9mem_allocEm+0x6c>
    if (size == 0) return nullptr;
    800014e4:	00000513          	li	a0,0
    800014e8:	fc5ff06f          	j	800014ac <_ZN15MemoryAllocator9mem_allocEm+0x74>

00000000800014ec <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *ptr) {
    800014ec:	ff010113          	addi	sp,sp,-16
    800014f0:	00813423          	sd	s0,8(sp)
    800014f4:	01010413          	addi	s0,sp,16
    if (!ptr) return 0;
    800014f8:	0a050a63          	beqz	a0,800015ac <_ZN15MemoryAllocator8mem_freeEPv+0xc0>

    FreeMemBlock* blk = (FreeMemBlock*)((char*)ptr - sizeof(FreeMemBlock));
    800014fc:	ff050693          	addi	a3,a0,-16

    if (blk->next != nullptr){
    80001500:	ff853703          	ld	a4,-8(a0)
    80001504:	0a071863          	bnez	a4,800015b4 <_ZN15MemoryAllocator8mem_freeEPv+0xc8>
        return -2;
    }

    FreeMemBlock* curr = free_mem_head;
    80001508:	00003797          	auipc	a5,0x3
    8000150c:	0b07b783          	ld	a5,176(a5) # 800045b8 <_ZN15MemoryAllocator13free_mem_headE>
    FreeMemBlock* prev = nullptr;
    80001510:	00c0006f          	j	8000151c <_ZN15MemoryAllocator8mem_freeEPv+0x30>

    while (curr != nullptr && curr < blk){
        prev = curr;
    80001514:	00078713          	mv	a4,a5
        curr = curr->next;
    80001518:	0087b783          	ld	a5,8(a5)
    while (curr != nullptr && curr < blk){
    8000151c:	00078463          	beqz	a5,80001524 <_ZN15MemoryAllocator8mem_freeEPv+0x38>
    80001520:	fed7eae3          	bltu	a5,a3,80001514 <_ZN15MemoryAllocator8mem_freeEPv+0x28>
    }


    if (curr && ((char*)blk + blk->size*MEM_BLOCK_SIZE)== (char*)curr){
    80001524:	00078a63          	beqz	a5,80001538 <_ZN15MemoryAllocator8mem_freeEPv+0x4c>
    80001528:	ff053583          	ld	a1,-16(a0)
    8000152c:	00659613          	slli	a2,a1,0x6
    80001530:	00c68633          	add	a2,a3,a2
    80001534:	02f60a63          	beq	a2,a5,80001568 <_ZN15MemoryAllocator8mem_freeEPv+0x7c>
        blk->next = curr->next;
        blk->size +=curr->size;
    }else{
        blk->next = curr;
    80001538:	fef53c23          	sd	a5,-8(a0)
    }

    if (prev && ((char*)prev + prev->size*MEM_BLOCK_SIZE)== (char*)blk){
    8000153c:	00070a63          	beqz	a4,80001550 <_ZN15MemoryAllocator8mem_freeEPv+0x64>
    80001540:	00073603          	ld	a2,0(a4)
    80001544:	00661793          	slli	a5,a2,0x6
    80001548:	00f707b3          	add	a5,a4,a5
    8000154c:	02d78a63          	beq	a5,a3,80001580 <_ZN15MemoryAllocator8mem_freeEPv+0x94>
        prev->size +=blk->size;
        prev->next = blk->next;
    }else{
        if (prev){
    80001550:	04070663          	beqz	a4,8000159c <_ZN15MemoryAllocator8mem_freeEPv+0xb0>
            prev->next = blk;
    80001554:	00d73423          	sd	a3,8(a4)
        } else{
            free_mem_head = blk;
        }
    }

    return 0;
    80001558:	00000513          	li	a0,0
}
    8000155c:	00813403          	ld	s0,8(sp)
    80001560:	01010113          	addi	sp,sp,16
    80001564:	00008067          	ret
        blk->next = curr->next;
    80001568:	0087b603          	ld	a2,8(a5)
    8000156c:	fec53c23          	sd	a2,-8(a0)
        blk->size +=curr->size;
    80001570:	0007b783          	ld	a5,0(a5)
    80001574:	00f585b3          	add	a1,a1,a5
    80001578:	feb53823          	sd	a1,-16(a0)
    8000157c:	fc1ff06f          	j	8000153c <_ZN15MemoryAllocator8mem_freeEPv+0x50>
        prev->size +=blk->size;
    80001580:	ff053783          	ld	a5,-16(a0)
    80001584:	00f60633          	add	a2,a2,a5
    80001588:	00c73023          	sd	a2,0(a4)
        prev->next = blk->next;
    8000158c:	ff853783          	ld	a5,-8(a0)
    80001590:	00f73423          	sd	a5,8(a4)
    return 0;
    80001594:	00000513          	li	a0,0
        prev->next = blk->next;
    80001598:	fc5ff06f          	j	8000155c <_ZN15MemoryAllocator8mem_freeEPv+0x70>
            free_mem_head = blk;
    8000159c:	00003797          	auipc	a5,0x3
    800015a0:	00d7be23          	sd	a3,28(a5) # 800045b8 <_ZN15MemoryAllocator13free_mem_headE>
    return 0;
    800015a4:	00000513          	li	a0,0
    800015a8:	fb5ff06f          	j	8000155c <_ZN15MemoryAllocator8mem_freeEPv+0x70>
    if (!ptr) return 0;
    800015ac:	00000513          	li	a0,0
    800015b0:	fadff06f          	j	8000155c <_ZN15MemoryAllocator8mem_freeEPv+0x70>
        return -2;
    800015b4:	ffe00513          	li	a0,-2
    800015b8:	fa5ff06f          	j	8000155c <_ZN15MemoryAllocator8mem_freeEPv+0x70>

00000000800015bc <start>:
    800015bc:	ff010113          	addi	sp,sp,-16
    800015c0:	00813423          	sd	s0,8(sp)
    800015c4:	01010413          	addi	s0,sp,16
    800015c8:	300027f3          	csrr	a5,mstatus
    800015cc:	ffffe737          	lui	a4,0xffffe
    800015d0:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff8fef>
    800015d4:	00e7f7b3          	and	a5,a5,a4
    800015d8:	00001737          	lui	a4,0x1
    800015dc:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800015e0:	00e7e7b3          	or	a5,a5,a4
    800015e4:	30079073          	csrw	mstatus,a5
    800015e8:	00000797          	auipc	a5,0x0
    800015ec:	16078793          	addi	a5,a5,352 # 80001748 <system_main>
    800015f0:	34179073          	csrw	mepc,a5
    800015f4:	00000793          	li	a5,0
    800015f8:	18079073          	csrw	satp,a5
    800015fc:	000107b7          	lui	a5,0x10
    80001600:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001604:	30279073          	csrw	medeleg,a5
    80001608:	30379073          	csrw	mideleg,a5
    8000160c:	104027f3          	csrr	a5,sie
    80001610:	2227e793          	ori	a5,a5,546
    80001614:	10479073          	csrw	sie,a5
    80001618:	fff00793          	li	a5,-1
    8000161c:	00a7d793          	srli	a5,a5,0xa
    80001620:	3b079073          	csrw	pmpaddr0,a5
    80001624:	00f00793          	li	a5,15
    80001628:	3a079073          	csrw	pmpcfg0,a5
    8000162c:	f14027f3          	csrr	a5,mhartid
    80001630:	0200c737          	lui	a4,0x200c
    80001634:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001638:	0007869b          	sext.w	a3,a5
    8000163c:	00269713          	slli	a4,a3,0x2
    80001640:	000f4637          	lui	a2,0xf4
    80001644:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001648:	00d70733          	add	a4,a4,a3
    8000164c:	0037979b          	slliw	a5,a5,0x3
    80001650:	020046b7          	lui	a3,0x2004
    80001654:	00d787b3          	add	a5,a5,a3
    80001658:	00c585b3          	add	a1,a1,a2
    8000165c:	00371693          	slli	a3,a4,0x3
    80001660:	00003717          	auipc	a4,0x3
    80001664:	f6070713          	addi	a4,a4,-160 # 800045c0 <timer_scratch>
    80001668:	00b7b023          	sd	a1,0(a5)
    8000166c:	00d70733          	add	a4,a4,a3
    80001670:	00f73c23          	sd	a5,24(a4)
    80001674:	02c73023          	sd	a2,32(a4)
    80001678:	34071073          	csrw	mscratch,a4
    8000167c:	00000797          	auipc	a5,0x0
    80001680:	6e478793          	addi	a5,a5,1764 # 80001d60 <timervec>
    80001684:	30579073          	csrw	mtvec,a5
    80001688:	300027f3          	csrr	a5,mstatus
    8000168c:	0087e793          	ori	a5,a5,8
    80001690:	30079073          	csrw	mstatus,a5
    80001694:	304027f3          	csrr	a5,mie
    80001698:	0807e793          	ori	a5,a5,128
    8000169c:	30479073          	csrw	mie,a5
    800016a0:	f14027f3          	csrr	a5,mhartid
    800016a4:	0007879b          	sext.w	a5,a5
    800016a8:	00078213          	mv	tp,a5
    800016ac:	30200073          	mret
    800016b0:	00813403          	ld	s0,8(sp)
    800016b4:	01010113          	addi	sp,sp,16
    800016b8:	00008067          	ret

00000000800016bc <timerinit>:
    800016bc:	ff010113          	addi	sp,sp,-16
    800016c0:	00813423          	sd	s0,8(sp)
    800016c4:	01010413          	addi	s0,sp,16
    800016c8:	f14027f3          	csrr	a5,mhartid
    800016cc:	0200c737          	lui	a4,0x200c
    800016d0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800016d4:	0007869b          	sext.w	a3,a5
    800016d8:	00269713          	slli	a4,a3,0x2
    800016dc:	000f4637          	lui	a2,0xf4
    800016e0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800016e4:	00d70733          	add	a4,a4,a3
    800016e8:	0037979b          	slliw	a5,a5,0x3
    800016ec:	020046b7          	lui	a3,0x2004
    800016f0:	00d787b3          	add	a5,a5,a3
    800016f4:	00c585b3          	add	a1,a1,a2
    800016f8:	00371693          	slli	a3,a4,0x3
    800016fc:	00003717          	auipc	a4,0x3
    80001700:	ec470713          	addi	a4,a4,-316 # 800045c0 <timer_scratch>
    80001704:	00b7b023          	sd	a1,0(a5)
    80001708:	00d70733          	add	a4,a4,a3
    8000170c:	00f73c23          	sd	a5,24(a4)
    80001710:	02c73023          	sd	a2,32(a4)
    80001714:	34071073          	csrw	mscratch,a4
    80001718:	00000797          	auipc	a5,0x0
    8000171c:	64878793          	addi	a5,a5,1608 # 80001d60 <timervec>
    80001720:	30579073          	csrw	mtvec,a5
    80001724:	300027f3          	csrr	a5,mstatus
    80001728:	0087e793          	ori	a5,a5,8
    8000172c:	30079073          	csrw	mstatus,a5
    80001730:	304027f3          	csrr	a5,mie
    80001734:	0807e793          	ori	a5,a5,128
    80001738:	30479073          	csrw	mie,a5
    8000173c:	00813403          	ld	s0,8(sp)
    80001740:	01010113          	addi	sp,sp,16
    80001744:	00008067          	ret

0000000080001748 <system_main>:
    80001748:	fe010113          	addi	sp,sp,-32
    8000174c:	00813823          	sd	s0,16(sp)
    80001750:	00913423          	sd	s1,8(sp)
    80001754:	00113c23          	sd	ra,24(sp)
    80001758:	02010413          	addi	s0,sp,32
    8000175c:	00000097          	auipc	ra,0x0
    80001760:	0c4080e7          	jalr	196(ra) # 80001820 <cpuid>
    80001764:	00003497          	auipc	s1,0x3
    80001768:	e1c48493          	addi	s1,s1,-484 # 80004580 <started>
    8000176c:	02050263          	beqz	a0,80001790 <system_main+0x48>
    80001770:	0004a783          	lw	a5,0(s1)
    80001774:	0007879b          	sext.w	a5,a5
    80001778:	fe078ce3          	beqz	a5,80001770 <system_main+0x28>
    8000177c:	0ff0000f          	fence
    80001780:	00003517          	auipc	a0,0x3
    80001784:	ab850513          	addi	a0,a0,-1352 # 80004238 <CONSOLE_STATUS+0x228>
    80001788:	00001097          	auipc	ra,0x1
    8000178c:	a74080e7          	jalr	-1420(ra) # 800021fc <panic>
    80001790:	00001097          	auipc	ra,0x1
    80001794:	9c8080e7          	jalr	-1592(ra) # 80002158 <consoleinit>
    80001798:	00001097          	auipc	ra,0x1
    8000179c:	154080e7          	jalr	340(ra) # 800028ec <printfinit>
    800017a0:	00003517          	auipc	a0,0x3
    800017a4:	a3050513          	addi	a0,a0,-1488 # 800041d0 <CONSOLE_STATUS+0x1c0>
    800017a8:	00001097          	auipc	ra,0x1
    800017ac:	ab0080e7          	jalr	-1360(ra) # 80002258 <__printf>
    800017b0:	00003517          	auipc	a0,0x3
    800017b4:	a5850513          	addi	a0,a0,-1448 # 80004208 <CONSOLE_STATUS+0x1f8>
    800017b8:	00001097          	auipc	ra,0x1
    800017bc:	aa0080e7          	jalr	-1376(ra) # 80002258 <__printf>
    800017c0:	00003517          	auipc	a0,0x3
    800017c4:	a1050513          	addi	a0,a0,-1520 # 800041d0 <CONSOLE_STATUS+0x1c0>
    800017c8:	00001097          	auipc	ra,0x1
    800017cc:	a90080e7          	jalr	-1392(ra) # 80002258 <__printf>
    800017d0:	00001097          	auipc	ra,0x1
    800017d4:	4a8080e7          	jalr	1192(ra) # 80002c78 <kinit>
    800017d8:	00000097          	auipc	ra,0x0
    800017dc:	148080e7          	jalr	328(ra) # 80001920 <trapinit>
    800017e0:	00000097          	auipc	ra,0x0
    800017e4:	16c080e7          	jalr	364(ra) # 8000194c <trapinithart>
    800017e8:	00000097          	auipc	ra,0x0
    800017ec:	5b8080e7          	jalr	1464(ra) # 80001da0 <plicinit>
    800017f0:	00000097          	auipc	ra,0x0
    800017f4:	5d8080e7          	jalr	1496(ra) # 80001dc8 <plicinithart>
    800017f8:	00000097          	auipc	ra,0x0
    800017fc:	078080e7          	jalr	120(ra) # 80001870 <userinit>
    80001800:	0ff0000f          	fence
    80001804:	00100793          	li	a5,1
    80001808:	00003517          	auipc	a0,0x3
    8000180c:	a1850513          	addi	a0,a0,-1512 # 80004220 <CONSOLE_STATUS+0x210>
    80001810:	00f4a023          	sw	a5,0(s1)
    80001814:	00001097          	auipc	ra,0x1
    80001818:	a44080e7          	jalr	-1468(ra) # 80002258 <__printf>
    8000181c:	0000006f          	j	8000181c <system_main+0xd4>

0000000080001820 <cpuid>:
    80001820:	ff010113          	addi	sp,sp,-16
    80001824:	00813423          	sd	s0,8(sp)
    80001828:	01010413          	addi	s0,sp,16
    8000182c:	00020513          	mv	a0,tp
    80001830:	00813403          	ld	s0,8(sp)
    80001834:	0005051b          	sext.w	a0,a0
    80001838:	01010113          	addi	sp,sp,16
    8000183c:	00008067          	ret

0000000080001840 <mycpu>:
    80001840:	ff010113          	addi	sp,sp,-16
    80001844:	00813423          	sd	s0,8(sp)
    80001848:	01010413          	addi	s0,sp,16
    8000184c:	00020793          	mv	a5,tp
    80001850:	00813403          	ld	s0,8(sp)
    80001854:	0007879b          	sext.w	a5,a5
    80001858:	00779793          	slli	a5,a5,0x7
    8000185c:	00004517          	auipc	a0,0x4
    80001860:	d9450513          	addi	a0,a0,-620 # 800055f0 <cpus>
    80001864:	00f50533          	add	a0,a0,a5
    80001868:	01010113          	addi	sp,sp,16
    8000186c:	00008067          	ret

0000000080001870 <userinit>:
    80001870:	ff010113          	addi	sp,sp,-16
    80001874:	00813423          	sd	s0,8(sp)
    80001878:	01010413          	addi	s0,sp,16
    8000187c:	00813403          	ld	s0,8(sp)
    80001880:	01010113          	addi	sp,sp,16
    80001884:	00000317          	auipc	t1,0x0
    80001888:	b3030067          	jr	-1232(t1) # 800013b4 <main>

000000008000188c <either_copyout>:
    8000188c:	ff010113          	addi	sp,sp,-16
    80001890:	00813023          	sd	s0,0(sp)
    80001894:	00113423          	sd	ra,8(sp)
    80001898:	01010413          	addi	s0,sp,16
    8000189c:	02051663          	bnez	a0,800018c8 <either_copyout+0x3c>
    800018a0:	00058513          	mv	a0,a1
    800018a4:	00060593          	mv	a1,a2
    800018a8:	0006861b          	sext.w	a2,a3
    800018ac:	00002097          	auipc	ra,0x2
    800018b0:	c58080e7          	jalr	-936(ra) # 80003504 <__memmove>
    800018b4:	00813083          	ld	ra,8(sp)
    800018b8:	00013403          	ld	s0,0(sp)
    800018bc:	00000513          	li	a0,0
    800018c0:	01010113          	addi	sp,sp,16
    800018c4:	00008067          	ret
    800018c8:	00003517          	auipc	a0,0x3
    800018cc:	99850513          	addi	a0,a0,-1640 # 80004260 <CONSOLE_STATUS+0x250>
    800018d0:	00001097          	auipc	ra,0x1
    800018d4:	92c080e7          	jalr	-1748(ra) # 800021fc <panic>

00000000800018d8 <either_copyin>:
    800018d8:	ff010113          	addi	sp,sp,-16
    800018dc:	00813023          	sd	s0,0(sp)
    800018e0:	00113423          	sd	ra,8(sp)
    800018e4:	01010413          	addi	s0,sp,16
    800018e8:	02059463          	bnez	a1,80001910 <either_copyin+0x38>
    800018ec:	00060593          	mv	a1,a2
    800018f0:	0006861b          	sext.w	a2,a3
    800018f4:	00002097          	auipc	ra,0x2
    800018f8:	c10080e7          	jalr	-1008(ra) # 80003504 <__memmove>
    800018fc:	00813083          	ld	ra,8(sp)
    80001900:	00013403          	ld	s0,0(sp)
    80001904:	00000513          	li	a0,0
    80001908:	01010113          	addi	sp,sp,16
    8000190c:	00008067          	ret
    80001910:	00003517          	auipc	a0,0x3
    80001914:	97850513          	addi	a0,a0,-1672 # 80004288 <CONSOLE_STATUS+0x278>
    80001918:	00001097          	auipc	ra,0x1
    8000191c:	8e4080e7          	jalr	-1820(ra) # 800021fc <panic>

0000000080001920 <trapinit>:
    80001920:	ff010113          	addi	sp,sp,-16
    80001924:	00813423          	sd	s0,8(sp)
    80001928:	01010413          	addi	s0,sp,16
    8000192c:	00813403          	ld	s0,8(sp)
    80001930:	00003597          	auipc	a1,0x3
    80001934:	98058593          	addi	a1,a1,-1664 # 800042b0 <CONSOLE_STATUS+0x2a0>
    80001938:	00004517          	auipc	a0,0x4
    8000193c:	d3850513          	addi	a0,a0,-712 # 80005670 <tickslock>
    80001940:	01010113          	addi	sp,sp,16
    80001944:	00001317          	auipc	t1,0x1
    80001948:	5c430067          	jr	1476(t1) # 80002f08 <initlock>

000000008000194c <trapinithart>:
    8000194c:	ff010113          	addi	sp,sp,-16
    80001950:	00813423          	sd	s0,8(sp)
    80001954:	01010413          	addi	s0,sp,16
    80001958:	00000797          	auipc	a5,0x0
    8000195c:	2f878793          	addi	a5,a5,760 # 80001c50 <kernelvec>
    80001960:	10579073          	csrw	stvec,a5
    80001964:	00813403          	ld	s0,8(sp)
    80001968:	01010113          	addi	sp,sp,16
    8000196c:	00008067          	ret

0000000080001970 <usertrap>:
    80001970:	ff010113          	addi	sp,sp,-16
    80001974:	00813423          	sd	s0,8(sp)
    80001978:	01010413          	addi	s0,sp,16
    8000197c:	00813403          	ld	s0,8(sp)
    80001980:	01010113          	addi	sp,sp,16
    80001984:	00008067          	ret

0000000080001988 <usertrapret>:
    80001988:	ff010113          	addi	sp,sp,-16
    8000198c:	00813423          	sd	s0,8(sp)
    80001990:	01010413          	addi	s0,sp,16
    80001994:	00813403          	ld	s0,8(sp)
    80001998:	01010113          	addi	sp,sp,16
    8000199c:	00008067          	ret

00000000800019a0 <kerneltrap>:
    800019a0:	fe010113          	addi	sp,sp,-32
    800019a4:	00813823          	sd	s0,16(sp)
    800019a8:	00113c23          	sd	ra,24(sp)
    800019ac:	00913423          	sd	s1,8(sp)
    800019b0:	02010413          	addi	s0,sp,32
    800019b4:	142025f3          	csrr	a1,scause
    800019b8:	100027f3          	csrr	a5,sstatus
    800019bc:	0027f793          	andi	a5,a5,2
    800019c0:	10079c63          	bnez	a5,80001ad8 <kerneltrap+0x138>
    800019c4:	142027f3          	csrr	a5,scause
    800019c8:	0207ce63          	bltz	a5,80001a04 <kerneltrap+0x64>
    800019cc:	00003517          	auipc	a0,0x3
    800019d0:	92c50513          	addi	a0,a0,-1748 # 800042f8 <CONSOLE_STATUS+0x2e8>
    800019d4:	00001097          	auipc	ra,0x1
    800019d8:	884080e7          	jalr	-1916(ra) # 80002258 <__printf>
    800019dc:	141025f3          	csrr	a1,sepc
    800019e0:	14302673          	csrr	a2,stval
    800019e4:	00003517          	auipc	a0,0x3
    800019e8:	92450513          	addi	a0,a0,-1756 # 80004308 <CONSOLE_STATUS+0x2f8>
    800019ec:	00001097          	auipc	ra,0x1
    800019f0:	86c080e7          	jalr	-1940(ra) # 80002258 <__printf>
    800019f4:	00003517          	auipc	a0,0x3
    800019f8:	92c50513          	addi	a0,a0,-1748 # 80004320 <CONSOLE_STATUS+0x310>
    800019fc:	00001097          	auipc	ra,0x1
    80001a00:	800080e7          	jalr	-2048(ra) # 800021fc <panic>
    80001a04:	0ff7f713          	andi	a4,a5,255
    80001a08:	00900693          	li	a3,9
    80001a0c:	04d70063          	beq	a4,a3,80001a4c <kerneltrap+0xac>
    80001a10:	fff00713          	li	a4,-1
    80001a14:	03f71713          	slli	a4,a4,0x3f
    80001a18:	00170713          	addi	a4,a4,1
    80001a1c:	fae798e3          	bne	a5,a4,800019cc <kerneltrap+0x2c>
    80001a20:	00000097          	auipc	ra,0x0
    80001a24:	e00080e7          	jalr	-512(ra) # 80001820 <cpuid>
    80001a28:	06050663          	beqz	a0,80001a94 <kerneltrap+0xf4>
    80001a2c:	144027f3          	csrr	a5,sip
    80001a30:	ffd7f793          	andi	a5,a5,-3
    80001a34:	14479073          	csrw	sip,a5
    80001a38:	01813083          	ld	ra,24(sp)
    80001a3c:	01013403          	ld	s0,16(sp)
    80001a40:	00813483          	ld	s1,8(sp)
    80001a44:	02010113          	addi	sp,sp,32
    80001a48:	00008067          	ret
    80001a4c:	00000097          	auipc	ra,0x0
    80001a50:	3c8080e7          	jalr	968(ra) # 80001e14 <plic_claim>
    80001a54:	00a00793          	li	a5,10
    80001a58:	00050493          	mv	s1,a0
    80001a5c:	06f50863          	beq	a0,a5,80001acc <kerneltrap+0x12c>
    80001a60:	fc050ce3          	beqz	a0,80001a38 <kerneltrap+0x98>
    80001a64:	00050593          	mv	a1,a0
    80001a68:	00003517          	auipc	a0,0x3
    80001a6c:	87050513          	addi	a0,a0,-1936 # 800042d8 <CONSOLE_STATUS+0x2c8>
    80001a70:	00000097          	auipc	ra,0x0
    80001a74:	7e8080e7          	jalr	2024(ra) # 80002258 <__printf>
    80001a78:	01013403          	ld	s0,16(sp)
    80001a7c:	01813083          	ld	ra,24(sp)
    80001a80:	00048513          	mv	a0,s1
    80001a84:	00813483          	ld	s1,8(sp)
    80001a88:	02010113          	addi	sp,sp,32
    80001a8c:	00000317          	auipc	t1,0x0
    80001a90:	3c030067          	jr	960(t1) # 80001e4c <plic_complete>
    80001a94:	00004517          	auipc	a0,0x4
    80001a98:	bdc50513          	addi	a0,a0,-1060 # 80005670 <tickslock>
    80001a9c:	00001097          	auipc	ra,0x1
    80001aa0:	490080e7          	jalr	1168(ra) # 80002f2c <acquire>
    80001aa4:	00003717          	auipc	a4,0x3
    80001aa8:	ae070713          	addi	a4,a4,-1312 # 80004584 <ticks>
    80001aac:	00072783          	lw	a5,0(a4)
    80001ab0:	00004517          	auipc	a0,0x4
    80001ab4:	bc050513          	addi	a0,a0,-1088 # 80005670 <tickslock>
    80001ab8:	0017879b          	addiw	a5,a5,1
    80001abc:	00f72023          	sw	a5,0(a4)
    80001ac0:	00001097          	auipc	ra,0x1
    80001ac4:	538080e7          	jalr	1336(ra) # 80002ff8 <release>
    80001ac8:	f65ff06f          	j	80001a2c <kerneltrap+0x8c>
    80001acc:	00001097          	auipc	ra,0x1
    80001ad0:	094080e7          	jalr	148(ra) # 80002b60 <uartintr>
    80001ad4:	fa5ff06f          	j	80001a78 <kerneltrap+0xd8>
    80001ad8:	00002517          	auipc	a0,0x2
    80001adc:	7e050513          	addi	a0,a0,2016 # 800042b8 <CONSOLE_STATUS+0x2a8>
    80001ae0:	00000097          	auipc	ra,0x0
    80001ae4:	71c080e7          	jalr	1820(ra) # 800021fc <panic>

0000000080001ae8 <clockintr>:
    80001ae8:	fe010113          	addi	sp,sp,-32
    80001aec:	00813823          	sd	s0,16(sp)
    80001af0:	00913423          	sd	s1,8(sp)
    80001af4:	00113c23          	sd	ra,24(sp)
    80001af8:	02010413          	addi	s0,sp,32
    80001afc:	00004497          	auipc	s1,0x4
    80001b00:	b7448493          	addi	s1,s1,-1164 # 80005670 <tickslock>
    80001b04:	00048513          	mv	a0,s1
    80001b08:	00001097          	auipc	ra,0x1
    80001b0c:	424080e7          	jalr	1060(ra) # 80002f2c <acquire>
    80001b10:	00003717          	auipc	a4,0x3
    80001b14:	a7470713          	addi	a4,a4,-1420 # 80004584 <ticks>
    80001b18:	00072783          	lw	a5,0(a4)
    80001b1c:	01013403          	ld	s0,16(sp)
    80001b20:	01813083          	ld	ra,24(sp)
    80001b24:	00048513          	mv	a0,s1
    80001b28:	0017879b          	addiw	a5,a5,1
    80001b2c:	00813483          	ld	s1,8(sp)
    80001b30:	00f72023          	sw	a5,0(a4)
    80001b34:	02010113          	addi	sp,sp,32
    80001b38:	00001317          	auipc	t1,0x1
    80001b3c:	4c030067          	jr	1216(t1) # 80002ff8 <release>

0000000080001b40 <devintr>:
    80001b40:	142027f3          	csrr	a5,scause
    80001b44:	00000513          	li	a0,0
    80001b48:	0007c463          	bltz	a5,80001b50 <devintr+0x10>
    80001b4c:	00008067          	ret
    80001b50:	fe010113          	addi	sp,sp,-32
    80001b54:	00813823          	sd	s0,16(sp)
    80001b58:	00113c23          	sd	ra,24(sp)
    80001b5c:	00913423          	sd	s1,8(sp)
    80001b60:	02010413          	addi	s0,sp,32
    80001b64:	0ff7f713          	andi	a4,a5,255
    80001b68:	00900693          	li	a3,9
    80001b6c:	04d70c63          	beq	a4,a3,80001bc4 <devintr+0x84>
    80001b70:	fff00713          	li	a4,-1
    80001b74:	03f71713          	slli	a4,a4,0x3f
    80001b78:	00170713          	addi	a4,a4,1
    80001b7c:	00e78c63          	beq	a5,a4,80001b94 <devintr+0x54>
    80001b80:	01813083          	ld	ra,24(sp)
    80001b84:	01013403          	ld	s0,16(sp)
    80001b88:	00813483          	ld	s1,8(sp)
    80001b8c:	02010113          	addi	sp,sp,32
    80001b90:	00008067          	ret
    80001b94:	00000097          	auipc	ra,0x0
    80001b98:	c8c080e7          	jalr	-884(ra) # 80001820 <cpuid>
    80001b9c:	06050663          	beqz	a0,80001c08 <devintr+0xc8>
    80001ba0:	144027f3          	csrr	a5,sip
    80001ba4:	ffd7f793          	andi	a5,a5,-3
    80001ba8:	14479073          	csrw	sip,a5
    80001bac:	01813083          	ld	ra,24(sp)
    80001bb0:	01013403          	ld	s0,16(sp)
    80001bb4:	00813483          	ld	s1,8(sp)
    80001bb8:	00200513          	li	a0,2
    80001bbc:	02010113          	addi	sp,sp,32
    80001bc0:	00008067          	ret
    80001bc4:	00000097          	auipc	ra,0x0
    80001bc8:	250080e7          	jalr	592(ra) # 80001e14 <plic_claim>
    80001bcc:	00a00793          	li	a5,10
    80001bd0:	00050493          	mv	s1,a0
    80001bd4:	06f50663          	beq	a0,a5,80001c40 <devintr+0x100>
    80001bd8:	00100513          	li	a0,1
    80001bdc:	fa0482e3          	beqz	s1,80001b80 <devintr+0x40>
    80001be0:	00048593          	mv	a1,s1
    80001be4:	00002517          	auipc	a0,0x2
    80001be8:	6f450513          	addi	a0,a0,1780 # 800042d8 <CONSOLE_STATUS+0x2c8>
    80001bec:	00000097          	auipc	ra,0x0
    80001bf0:	66c080e7          	jalr	1644(ra) # 80002258 <__printf>
    80001bf4:	00048513          	mv	a0,s1
    80001bf8:	00000097          	auipc	ra,0x0
    80001bfc:	254080e7          	jalr	596(ra) # 80001e4c <plic_complete>
    80001c00:	00100513          	li	a0,1
    80001c04:	f7dff06f          	j	80001b80 <devintr+0x40>
    80001c08:	00004517          	auipc	a0,0x4
    80001c0c:	a6850513          	addi	a0,a0,-1432 # 80005670 <tickslock>
    80001c10:	00001097          	auipc	ra,0x1
    80001c14:	31c080e7          	jalr	796(ra) # 80002f2c <acquire>
    80001c18:	00003717          	auipc	a4,0x3
    80001c1c:	96c70713          	addi	a4,a4,-1684 # 80004584 <ticks>
    80001c20:	00072783          	lw	a5,0(a4)
    80001c24:	00004517          	auipc	a0,0x4
    80001c28:	a4c50513          	addi	a0,a0,-1460 # 80005670 <tickslock>
    80001c2c:	0017879b          	addiw	a5,a5,1
    80001c30:	00f72023          	sw	a5,0(a4)
    80001c34:	00001097          	auipc	ra,0x1
    80001c38:	3c4080e7          	jalr	964(ra) # 80002ff8 <release>
    80001c3c:	f65ff06f          	j	80001ba0 <devintr+0x60>
    80001c40:	00001097          	auipc	ra,0x1
    80001c44:	f20080e7          	jalr	-224(ra) # 80002b60 <uartintr>
    80001c48:	fadff06f          	j	80001bf4 <devintr+0xb4>
    80001c4c:	0000                	unimp
	...

0000000080001c50 <kernelvec>:
    80001c50:	f0010113          	addi	sp,sp,-256
    80001c54:	00113023          	sd	ra,0(sp)
    80001c58:	00213423          	sd	sp,8(sp)
    80001c5c:	00313823          	sd	gp,16(sp)
    80001c60:	00413c23          	sd	tp,24(sp)
    80001c64:	02513023          	sd	t0,32(sp)
    80001c68:	02613423          	sd	t1,40(sp)
    80001c6c:	02713823          	sd	t2,48(sp)
    80001c70:	02813c23          	sd	s0,56(sp)
    80001c74:	04913023          	sd	s1,64(sp)
    80001c78:	04a13423          	sd	a0,72(sp)
    80001c7c:	04b13823          	sd	a1,80(sp)
    80001c80:	04c13c23          	sd	a2,88(sp)
    80001c84:	06d13023          	sd	a3,96(sp)
    80001c88:	06e13423          	sd	a4,104(sp)
    80001c8c:	06f13823          	sd	a5,112(sp)
    80001c90:	07013c23          	sd	a6,120(sp)
    80001c94:	09113023          	sd	a7,128(sp)
    80001c98:	09213423          	sd	s2,136(sp)
    80001c9c:	09313823          	sd	s3,144(sp)
    80001ca0:	09413c23          	sd	s4,152(sp)
    80001ca4:	0b513023          	sd	s5,160(sp)
    80001ca8:	0b613423          	sd	s6,168(sp)
    80001cac:	0b713823          	sd	s7,176(sp)
    80001cb0:	0b813c23          	sd	s8,184(sp)
    80001cb4:	0d913023          	sd	s9,192(sp)
    80001cb8:	0da13423          	sd	s10,200(sp)
    80001cbc:	0db13823          	sd	s11,208(sp)
    80001cc0:	0dc13c23          	sd	t3,216(sp)
    80001cc4:	0fd13023          	sd	t4,224(sp)
    80001cc8:	0fe13423          	sd	t5,232(sp)
    80001ccc:	0ff13823          	sd	t6,240(sp)
    80001cd0:	cd1ff0ef          	jal	ra,800019a0 <kerneltrap>
    80001cd4:	00013083          	ld	ra,0(sp)
    80001cd8:	00813103          	ld	sp,8(sp)
    80001cdc:	01013183          	ld	gp,16(sp)
    80001ce0:	02013283          	ld	t0,32(sp)
    80001ce4:	02813303          	ld	t1,40(sp)
    80001ce8:	03013383          	ld	t2,48(sp)
    80001cec:	03813403          	ld	s0,56(sp)
    80001cf0:	04013483          	ld	s1,64(sp)
    80001cf4:	04813503          	ld	a0,72(sp)
    80001cf8:	05013583          	ld	a1,80(sp)
    80001cfc:	05813603          	ld	a2,88(sp)
    80001d00:	06013683          	ld	a3,96(sp)
    80001d04:	06813703          	ld	a4,104(sp)
    80001d08:	07013783          	ld	a5,112(sp)
    80001d0c:	07813803          	ld	a6,120(sp)
    80001d10:	08013883          	ld	a7,128(sp)
    80001d14:	08813903          	ld	s2,136(sp)
    80001d18:	09013983          	ld	s3,144(sp)
    80001d1c:	09813a03          	ld	s4,152(sp)
    80001d20:	0a013a83          	ld	s5,160(sp)
    80001d24:	0a813b03          	ld	s6,168(sp)
    80001d28:	0b013b83          	ld	s7,176(sp)
    80001d2c:	0b813c03          	ld	s8,184(sp)
    80001d30:	0c013c83          	ld	s9,192(sp)
    80001d34:	0c813d03          	ld	s10,200(sp)
    80001d38:	0d013d83          	ld	s11,208(sp)
    80001d3c:	0d813e03          	ld	t3,216(sp)
    80001d40:	0e013e83          	ld	t4,224(sp)
    80001d44:	0e813f03          	ld	t5,232(sp)
    80001d48:	0f013f83          	ld	t6,240(sp)
    80001d4c:	10010113          	addi	sp,sp,256
    80001d50:	10200073          	sret
    80001d54:	00000013          	nop
    80001d58:	00000013          	nop
    80001d5c:	00000013          	nop

0000000080001d60 <timervec>:
    80001d60:	34051573          	csrrw	a0,mscratch,a0
    80001d64:	00b53023          	sd	a1,0(a0)
    80001d68:	00c53423          	sd	a2,8(a0)
    80001d6c:	00d53823          	sd	a3,16(a0)
    80001d70:	01853583          	ld	a1,24(a0)
    80001d74:	02053603          	ld	a2,32(a0)
    80001d78:	0005b683          	ld	a3,0(a1)
    80001d7c:	00c686b3          	add	a3,a3,a2
    80001d80:	00d5b023          	sd	a3,0(a1)
    80001d84:	00200593          	li	a1,2
    80001d88:	14459073          	csrw	sip,a1
    80001d8c:	01053683          	ld	a3,16(a0)
    80001d90:	00853603          	ld	a2,8(a0)
    80001d94:	00053583          	ld	a1,0(a0)
    80001d98:	34051573          	csrrw	a0,mscratch,a0
    80001d9c:	30200073          	mret

0000000080001da0 <plicinit>:
    80001da0:	ff010113          	addi	sp,sp,-16
    80001da4:	00813423          	sd	s0,8(sp)
    80001da8:	01010413          	addi	s0,sp,16
    80001dac:	00813403          	ld	s0,8(sp)
    80001db0:	0c0007b7          	lui	a5,0xc000
    80001db4:	00100713          	li	a4,1
    80001db8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80001dbc:	00e7a223          	sw	a4,4(a5)
    80001dc0:	01010113          	addi	sp,sp,16
    80001dc4:	00008067          	ret

0000000080001dc8 <plicinithart>:
    80001dc8:	ff010113          	addi	sp,sp,-16
    80001dcc:	00813023          	sd	s0,0(sp)
    80001dd0:	00113423          	sd	ra,8(sp)
    80001dd4:	01010413          	addi	s0,sp,16
    80001dd8:	00000097          	auipc	ra,0x0
    80001ddc:	a48080e7          	jalr	-1464(ra) # 80001820 <cpuid>
    80001de0:	0085171b          	slliw	a4,a0,0x8
    80001de4:	0c0027b7          	lui	a5,0xc002
    80001de8:	00e787b3          	add	a5,a5,a4
    80001dec:	40200713          	li	a4,1026
    80001df0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80001df4:	00813083          	ld	ra,8(sp)
    80001df8:	00013403          	ld	s0,0(sp)
    80001dfc:	00d5151b          	slliw	a0,a0,0xd
    80001e00:	0c2017b7          	lui	a5,0xc201
    80001e04:	00a78533          	add	a0,a5,a0
    80001e08:	00052023          	sw	zero,0(a0)
    80001e0c:	01010113          	addi	sp,sp,16
    80001e10:	00008067          	ret

0000000080001e14 <plic_claim>:
    80001e14:	ff010113          	addi	sp,sp,-16
    80001e18:	00813023          	sd	s0,0(sp)
    80001e1c:	00113423          	sd	ra,8(sp)
    80001e20:	01010413          	addi	s0,sp,16
    80001e24:	00000097          	auipc	ra,0x0
    80001e28:	9fc080e7          	jalr	-1540(ra) # 80001820 <cpuid>
    80001e2c:	00813083          	ld	ra,8(sp)
    80001e30:	00013403          	ld	s0,0(sp)
    80001e34:	00d5151b          	slliw	a0,a0,0xd
    80001e38:	0c2017b7          	lui	a5,0xc201
    80001e3c:	00a78533          	add	a0,a5,a0
    80001e40:	00452503          	lw	a0,4(a0)
    80001e44:	01010113          	addi	sp,sp,16
    80001e48:	00008067          	ret

0000000080001e4c <plic_complete>:
    80001e4c:	fe010113          	addi	sp,sp,-32
    80001e50:	00813823          	sd	s0,16(sp)
    80001e54:	00913423          	sd	s1,8(sp)
    80001e58:	00113c23          	sd	ra,24(sp)
    80001e5c:	02010413          	addi	s0,sp,32
    80001e60:	00050493          	mv	s1,a0
    80001e64:	00000097          	auipc	ra,0x0
    80001e68:	9bc080e7          	jalr	-1604(ra) # 80001820 <cpuid>
    80001e6c:	01813083          	ld	ra,24(sp)
    80001e70:	01013403          	ld	s0,16(sp)
    80001e74:	00d5179b          	slliw	a5,a0,0xd
    80001e78:	0c201737          	lui	a4,0xc201
    80001e7c:	00f707b3          	add	a5,a4,a5
    80001e80:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80001e84:	00813483          	ld	s1,8(sp)
    80001e88:	02010113          	addi	sp,sp,32
    80001e8c:	00008067          	ret

0000000080001e90 <consolewrite>:
    80001e90:	fb010113          	addi	sp,sp,-80
    80001e94:	04813023          	sd	s0,64(sp)
    80001e98:	04113423          	sd	ra,72(sp)
    80001e9c:	02913c23          	sd	s1,56(sp)
    80001ea0:	03213823          	sd	s2,48(sp)
    80001ea4:	03313423          	sd	s3,40(sp)
    80001ea8:	03413023          	sd	s4,32(sp)
    80001eac:	01513c23          	sd	s5,24(sp)
    80001eb0:	05010413          	addi	s0,sp,80
    80001eb4:	06c05c63          	blez	a2,80001f2c <consolewrite+0x9c>
    80001eb8:	00060993          	mv	s3,a2
    80001ebc:	00050a13          	mv	s4,a0
    80001ec0:	00058493          	mv	s1,a1
    80001ec4:	00000913          	li	s2,0
    80001ec8:	fff00a93          	li	s5,-1
    80001ecc:	01c0006f          	j	80001ee8 <consolewrite+0x58>
    80001ed0:	fbf44503          	lbu	a0,-65(s0)
    80001ed4:	0019091b          	addiw	s2,s2,1
    80001ed8:	00148493          	addi	s1,s1,1
    80001edc:	00001097          	auipc	ra,0x1
    80001ee0:	a9c080e7          	jalr	-1380(ra) # 80002978 <uartputc>
    80001ee4:	03298063          	beq	s3,s2,80001f04 <consolewrite+0x74>
    80001ee8:	00048613          	mv	a2,s1
    80001eec:	00100693          	li	a3,1
    80001ef0:	000a0593          	mv	a1,s4
    80001ef4:	fbf40513          	addi	a0,s0,-65
    80001ef8:	00000097          	auipc	ra,0x0
    80001efc:	9e0080e7          	jalr	-1568(ra) # 800018d8 <either_copyin>
    80001f00:	fd5518e3          	bne	a0,s5,80001ed0 <consolewrite+0x40>
    80001f04:	04813083          	ld	ra,72(sp)
    80001f08:	04013403          	ld	s0,64(sp)
    80001f0c:	03813483          	ld	s1,56(sp)
    80001f10:	02813983          	ld	s3,40(sp)
    80001f14:	02013a03          	ld	s4,32(sp)
    80001f18:	01813a83          	ld	s5,24(sp)
    80001f1c:	00090513          	mv	a0,s2
    80001f20:	03013903          	ld	s2,48(sp)
    80001f24:	05010113          	addi	sp,sp,80
    80001f28:	00008067          	ret
    80001f2c:	00000913          	li	s2,0
    80001f30:	fd5ff06f          	j	80001f04 <consolewrite+0x74>

0000000080001f34 <consoleread>:
    80001f34:	f9010113          	addi	sp,sp,-112
    80001f38:	06813023          	sd	s0,96(sp)
    80001f3c:	04913c23          	sd	s1,88(sp)
    80001f40:	05213823          	sd	s2,80(sp)
    80001f44:	05313423          	sd	s3,72(sp)
    80001f48:	05413023          	sd	s4,64(sp)
    80001f4c:	03513c23          	sd	s5,56(sp)
    80001f50:	03613823          	sd	s6,48(sp)
    80001f54:	03713423          	sd	s7,40(sp)
    80001f58:	03813023          	sd	s8,32(sp)
    80001f5c:	06113423          	sd	ra,104(sp)
    80001f60:	01913c23          	sd	s9,24(sp)
    80001f64:	07010413          	addi	s0,sp,112
    80001f68:	00060b93          	mv	s7,a2
    80001f6c:	00050913          	mv	s2,a0
    80001f70:	00058c13          	mv	s8,a1
    80001f74:	00060b1b          	sext.w	s6,a2
    80001f78:	00003497          	auipc	s1,0x3
    80001f7c:	71048493          	addi	s1,s1,1808 # 80005688 <cons>
    80001f80:	00400993          	li	s3,4
    80001f84:	fff00a13          	li	s4,-1
    80001f88:	00a00a93          	li	s5,10
    80001f8c:	05705e63          	blez	s7,80001fe8 <consoleread+0xb4>
    80001f90:	09c4a703          	lw	a4,156(s1)
    80001f94:	0984a783          	lw	a5,152(s1)
    80001f98:	0007071b          	sext.w	a4,a4
    80001f9c:	08e78463          	beq	a5,a4,80002024 <consoleread+0xf0>
    80001fa0:	07f7f713          	andi	a4,a5,127
    80001fa4:	00e48733          	add	a4,s1,a4
    80001fa8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80001fac:	0017869b          	addiw	a3,a5,1
    80001fb0:	08d4ac23          	sw	a3,152(s1)
    80001fb4:	00070c9b          	sext.w	s9,a4
    80001fb8:	0b370663          	beq	a4,s3,80002064 <consoleread+0x130>
    80001fbc:	00100693          	li	a3,1
    80001fc0:	f9f40613          	addi	a2,s0,-97
    80001fc4:	000c0593          	mv	a1,s8
    80001fc8:	00090513          	mv	a0,s2
    80001fcc:	f8e40fa3          	sb	a4,-97(s0)
    80001fd0:	00000097          	auipc	ra,0x0
    80001fd4:	8bc080e7          	jalr	-1860(ra) # 8000188c <either_copyout>
    80001fd8:	01450863          	beq	a0,s4,80001fe8 <consoleread+0xb4>
    80001fdc:	001c0c13          	addi	s8,s8,1
    80001fe0:	fffb8b9b          	addiw	s7,s7,-1
    80001fe4:	fb5c94e3          	bne	s9,s5,80001f8c <consoleread+0x58>
    80001fe8:	000b851b          	sext.w	a0,s7
    80001fec:	06813083          	ld	ra,104(sp)
    80001ff0:	06013403          	ld	s0,96(sp)
    80001ff4:	05813483          	ld	s1,88(sp)
    80001ff8:	05013903          	ld	s2,80(sp)
    80001ffc:	04813983          	ld	s3,72(sp)
    80002000:	04013a03          	ld	s4,64(sp)
    80002004:	03813a83          	ld	s5,56(sp)
    80002008:	02813b83          	ld	s7,40(sp)
    8000200c:	02013c03          	ld	s8,32(sp)
    80002010:	01813c83          	ld	s9,24(sp)
    80002014:	40ab053b          	subw	a0,s6,a0
    80002018:	03013b03          	ld	s6,48(sp)
    8000201c:	07010113          	addi	sp,sp,112
    80002020:	00008067          	ret
    80002024:	00001097          	auipc	ra,0x1
    80002028:	1d8080e7          	jalr	472(ra) # 800031fc <push_on>
    8000202c:	0984a703          	lw	a4,152(s1)
    80002030:	09c4a783          	lw	a5,156(s1)
    80002034:	0007879b          	sext.w	a5,a5
    80002038:	fef70ce3          	beq	a4,a5,80002030 <consoleread+0xfc>
    8000203c:	00001097          	auipc	ra,0x1
    80002040:	234080e7          	jalr	564(ra) # 80003270 <pop_on>
    80002044:	0984a783          	lw	a5,152(s1)
    80002048:	07f7f713          	andi	a4,a5,127
    8000204c:	00e48733          	add	a4,s1,a4
    80002050:	01874703          	lbu	a4,24(a4)
    80002054:	0017869b          	addiw	a3,a5,1
    80002058:	08d4ac23          	sw	a3,152(s1)
    8000205c:	00070c9b          	sext.w	s9,a4
    80002060:	f5371ee3          	bne	a4,s3,80001fbc <consoleread+0x88>
    80002064:	000b851b          	sext.w	a0,s7
    80002068:	f96bf2e3          	bgeu	s7,s6,80001fec <consoleread+0xb8>
    8000206c:	08f4ac23          	sw	a5,152(s1)
    80002070:	f7dff06f          	j	80001fec <consoleread+0xb8>

0000000080002074 <consputc>:
    80002074:	10000793          	li	a5,256
    80002078:	00f50663          	beq	a0,a5,80002084 <consputc+0x10>
    8000207c:	00001317          	auipc	t1,0x1
    80002080:	9f430067          	jr	-1548(t1) # 80002a70 <uartputc_sync>
    80002084:	ff010113          	addi	sp,sp,-16
    80002088:	00113423          	sd	ra,8(sp)
    8000208c:	00813023          	sd	s0,0(sp)
    80002090:	01010413          	addi	s0,sp,16
    80002094:	00800513          	li	a0,8
    80002098:	00001097          	auipc	ra,0x1
    8000209c:	9d8080e7          	jalr	-1576(ra) # 80002a70 <uartputc_sync>
    800020a0:	02000513          	li	a0,32
    800020a4:	00001097          	auipc	ra,0x1
    800020a8:	9cc080e7          	jalr	-1588(ra) # 80002a70 <uartputc_sync>
    800020ac:	00013403          	ld	s0,0(sp)
    800020b0:	00813083          	ld	ra,8(sp)
    800020b4:	00800513          	li	a0,8
    800020b8:	01010113          	addi	sp,sp,16
    800020bc:	00001317          	auipc	t1,0x1
    800020c0:	9b430067          	jr	-1612(t1) # 80002a70 <uartputc_sync>

00000000800020c4 <consoleintr>:
    800020c4:	fe010113          	addi	sp,sp,-32
    800020c8:	00813823          	sd	s0,16(sp)
    800020cc:	00913423          	sd	s1,8(sp)
    800020d0:	01213023          	sd	s2,0(sp)
    800020d4:	00113c23          	sd	ra,24(sp)
    800020d8:	02010413          	addi	s0,sp,32
    800020dc:	00003917          	auipc	s2,0x3
    800020e0:	5ac90913          	addi	s2,s2,1452 # 80005688 <cons>
    800020e4:	00050493          	mv	s1,a0
    800020e8:	00090513          	mv	a0,s2
    800020ec:	00001097          	auipc	ra,0x1
    800020f0:	e40080e7          	jalr	-448(ra) # 80002f2c <acquire>
    800020f4:	02048c63          	beqz	s1,8000212c <consoleintr+0x68>
    800020f8:	0a092783          	lw	a5,160(s2)
    800020fc:	09892703          	lw	a4,152(s2)
    80002100:	07f00693          	li	a3,127
    80002104:	40e7873b          	subw	a4,a5,a4
    80002108:	02e6e263          	bltu	a3,a4,8000212c <consoleintr+0x68>
    8000210c:	00d00713          	li	a4,13
    80002110:	04e48063          	beq	s1,a4,80002150 <consoleintr+0x8c>
    80002114:	07f7f713          	andi	a4,a5,127
    80002118:	00e90733          	add	a4,s2,a4
    8000211c:	0017879b          	addiw	a5,a5,1
    80002120:	0af92023          	sw	a5,160(s2)
    80002124:	00970c23          	sb	s1,24(a4)
    80002128:	08f92e23          	sw	a5,156(s2)
    8000212c:	01013403          	ld	s0,16(sp)
    80002130:	01813083          	ld	ra,24(sp)
    80002134:	00813483          	ld	s1,8(sp)
    80002138:	00013903          	ld	s2,0(sp)
    8000213c:	00003517          	auipc	a0,0x3
    80002140:	54c50513          	addi	a0,a0,1356 # 80005688 <cons>
    80002144:	02010113          	addi	sp,sp,32
    80002148:	00001317          	auipc	t1,0x1
    8000214c:	eb030067          	jr	-336(t1) # 80002ff8 <release>
    80002150:	00a00493          	li	s1,10
    80002154:	fc1ff06f          	j	80002114 <consoleintr+0x50>

0000000080002158 <consoleinit>:
    80002158:	fe010113          	addi	sp,sp,-32
    8000215c:	00113c23          	sd	ra,24(sp)
    80002160:	00813823          	sd	s0,16(sp)
    80002164:	00913423          	sd	s1,8(sp)
    80002168:	02010413          	addi	s0,sp,32
    8000216c:	00003497          	auipc	s1,0x3
    80002170:	51c48493          	addi	s1,s1,1308 # 80005688 <cons>
    80002174:	00048513          	mv	a0,s1
    80002178:	00002597          	auipc	a1,0x2
    8000217c:	1b858593          	addi	a1,a1,440 # 80004330 <CONSOLE_STATUS+0x320>
    80002180:	00001097          	auipc	ra,0x1
    80002184:	d88080e7          	jalr	-632(ra) # 80002f08 <initlock>
    80002188:	00000097          	auipc	ra,0x0
    8000218c:	7ac080e7          	jalr	1964(ra) # 80002934 <uartinit>
    80002190:	01813083          	ld	ra,24(sp)
    80002194:	01013403          	ld	s0,16(sp)
    80002198:	00000797          	auipc	a5,0x0
    8000219c:	d9c78793          	addi	a5,a5,-612 # 80001f34 <consoleread>
    800021a0:	0af4bc23          	sd	a5,184(s1)
    800021a4:	00000797          	auipc	a5,0x0
    800021a8:	cec78793          	addi	a5,a5,-788 # 80001e90 <consolewrite>
    800021ac:	0cf4b023          	sd	a5,192(s1)
    800021b0:	00813483          	ld	s1,8(sp)
    800021b4:	02010113          	addi	sp,sp,32
    800021b8:	00008067          	ret

00000000800021bc <console_read>:
    800021bc:	ff010113          	addi	sp,sp,-16
    800021c0:	00813423          	sd	s0,8(sp)
    800021c4:	01010413          	addi	s0,sp,16
    800021c8:	00813403          	ld	s0,8(sp)
    800021cc:	00003317          	auipc	t1,0x3
    800021d0:	57433303          	ld	t1,1396(t1) # 80005740 <devsw+0x10>
    800021d4:	01010113          	addi	sp,sp,16
    800021d8:	00030067          	jr	t1

00000000800021dc <console_write>:
    800021dc:	ff010113          	addi	sp,sp,-16
    800021e0:	00813423          	sd	s0,8(sp)
    800021e4:	01010413          	addi	s0,sp,16
    800021e8:	00813403          	ld	s0,8(sp)
    800021ec:	00003317          	auipc	t1,0x3
    800021f0:	55c33303          	ld	t1,1372(t1) # 80005748 <devsw+0x18>
    800021f4:	01010113          	addi	sp,sp,16
    800021f8:	00030067          	jr	t1

00000000800021fc <panic>:
    800021fc:	fe010113          	addi	sp,sp,-32
    80002200:	00113c23          	sd	ra,24(sp)
    80002204:	00813823          	sd	s0,16(sp)
    80002208:	00913423          	sd	s1,8(sp)
    8000220c:	02010413          	addi	s0,sp,32
    80002210:	00050493          	mv	s1,a0
    80002214:	00002517          	auipc	a0,0x2
    80002218:	12450513          	addi	a0,a0,292 # 80004338 <CONSOLE_STATUS+0x328>
    8000221c:	00003797          	auipc	a5,0x3
    80002220:	5c07a623          	sw	zero,1484(a5) # 800057e8 <pr+0x18>
    80002224:	00000097          	auipc	ra,0x0
    80002228:	034080e7          	jalr	52(ra) # 80002258 <__printf>
    8000222c:	00048513          	mv	a0,s1
    80002230:	00000097          	auipc	ra,0x0
    80002234:	028080e7          	jalr	40(ra) # 80002258 <__printf>
    80002238:	00002517          	auipc	a0,0x2
    8000223c:	f9850513          	addi	a0,a0,-104 # 800041d0 <CONSOLE_STATUS+0x1c0>
    80002240:	00000097          	auipc	ra,0x0
    80002244:	018080e7          	jalr	24(ra) # 80002258 <__printf>
    80002248:	00100793          	li	a5,1
    8000224c:	00002717          	auipc	a4,0x2
    80002250:	32f72e23          	sw	a5,828(a4) # 80004588 <panicked>
    80002254:	0000006f          	j	80002254 <panic+0x58>

0000000080002258 <__printf>:
    80002258:	f3010113          	addi	sp,sp,-208
    8000225c:	08813023          	sd	s0,128(sp)
    80002260:	07313423          	sd	s3,104(sp)
    80002264:	09010413          	addi	s0,sp,144
    80002268:	05813023          	sd	s8,64(sp)
    8000226c:	08113423          	sd	ra,136(sp)
    80002270:	06913c23          	sd	s1,120(sp)
    80002274:	07213823          	sd	s2,112(sp)
    80002278:	07413023          	sd	s4,96(sp)
    8000227c:	05513c23          	sd	s5,88(sp)
    80002280:	05613823          	sd	s6,80(sp)
    80002284:	05713423          	sd	s7,72(sp)
    80002288:	03913c23          	sd	s9,56(sp)
    8000228c:	03a13823          	sd	s10,48(sp)
    80002290:	03b13423          	sd	s11,40(sp)
    80002294:	00003317          	auipc	t1,0x3
    80002298:	53c30313          	addi	t1,t1,1340 # 800057d0 <pr>
    8000229c:	01832c03          	lw	s8,24(t1)
    800022a0:	00b43423          	sd	a1,8(s0)
    800022a4:	00c43823          	sd	a2,16(s0)
    800022a8:	00d43c23          	sd	a3,24(s0)
    800022ac:	02e43023          	sd	a4,32(s0)
    800022b0:	02f43423          	sd	a5,40(s0)
    800022b4:	03043823          	sd	a6,48(s0)
    800022b8:	03143c23          	sd	a7,56(s0)
    800022bc:	00050993          	mv	s3,a0
    800022c0:	4a0c1663          	bnez	s8,8000276c <__printf+0x514>
    800022c4:	60098c63          	beqz	s3,800028dc <__printf+0x684>
    800022c8:	0009c503          	lbu	a0,0(s3)
    800022cc:	00840793          	addi	a5,s0,8
    800022d0:	f6f43c23          	sd	a5,-136(s0)
    800022d4:	00000493          	li	s1,0
    800022d8:	22050063          	beqz	a0,800024f8 <__printf+0x2a0>
    800022dc:	00002a37          	lui	s4,0x2
    800022e0:	00018ab7          	lui	s5,0x18
    800022e4:	000f4b37          	lui	s6,0xf4
    800022e8:	00989bb7          	lui	s7,0x989
    800022ec:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800022f0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800022f4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800022f8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800022fc:	00148c9b          	addiw	s9,s1,1
    80002300:	02500793          	li	a5,37
    80002304:	01998933          	add	s2,s3,s9
    80002308:	38f51263          	bne	a0,a5,8000268c <__printf+0x434>
    8000230c:	00094783          	lbu	a5,0(s2)
    80002310:	00078c9b          	sext.w	s9,a5
    80002314:	1e078263          	beqz	a5,800024f8 <__printf+0x2a0>
    80002318:	0024849b          	addiw	s1,s1,2
    8000231c:	07000713          	li	a4,112
    80002320:	00998933          	add	s2,s3,s1
    80002324:	38e78a63          	beq	a5,a4,800026b8 <__printf+0x460>
    80002328:	20f76863          	bltu	a4,a5,80002538 <__printf+0x2e0>
    8000232c:	42a78863          	beq	a5,a0,8000275c <__printf+0x504>
    80002330:	06400713          	li	a4,100
    80002334:	40e79663          	bne	a5,a4,80002740 <__printf+0x4e8>
    80002338:	f7843783          	ld	a5,-136(s0)
    8000233c:	0007a603          	lw	a2,0(a5)
    80002340:	00878793          	addi	a5,a5,8
    80002344:	f6f43c23          	sd	a5,-136(s0)
    80002348:	42064a63          	bltz	a2,8000277c <__printf+0x524>
    8000234c:	00a00713          	li	a4,10
    80002350:	02e677bb          	remuw	a5,a2,a4
    80002354:	00002d97          	auipc	s11,0x2
    80002358:	00cd8d93          	addi	s11,s11,12 # 80004360 <digits>
    8000235c:	00900593          	li	a1,9
    80002360:	0006051b          	sext.w	a0,a2
    80002364:	00000c93          	li	s9,0
    80002368:	02079793          	slli	a5,a5,0x20
    8000236c:	0207d793          	srli	a5,a5,0x20
    80002370:	00fd87b3          	add	a5,s11,a5
    80002374:	0007c783          	lbu	a5,0(a5)
    80002378:	02e656bb          	divuw	a3,a2,a4
    8000237c:	f8f40023          	sb	a5,-128(s0)
    80002380:	14c5d863          	bge	a1,a2,800024d0 <__printf+0x278>
    80002384:	06300593          	li	a1,99
    80002388:	00100c93          	li	s9,1
    8000238c:	02e6f7bb          	remuw	a5,a3,a4
    80002390:	02079793          	slli	a5,a5,0x20
    80002394:	0207d793          	srli	a5,a5,0x20
    80002398:	00fd87b3          	add	a5,s11,a5
    8000239c:	0007c783          	lbu	a5,0(a5)
    800023a0:	02e6d73b          	divuw	a4,a3,a4
    800023a4:	f8f400a3          	sb	a5,-127(s0)
    800023a8:	12a5f463          	bgeu	a1,a0,800024d0 <__printf+0x278>
    800023ac:	00a00693          	li	a3,10
    800023b0:	00900593          	li	a1,9
    800023b4:	02d777bb          	remuw	a5,a4,a3
    800023b8:	02079793          	slli	a5,a5,0x20
    800023bc:	0207d793          	srli	a5,a5,0x20
    800023c0:	00fd87b3          	add	a5,s11,a5
    800023c4:	0007c503          	lbu	a0,0(a5)
    800023c8:	02d757bb          	divuw	a5,a4,a3
    800023cc:	f8a40123          	sb	a0,-126(s0)
    800023d0:	48e5f263          	bgeu	a1,a4,80002854 <__printf+0x5fc>
    800023d4:	06300513          	li	a0,99
    800023d8:	02d7f5bb          	remuw	a1,a5,a3
    800023dc:	02059593          	slli	a1,a1,0x20
    800023e0:	0205d593          	srli	a1,a1,0x20
    800023e4:	00bd85b3          	add	a1,s11,a1
    800023e8:	0005c583          	lbu	a1,0(a1)
    800023ec:	02d7d7bb          	divuw	a5,a5,a3
    800023f0:	f8b401a3          	sb	a1,-125(s0)
    800023f4:	48e57263          	bgeu	a0,a4,80002878 <__printf+0x620>
    800023f8:	3e700513          	li	a0,999
    800023fc:	02d7f5bb          	remuw	a1,a5,a3
    80002400:	02059593          	slli	a1,a1,0x20
    80002404:	0205d593          	srli	a1,a1,0x20
    80002408:	00bd85b3          	add	a1,s11,a1
    8000240c:	0005c583          	lbu	a1,0(a1)
    80002410:	02d7d7bb          	divuw	a5,a5,a3
    80002414:	f8b40223          	sb	a1,-124(s0)
    80002418:	46e57663          	bgeu	a0,a4,80002884 <__printf+0x62c>
    8000241c:	02d7f5bb          	remuw	a1,a5,a3
    80002420:	02059593          	slli	a1,a1,0x20
    80002424:	0205d593          	srli	a1,a1,0x20
    80002428:	00bd85b3          	add	a1,s11,a1
    8000242c:	0005c583          	lbu	a1,0(a1)
    80002430:	02d7d7bb          	divuw	a5,a5,a3
    80002434:	f8b402a3          	sb	a1,-123(s0)
    80002438:	46ea7863          	bgeu	s4,a4,800028a8 <__printf+0x650>
    8000243c:	02d7f5bb          	remuw	a1,a5,a3
    80002440:	02059593          	slli	a1,a1,0x20
    80002444:	0205d593          	srli	a1,a1,0x20
    80002448:	00bd85b3          	add	a1,s11,a1
    8000244c:	0005c583          	lbu	a1,0(a1)
    80002450:	02d7d7bb          	divuw	a5,a5,a3
    80002454:	f8b40323          	sb	a1,-122(s0)
    80002458:	3eeaf863          	bgeu	s5,a4,80002848 <__printf+0x5f0>
    8000245c:	02d7f5bb          	remuw	a1,a5,a3
    80002460:	02059593          	slli	a1,a1,0x20
    80002464:	0205d593          	srli	a1,a1,0x20
    80002468:	00bd85b3          	add	a1,s11,a1
    8000246c:	0005c583          	lbu	a1,0(a1)
    80002470:	02d7d7bb          	divuw	a5,a5,a3
    80002474:	f8b403a3          	sb	a1,-121(s0)
    80002478:	42eb7e63          	bgeu	s6,a4,800028b4 <__printf+0x65c>
    8000247c:	02d7f5bb          	remuw	a1,a5,a3
    80002480:	02059593          	slli	a1,a1,0x20
    80002484:	0205d593          	srli	a1,a1,0x20
    80002488:	00bd85b3          	add	a1,s11,a1
    8000248c:	0005c583          	lbu	a1,0(a1)
    80002490:	02d7d7bb          	divuw	a5,a5,a3
    80002494:	f8b40423          	sb	a1,-120(s0)
    80002498:	42ebfc63          	bgeu	s7,a4,800028d0 <__printf+0x678>
    8000249c:	02079793          	slli	a5,a5,0x20
    800024a0:	0207d793          	srli	a5,a5,0x20
    800024a4:	00fd8db3          	add	s11,s11,a5
    800024a8:	000dc703          	lbu	a4,0(s11)
    800024ac:	00a00793          	li	a5,10
    800024b0:	00900c93          	li	s9,9
    800024b4:	f8e404a3          	sb	a4,-119(s0)
    800024b8:	00065c63          	bgez	a2,800024d0 <__printf+0x278>
    800024bc:	f9040713          	addi	a4,s0,-112
    800024c0:	00f70733          	add	a4,a4,a5
    800024c4:	02d00693          	li	a3,45
    800024c8:	fed70823          	sb	a3,-16(a4)
    800024cc:	00078c93          	mv	s9,a5
    800024d0:	f8040793          	addi	a5,s0,-128
    800024d4:	01978cb3          	add	s9,a5,s9
    800024d8:	f7f40d13          	addi	s10,s0,-129
    800024dc:	000cc503          	lbu	a0,0(s9)
    800024e0:	fffc8c93          	addi	s9,s9,-1
    800024e4:	00000097          	auipc	ra,0x0
    800024e8:	b90080e7          	jalr	-1136(ra) # 80002074 <consputc>
    800024ec:	ffac98e3          	bne	s9,s10,800024dc <__printf+0x284>
    800024f0:	00094503          	lbu	a0,0(s2)
    800024f4:	e00514e3          	bnez	a0,800022fc <__printf+0xa4>
    800024f8:	1a0c1663          	bnez	s8,800026a4 <__printf+0x44c>
    800024fc:	08813083          	ld	ra,136(sp)
    80002500:	08013403          	ld	s0,128(sp)
    80002504:	07813483          	ld	s1,120(sp)
    80002508:	07013903          	ld	s2,112(sp)
    8000250c:	06813983          	ld	s3,104(sp)
    80002510:	06013a03          	ld	s4,96(sp)
    80002514:	05813a83          	ld	s5,88(sp)
    80002518:	05013b03          	ld	s6,80(sp)
    8000251c:	04813b83          	ld	s7,72(sp)
    80002520:	04013c03          	ld	s8,64(sp)
    80002524:	03813c83          	ld	s9,56(sp)
    80002528:	03013d03          	ld	s10,48(sp)
    8000252c:	02813d83          	ld	s11,40(sp)
    80002530:	0d010113          	addi	sp,sp,208
    80002534:	00008067          	ret
    80002538:	07300713          	li	a4,115
    8000253c:	1ce78a63          	beq	a5,a4,80002710 <__printf+0x4b8>
    80002540:	07800713          	li	a4,120
    80002544:	1ee79e63          	bne	a5,a4,80002740 <__printf+0x4e8>
    80002548:	f7843783          	ld	a5,-136(s0)
    8000254c:	0007a703          	lw	a4,0(a5)
    80002550:	00878793          	addi	a5,a5,8
    80002554:	f6f43c23          	sd	a5,-136(s0)
    80002558:	28074263          	bltz	a4,800027dc <__printf+0x584>
    8000255c:	00002d97          	auipc	s11,0x2
    80002560:	e04d8d93          	addi	s11,s11,-508 # 80004360 <digits>
    80002564:	00f77793          	andi	a5,a4,15
    80002568:	00fd87b3          	add	a5,s11,a5
    8000256c:	0007c683          	lbu	a3,0(a5)
    80002570:	00f00613          	li	a2,15
    80002574:	0007079b          	sext.w	a5,a4
    80002578:	f8d40023          	sb	a3,-128(s0)
    8000257c:	0047559b          	srliw	a1,a4,0x4
    80002580:	0047569b          	srliw	a3,a4,0x4
    80002584:	00000c93          	li	s9,0
    80002588:	0ee65063          	bge	a2,a4,80002668 <__printf+0x410>
    8000258c:	00f6f693          	andi	a3,a3,15
    80002590:	00dd86b3          	add	a3,s11,a3
    80002594:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80002598:	0087d79b          	srliw	a5,a5,0x8
    8000259c:	00100c93          	li	s9,1
    800025a0:	f8d400a3          	sb	a3,-127(s0)
    800025a4:	0cb67263          	bgeu	a2,a1,80002668 <__printf+0x410>
    800025a8:	00f7f693          	andi	a3,a5,15
    800025ac:	00dd86b3          	add	a3,s11,a3
    800025b0:	0006c583          	lbu	a1,0(a3)
    800025b4:	00f00613          	li	a2,15
    800025b8:	0047d69b          	srliw	a3,a5,0x4
    800025bc:	f8b40123          	sb	a1,-126(s0)
    800025c0:	0047d593          	srli	a1,a5,0x4
    800025c4:	28f67e63          	bgeu	a2,a5,80002860 <__printf+0x608>
    800025c8:	00f6f693          	andi	a3,a3,15
    800025cc:	00dd86b3          	add	a3,s11,a3
    800025d0:	0006c503          	lbu	a0,0(a3)
    800025d4:	0087d813          	srli	a6,a5,0x8
    800025d8:	0087d69b          	srliw	a3,a5,0x8
    800025dc:	f8a401a3          	sb	a0,-125(s0)
    800025e0:	28b67663          	bgeu	a2,a1,8000286c <__printf+0x614>
    800025e4:	00f6f693          	andi	a3,a3,15
    800025e8:	00dd86b3          	add	a3,s11,a3
    800025ec:	0006c583          	lbu	a1,0(a3)
    800025f0:	00c7d513          	srli	a0,a5,0xc
    800025f4:	00c7d69b          	srliw	a3,a5,0xc
    800025f8:	f8b40223          	sb	a1,-124(s0)
    800025fc:	29067a63          	bgeu	a2,a6,80002890 <__printf+0x638>
    80002600:	00f6f693          	andi	a3,a3,15
    80002604:	00dd86b3          	add	a3,s11,a3
    80002608:	0006c583          	lbu	a1,0(a3)
    8000260c:	0107d813          	srli	a6,a5,0x10
    80002610:	0107d69b          	srliw	a3,a5,0x10
    80002614:	f8b402a3          	sb	a1,-123(s0)
    80002618:	28a67263          	bgeu	a2,a0,8000289c <__printf+0x644>
    8000261c:	00f6f693          	andi	a3,a3,15
    80002620:	00dd86b3          	add	a3,s11,a3
    80002624:	0006c683          	lbu	a3,0(a3)
    80002628:	0147d79b          	srliw	a5,a5,0x14
    8000262c:	f8d40323          	sb	a3,-122(s0)
    80002630:	21067663          	bgeu	a2,a6,8000283c <__printf+0x5e4>
    80002634:	02079793          	slli	a5,a5,0x20
    80002638:	0207d793          	srli	a5,a5,0x20
    8000263c:	00fd8db3          	add	s11,s11,a5
    80002640:	000dc683          	lbu	a3,0(s11)
    80002644:	00800793          	li	a5,8
    80002648:	00700c93          	li	s9,7
    8000264c:	f8d403a3          	sb	a3,-121(s0)
    80002650:	00075c63          	bgez	a4,80002668 <__printf+0x410>
    80002654:	f9040713          	addi	a4,s0,-112
    80002658:	00f70733          	add	a4,a4,a5
    8000265c:	02d00693          	li	a3,45
    80002660:	fed70823          	sb	a3,-16(a4)
    80002664:	00078c93          	mv	s9,a5
    80002668:	f8040793          	addi	a5,s0,-128
    8000266c:	01978cb3          	add	s9,a5,s9
    80002670:	f7f40d13          	addi	s10,s0,-129
    80002674:	000cc503          	lbu	a0,0(s9)
    80002678:	fffc8c93          	addi	s9,s9,-1
    8000267c:	00000097          	auipc	ra,0x0
    80002680:	9f8080e7          	jalr	-1544(ra) # 80002074 <consputc>
    80002684:	ff9d18e3          	bne	s10,s9,80002674 <__printf+0x41c>
    80002688:	0100006f          	j	80002698 <__printf+0x440>
    8000268c:	00000097          	auipc	ra,0x0
    80002690:	9e8080e7          	jalr	-1560(ra) # 80002074 <consputc>
    80002694:	000c8493          	mv	s1,s9
    80002698:	00094503          	lbu	a0,0(s2)
    8000269c:	c60510e3          	bnez	a0,800022fc <__printf+0xa4>
    800026a0:	e40c0ee3          	beqz	s8,800024fc <__printf+0x2a4>
    800026a4:	00003517          	auipc	a0,0x3
    800026a8:	12c50513          	addi	a0,a0,300 # 800057d0 <pr>
    800026ac:	00001097          	auipc	ra,0x1
    800026b0:	94c080e7          	jalr	-1716(ra) # 80002ff8 <release>
    800026b4:	e49ff06f          	j	800024fc <__printf+0x2a4>
    800026b8:	f7843783          	ld	a5,-136(s0)
    800026bc:	03000513          	li	a0,48
    800026c0:	01000d13          	li	s10,16
    800026c4:	00878713          	addi	a4,a5,8
    800026c8:	0007bc83          	ld	s9,0(a5)
    800026cc:	f6e43c23          	sd	a4,-136(s0)
    800026d0:	00000097          	auipc	ra,0x0
    800026d4:	9a4080e7          	jalr	-1628(ra) # 80002074 <consputc>
    800026d8:	07800513          	li	a0,120
    800026dc:	00000097          	auipc	ra,0x0
    800026e0:	998080e7          	jalr	-1640(ra) # 80002074 <consputc>
    800026e4:	00002d97          	auipc	s11,0x2
    800026e8:	c7cd8d93          	addi	s11,s11,-900 # 80004360 <digits>
    800026ec:	03ccd793          	srli	a5,s9,0x3c
    800026f0:	00fd87b3          	add	a5,s11,a5
    800026f4:	0007c503          	lbu	a0,0(a5)
    800026f8:	fffd0d1b          	addiw	s10,s10,-1
    800026fc:	004c9c93          	slli	s9,s9,0x4
    80002700:	00000097          	auipc	ra,0x0
    80002704:	974080e7          	jalr	-1676(ra) # 80002074 <consputc>
    80002708:	fe0d12e3          	bnez	s10,800026ec <__printf+0x494>
    8000270c:	f8dff06f          	j	80002698 <__printf+0x440>
    80002710:	f7843783          	ld	a5,-136(s0)
    80002714:	0007bc83          	ld	s9,0(a5)
    80002718:	00878793          	addi	a5,a5,8
    8000271c:	f6f43c23          	sd	a5,-136(s0)
    80002720:	000c9a63          	bnez	s9,80002734 <__printf+0x4dc>
    80002724:	1080006f          	j	8000282c <__printf+0x5d4>
    80002728:	001c8c93          	addi	s9,s9,1
    8000272c:	00000097          	auipc	ra,0x0
    80002730:	948080e7          	jalr	-1720(ra) # 80002074 <consputc>
    80002734:	000cc503          	lbu	a0,0(s9)
    80002738:	fe0518e3          	bnez	a0,80002728 <__printf+0x4d0>
    8000273c:	f5dff06f          	j	80002698 <__printf+0x440>
    80002740:	02500513          	li	a0,37
    80002744:	00000097          	auipc	ra,0x0
    80002748:	930080e7          	jalr	-1744(ra) # 80002074 <consputc>
    8000274c:	000c8513          	mv	a0,s9
    80002750:	00000097          	auipc	ra,0x0
    80002754:	924080e7          	jalr	-1756(ra) # 80002074 <consputc>
    80002758:	f41ff06f          	j	80002698 <__printf+0x440>
    8000275c:	02500513          	li	a0,37
    80002760:	00000097          	auipc	ra,0x0
    80002764:	914080e7          	jalr	-1772(ra) # 80002074 <consputc>
    80002768:	f31ff06f          	j	80002698 <__printf+0x440>
    8000276c:	00030513          	mv	a0,t1
    80002770:	00000097          	auipc	ra,0x0
    80002774:	7bc080e7          	jalr	1980(ra) # 80002f2c <acquire>
    80002778:	b4dff06f          	j	800022c4 <__printf+0x6c>
    8000277c:	40c0053b          	negw	a0,a2
    80002780:	00a00713          	li	a4,10
    80002784:	02e576bb          	remuw	a3,a0,a4
    80002788:	00002d97          	auipc	s11,0x2
    8000278c:	bd8d8d93          	addi	s11,s11,-1064 # 80004360 <digits>
    80002790:	ff700593          	li	a1,-9
    80002794:	02069693          	slli	a3,a3,0x20
    80002798:	0206d693          	srli	a3,a3,0x20
    8000279c:	00dd86b3          	add	a3,s11,a3
    800027a0:	0006c683          	lbu	a3,0(a3)
    800027a4:	02e557bb          	divuw	a5,a0,a4
    800027a8:	f8d40023          	sb	a3,-128(s0)
    800027ac:	10b65e63          	bge	a2,a1,800028c8 <__printf+0x670>
    800027b0:	06300593          	li	a1,99
    800027b4:	02e7f6bb          	remuw	a3,a5,a4
    800027b8:	02069693          	slli	a3,a3,0x20
    800027bc:	0206d693          	srli	a3,a3,0x20
    800027c0:	00dd86b3          	add	a3,s11,a3
    800027c4:	0006c683          	lbu	a3,0(a3)
    800027c8:	02e7d73b          	divuw	a4,a5,a4
    800027cc:	00200793          	li	a5,2
    800027d0:	f8d400a3          	sb	a3,-127(s0)
    800027d4:	bca5ece3          	bltu	a1,a0,800023ac <__printf+0x154>
    800027d8:	ce5ff06f          	j	800024bc <__printf+0x264>
    800027dc:	40e007bb          	negw	a5,a4
    800027e0:	00002d97          	auipc	s11,0x2
    800027e4:	b80d8d93          	addi	s11,s11,-1152 # 80004360 <digits>
    800027e8:	00f7f693          	andi	a3,a5,15
    800027ec:	00dd86b3          	add	a3,s11,a3
    800027f0:	0006c583          	lbu	a1,0(a3)
    800027f4:	ff100613          	li	a2,-15
    800027f8:	0047d69b          	srliw	a3,a5,0x4
    800027fc:	f8b40023          	sb	a1,-128(s0)
    80002800:	0047d59b          	srliw	a1,a5,0x4
    80002804:	0ac75e63          	bge	a4,a2,800028c0 <__printf+0x668>
    80002808:	00f6f693          	andi	a3,a3,15
    8000280c:	00dd86b3          	add	a3,s11,a3
    80002810:	0006c603          	lbu	a2,0(a3)
    80002814:	00f00693          	li	a3,15
    80002818:	0087d79b          	srliw	a5,a5,0x8
    8000281c:	f8c400a3          	sb	a2,-127(s0)
    80002820:	d8b6e4e3          	bltu	a3,a1,800025a8 <__printf+0x350>
    80002824:	00200793          	li	a5,2
    80002828:	e2dff06f          	j	80002654 <__printf+0x3fc>
    8000282c:	00002c97          	auipc	s9,0x2
    80002830:	b14c8c93          	addi	s9,s9,-1260 # 80004340 <CONSOLE_STATUS+0x330>
    80002834:	02800513          	li	a0,40
    80002838:	ef1ff06f          	j	80002728 <__printf+0x4d0>
    8000283c:	00700793          	li	a5,7
    80002840:	00600c93          	li	s9,6
    80002844:	e0dff06f          	j	80002650 <__printf+0x3f8>
    80002848:	00700793          	li	a5,7
    8000284c:	00600c93          	li	s9,6
    80002850:	c69ff06f          	j	800024b8 <__printf+0x260>
    80002854:	00300793          	li	a5,3
    80002858:	00200c93          	li	s9,2
    8000285c:	c5dff06f          	j	800024b8 <__printf+0x260>
    80002860:	00300793          	li	a5,3
    80002864:	00200c93          	li	s9,2
    80002868:	de9ff06f          	j	80002650 <__printf+0x3f8>
    8000286c:	00400793          	li	a5,4
    80002870:	00300c93          	li	s9,3
    80002874:	dddff06f          	j	80002650 <__printf+0x3f8>
    80002878:	00400793          	li	a5,4
    8000287c:	00300c93          	li	s9,3
    80002880:	c39ff06f          	j	800024b8 <__printf+0x260>
    80002884:	00500793          	li	a5,5
    80002888:	00400c93          	li	s9,4
    8000288c:	c2dff06f          	j	800024b8 <__printf+0x260>
    80002890:	00500793          	li	a5,5
    80002894:	00400c93          	li	s9,4
    80002898:	db9ff06f          	j	80002650 <__printf+0x3f8>
    8000289c:	00600793          	li	a5,6
    800028a0:	00500c93          	li	s9,5
    800028a4:	dadff06f          	j	80002650 <__printf+0x3f8>
    800028a8:	00600793          	li	a5,6
    800028ac:	00500c93          	li	s9,5
    800028b0:	c09ff06f          	j	800024b8 <__printf+0x260>
    800028b4:	00800793          	li	a5,8
    800028b8:	00700c93          	li	s9,7
    800028bc:	bfdff06f          	j	800024b8 <__printf+0x260>
    800028c0:	00100793          	li	a5,1
    800028c4:	d91ff06f          	j	80002654 <__printf+0x3fc>
    800028c8:	00100793          	li	a5,1
    800028cc:	bf1ff06f          	j	800024bc <__printf+0x264>
    800028d0:	00900793          	li	a5,9
    800028d4:	00800c93          	li	s9,8
    800028d8:	be1ff06f          	j	800024b8 <__printf+0x260>
    800028dc:	00002517          	auipc	a0,0x2
    800028e0:	a6c50513          	addi	a0,a0,-1428 # 80004348 <CONSOLE_STATUS+0x338>
    800028e4:	00000097          	auipc	ra,0x0
    800028e8:	918080e7          	jalr	-1768(ra) # 800021fc <panic>

00000000800028ec <printfinit>:
    800028ec:	fe010113          	addi	sp,sp,-32
    800028f0:	00813823          	sd	s0,16(sp)
    800028f4:	00913423          	sd	s1,8(sp)
    800028f8:	00113c23          	sd	ra,24(sp)
    800028fc:	02010413          	addi	s0,sp,32
    80002900:	00003497          	auipc	s1,0x3
    80002904:	ed048493          	addi	s1,s1,-304 # 800057d0 <pr>
    80002908:	00048513          	mv	a0,s1
    8000290c:	00002597          	auipc	a1,0x2
    80002910:	a4c58593          	addi	a1,a1,-1460 # 80004358 <CONSOLE_STATUS+0x348>
    80002914:	00000097          	auipc	ra,0x0
    80002918:	5f4080e7          	jalr	1524(ra) # 80002f08 <initlock>
    8000291c:	01813083          	ld	ra,24(sp)
    80002920:	01013403          	ld	s0,16(sp)
    80002924:	0004ac23          	sw	zero,24(s1)
    80002928:	00813483          	ld	s1,8(sp)
    8000292c:	02010113          	addi	sp,sp,32
    80002930:	00008067          	ret

0000000080002934 <uartinit>:
    80002934:	ff010113          	addi	sp,sp,-16
    80002938:	00813423          	sd	s0,8(sp)
    8000293c:	01010413          	addi	s0,sp,16
    80002940:	100007b7          	lui	a5,0x10000
    80002944:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80002948:	f8000713          	li	a4,-128
    8000294c:	00e781a3          	sb	a4,3(a5)
    80002950:	00300713          	li	a4,3
    80002954:	00e78023          	sb	a4,0(a5)
    80002958:	000780a3          	sb	zero,1(a5)
    8000295c:	00e781a3          	sb	a4,3(a5)
    80002960:	00700693          	li	a3,7
    80002964:	00d78123          	sb	a3,2(a5)
    80002968:	00e780a3          	sb	a4,1(a5)
    8000296c:	00813403          	ld	s0,8(sp)
    80002970:	01010113          	addi	sp,sp,16
    80002974:	00008067          	ret

0000000080002978 <uartputc>:
    80002978:	00002797          	auipc	a5,0x2
    8000297c:	c107a783          	lw	a5,-1008(a5) # 80004588 <panicked>
    80002980:	00078463          	beqz	a5,80002988 <uartputc+0x10>
    80002984:	0000006f          	j	80002984 <uartputc+0xc>
    80002988:	fd010113          	addi	sp,sp,-48
    8000298c:	02813023          	sd	s0,32(sp)
    80002990:	00913c23          	sd	s1,24(sp)
    80002994:	01213823          	sd	s2,16(sp)
    80002998:	01313423          	sd	s3,8(sp)
    8000299c:	02113423          	sd	ra,40(sp)
    800029a0:	03010413          	addi	s0,sp,48
    800029a4:	00002917          	auipc	s2,0x2
    800029a8:	bec90913          	addi	s2,s2,-1044 # 80004590 <uart_tx_r>
    800029ac:	00093783          	ld	a5,0(s2)
    800029b0:	00002497          	auipc	s1,0x2
    800029b4:	be848493          	addi	s1,s1,-1048 # 80004598 <uart_tx_w>
    800029b8:	0004b703          	ld	a4,0(s1)
    800029bc:	02078693          	addi	a3,a5,32
    800029c0:	00050993          	mv	s3,a0
    800029c4:	02e69c63          	bne	a3,a4,800029fc <uartputc+0x84>
    800029c8:	00001097          	auipc	ra,0x1
    800029cc:	834080e7          	jalr	-1996(ra) # 800031fc <push_on>
    800029d0:	00093783          	ld	a5,0(s2)
    800029d4:	0004b703          	ld	a4,0(s1)
    800029d8:	02078793          	addi	a5,a5,32
    800029dc:	00e79463          	bne	a5,a4,800029e4 <uartputc+0x6c>
    800029e0:	0000006f          	j	800029e0 <uartputc+0x68>
    800029e4:	00001097          	auipc	ra,0x1
    800029e8:	88c080e7          	jalr	-1908(ra) # 80003270 <pop_on>
    800029ec:	00093783          	ld	a5,0(s2)
    800029f0:	0004b703          	ld	a4,0(s1)
    800029f4:	02078693          	addi	a3,a5,32
    800029f8:	fce688e3          	beq	a3,a4,800029c8 <uartputc+0x50>
    800029fc:	01f77693          	andi	a3,a4,31
    80002a00:	00003597          	auipc	a1,0x3
    80002a04:	df058593          	addi	a1,a1,-528 # 800057f0 <uart_tx_buf>
    80002a08:	00d586b3          	add	a3,a1,a3
    80002a0c:	00170713          	addi	a4,a4,1
    80002a10:	01368023          	sb	s3,0(a3)
    80002a14:	00e4b023          	sd	a4,0(s1)
    80002a18:	10000637          	lui	a2,0x10000
    80002a1c:	02f71063          	bne	a4,a5,80002a3c <uartputc+0xc4>
    80002a20:	0340006f          	j	80002a54 <uartputc+0xdc>
    80002a24:	00074703          	lbu	a4,0(a4)
    80002a28:	00f93023          	sd	a5,0(s2)
    80002a2c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80002a30:	00093783          	ld	a5,0(s2)
    80002a34:	0004b703          	ld	a4,0(s1)
    80002a38:	00f70e63          	beq	a4,a5,80002a54 <uartputc+0xdc>
    80002a3c:	00564683          	lbu	a3,5(a2)
    80002a40:	01f7f713          	andi	a4,a5,31
    80002a44:	00e58733          	add	a4,a1,a4
    80002a48:	0206f693          	andi	a3,a3,32
    80002a4c:	00178793          	addi	a5,a5,1
    80002a50:	fc069ae3          	bnez	a3,80002a24 <uartputc+0xac>
    80002a54:	02813083          	ld	ra,40(sp)
    80002a58:	02013403          	ld	s0,32(sp)
    80002a5c:	01813483          	ld	s1,24(sp)
    80002a60:	01013903          	ld	s2,16(sp)
    80002a64:	00813983          	ld	s3,8(sp)
    80002a68:	03010113          	addi	sp,sp,48
    80002a6c:	00008067          	ret

0000000080002a70 <uartputc_sync>:
    80002a70:	ff010113          	addi	sp,sp,-16
    80002a74:	00813423          	sd	s0,8(sp)
    80002a78:	01010413          	addi	s0,sp,16
    80002a7c:	00002717          	auipc	a4,0x2
    80002a80:	b0c72703          	lw	a4,-1268(a4) # 80004588 <panicked>
    80002a84:	02071663          	bnez	a4,80002ab0 <uartputc_sync+0x40>
    80002a88:	00050793          	mv	a5,a0
    80002a8c:	100006b7          	lui	a3,0x10000
    80002a90:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80002a94:	02077713          	andi	a4,a4,32
    80002a98:	fe070ce3          	beqz	a4,80002a90 <uartputc_sync+0x20>
    80002a9c:	0ff7f793          	andi	a5,a5,255
    80002aa0:	00f68023          	sb	a5,0(a3)
    80002aa4:	00813403          	ld	s0,8(sp)
    80002aa8:	01010113          	addi	sp,sp,16
    80002aac:	00008067          	ret
    80002ab0:	0000006f          	j	80002ab0 <uartputc_sync+0x40>

0000000080002ab4 <uartstart>:
    80002ab4:	ff010113          	addi	sp,sp,-16
    80002ab8:	00813423          	sd	s0,8(sp)
    80002abc:	01010413          	addi	s0,sp,16
    80002ac0:	00002617          	auipc	a2,0x2
    80002ac4:	ad060613          	addi	a2,a2,-1328 # 80004590 <uart_tx_r>
    80002ac8:	00002517          	auipc	a0,0x2
    80002acc:	ad050513          	addi	a0,a0,-1328 # 80004598 <uart_tx_w>
    80002ad0:	00063783          	ld	a5,0(a2)
    80002ad4:	00053703          	ld	a4,0(a0)
    80002ad8:	04f70263          	beq	a4,a5,80002b1c <uartstart+0x68>
    80002adc:	100005b7          	lui	a1,0x10000
    80002ae0:	00003817          	auipc	a6,0x3
    80002ae4:	d1080813          	addi	a6,a6,-752 # 800057f0 <uart_tx_buf>
    80002ae8:	01c0006f          	j	80002b04 <uartstart+0x50>
    80002aec:	0006c703          	lbu	a4,0(a3)
    80002af0:	00f63023          	sd	a5,0(a2)
    80002af4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002af8:	00063783          	ld	a5,0(a2)
    80002afc:	00053703          	ld	a4,0(a0)
    80002b00:	00f70e63          	beq	a4,a5,80002b1c <uartstart+0x68>
    80002b04:	01f7f713          	andi	a4,a5,31
    80002b08:	00e806b3          	add	a3,a6,a4
    80002b0c:	0055c703          	lbu	a4,5(a1)
    80002b10:	00178793          	addi	a5,a5,1
    80002b14:	02077713          	andi	a4,a4,32
    80002b18:	fc071ae3          	bnez	a4,80002aec <uartstart+0x38>
    80002b1c:	00813403          	ld	s0,8(sp)
    80002b20:	01010113          	addi	sp,sp,16
    80002b24:	00008067          	ret

0000000080002b28 <uartgetc>:
    80002b28:	ff010113          	addi	sp,sp,-16
    80002b2c:	00813423          	sd	s0,8(sp)
    80002b30:	01010413          	addi	s0,sp,16
    80002b34:	10000737          	lui	a4,0x10000
    80002b38:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80002b3c:	0017f793          	andi	a5,a5,1
    80002b40:	00078c63          	beqz	a5,80002b58 <uartgetc+0x30>
    80002b44:	00074503          	lbu	a0,0(a4)
    80002b48:	0ff57513          	andi	a0,a0,255
    80002b4c:	00813403          	ld	s0,8(sp)
    80002b50:	01010113          	addi	sp,sp,16
    80002b54:	00008067          	ret
    80002b58:	fff00513          	li	a0,-1
    80002b5c:	ff1ff06f          	j	80002b4c <uartgetc+0x24>

0000000080002b60 <uartintr>:
    80002b60:	100007b7          	lui	a5,0x10000
    80002b64:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80002b68:	0017f793          	andi	a5,a5,1
    80002b6c:	0a078463          	beqz	a5,80002c14 <uartintr+0xb4>
    80002b70:	fe010113          	addi	sp,sp,-32
    80002b74:	00813823          	sd	s0,16(sp)
    80002b78:	00913423          	sd	s1,8(sp)
    80002b7c:	00113c23          	sd	ra,24(sp)
    80002b80:	02010413          	addi	s0,sp,32
    80002b84:	100004b7          	lui	s1,0x10000
    80002b88:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80002b8c:	0ff57513          	andi	a0,a0,255
    80002b90:	fffff097          	auipc	ra,0xfffff
    80002b94:	534080e7          	jalr	1332(ra) # 800020c4 <consoleintr>
    80002b98:	0054c783          	lbu	a5,5(s1)
    80002b9c:	0017f793          	andi	a5,a5,1
    80002ba0:	fe0794e3          	bnez	a5,80002b88 <uartintr+0x28>
    80002ba4:	00002617          	auipc	a2,0x2
    80002ba8:	9ec60613          	addi	a2,a2,-1556 # 80004590 <uart_tx_r>
    80002bac:	00002517          	auipc	a0,0x2
    80002bb0:	9ec50513          	addi	a0,a0,-1556 # 80004598 <uart_tx_w>
    80002bb4:	00063783          	ld	a5,0(a2)
    80002bb8:	00053703          	ld	a4,0(a0)
    80002bbc:	04f70263          	beq	a4,a5,80002c00 <uartintr+0xa0>
    80002bc0:	100005b7          	lui	a1,0x10000
    80002bc4:	00003817          	auipc	a6,0x3
    80002bc8:	c2c80813          	addi	a6,a6,-980 # 800057f0 <uart_tx_buf>
    80002bcc:	01c0006f          	j	80002be8 <uartintr+0x88>
    80002bd0:	0006c703          	lbu	a4,0(a3)
    80002bd4:	00f63023          	sd	a5,0(a2)
    80002bd8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002bdc:	00063783          	ld	a5,0(a2)
    80002be0:	00053703          	ld	a4,0(a0)
    80002be4:	00f70e63          	beq	a4,a5,80002c00 <uartintr+0xa0>
    80002be8:	01f7f713          	andi	a4,a5,31
    80002bec:	00e806b3          	add	a3,a6,a4
    80002bf0:	0055c703          	lbu	a4,5(a1)
    80002bf4:	00178793          	addi	a5,a5,1
    80002bf8:	02077713          	andi	a4,a4,32
    80002bfc:	fc071ae3          	bnez	a4,80002bd0 <uartintr+0x70>
    80002c00:	01813083          	ld	ra,24(sp)
    80002c04:	01013403          	ld	s0,16(sp)
    80002c08:	00813483          	ld	s1,8(sp)
    80002c0c:	02010113          	addi	sp,sp,32
    80002c10:	00008067          	ret
    80002c14:	00002617          	auipc	a2,0x2
    80002c18:	97c60613          	addi	a2,a2,-1668 # 80004590 <uart_tx_r>
    80002c1c:	00002517          	auipc	a0,0x2
    80002c20:	97c50513          	addi	a0,a0,-1668 # 80004598 <uart_tx_w>
    80002c24:	00063783          	ld	a5,0(a2)
    80002c28:	00053703          	ld	a4,0(a0)
    80002c2c:	04f70263          	beq	a4,a5,80002c70 <uartintr+0x110>
    80002c30:	100005b7          	lui	a1,0x10000
    80002c34:	00003817          	auipc	a6,0x3
    80002c38:	bbc80813          	addi	a6,a6,-1092 # 800057f0 <uart_tx_buf>
    80002c3c:	01c0006f          	j	80002c58 <uartintr+0xf8>
    80002c40:	0006c703          	lbu	a4,0(a3)
    80002c44:	00f63023          	sd	a5,0(a2)
    80002c48:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002c4c:	00063783          	ld	a5,0(a2)
    80002c50:	00053703          	ld	a4,0(a0)
    80002c54:	02f70063          	beq	a4,a5,80002c74 <uartintr+0x114>
    80002c58:	01f7f713          	andi	a4,a5,31
    80002c5c:	00e806b3          	add	a3,a6,a4
    80002c60:	0055c703          	lbu	a4,5(a1)
    80002c64:	00178793          	addi	a5,a5,1
    80002c68:	02077713          	andi	a4,a4,32
    80002c6c:	fc071ae3          	bnez	a4,80002c40 <uartintr+0xe0>
    80002c70:	00008067          	ret
    80002c74:	00008067          	ret

0000000080002c78 <kinit>:
    80002c78:	fc010113          	addi	sp,sp,-64
    80002c7c:	02913423          	sd	s1,40(sp)
    80002c80:	fffff7b7          	lui	a5,0xfffff
    80002c84:	00004497          	auipc	s1,0x4
    80002c88:	b8b48493          	addi	s1,s1,-1141 # 8000680f <end+0xfff>
    80002c8c:	02813823          	sd	s0,48(sp)
    80002c90:	01313c23          	sd	s3,24(sp)
    80002c94:	00f4f4b3          	and	s1,s1,a5
    80002c98:	02113c23          	sd	ra,56(sp)
    80002c9c:	03213023          	sd	s2,32(sp)
    80002ca0:	01413823          	sd	s4,16(sp)
    80002ca4:	01513423          	sd	s5,8(sp)
    80002ca8:	04010413          	addi	s0,sp,64
    80002cac:	000017b7          	lui	a5,0x1
    80002cb0:	01100993          	li	s3,17
    80002cb4:	00f487b3          	add	a5,s1,a5
    80002cb8:	01b99993          	slli	s3,s3,0x1b
    80002cbc:	06f9e063          	bltu	s3,a5,80002d1c <kinit+0xa4>
    80002cc0:	00003a97          	auipc	s5,0x3
    80002cc4:	b50a8a93          	addi	s5,s5,-1200 # 80005810 <end>
    80002cc8:	0754ec63          	bltu	s1,s5,80002d40 <kinit+0xc8>
    80002ccc:	0734fa63          	bgeu	s1,s3,80002d40 <kinit+0xc8>
    80002cd0:	00088a37          	lui	s4,0x88
    80002cd4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80002cd8:	00002917          	auipc	s2,0x2
    80002cdc:	8c890913          	addi	s2,s2,-1848 # 800045a0 <kmem>
    80002ce0:	00ca1a13          	slli	s4,s4,0xc
    80002ce4:	0140006f          	j	80002cf8 <kinit+0x80>
    80002ce8:	000017b7          	lui	a5,0x1
    80002cec:	00f484b3          	add	s1,s1,a5
    80002cf0:	0554e863          	bltu	s1,s5,80002d40 <kinit+0xc8>
    80002cf4:	0534f663          	bgeu	s1,s3,80002d40 <kinit+0xc8>
    80002cf8:	00001637          	lui	a2,0x1
    80002cfc:	00100593          	li	a1,1
    80002d00:	00048513          	mv	a0,s1
    80002d04:	00000097          	auipc	ra,0x0
    80002d08:	5e4080e7          	jalr	1508(ra) # 800032e8 <__memset>
    80002d0c:	00093783          	ld	a5,0(s2)
    80002d10:	00f4b023          	sd	a5,0(s1)
    80002d14:	00993023          	sd	s1,0(s2)
    80002d18:	fd4498e3          	bne	s1,s4,80002ce8 <kinit+0x70>
    80002d1c:	03813083          	ld	ra,56(sp)
    80002d20:	03013403          	ld	s0,48(sp)
    80002d24:	02813483          	ld	s1,40(sp)
    80002d28:	02013903          	ld	s2,32(sp)
    80002d2c:	01813983          	ld	s3,24(sp)
    80002d30:	01013a03          	ld	s4,16(sp)
    80002d34:	00813a83          	ld	s5,8(sp)
    80002d38:	04010113          	addi	sp,sp,64
    80002d3c:	00008067          	ret
    80002d40:	00001517          	auipc	a0,0x1
    80002d44:	63850513          	addi	a0,a0,1592 # 80004378 <digits+0x18>
    80002d48:	fffff097          	auipc	ra,0xfffff
    80002d4c:	4b4080e7          	jalr	1204(ra) # 800021fc <panic>

0000000080002d50 <freerange>:
    80002d50:	fc010113          	addi	sp,sp,-64
    80002d54:	000017b7          	lui	a5,0x1
    80002d58:	02913423          	sd	s1,40(sp)
    80002d5c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80002d60:	009504b3          	add	s1,a0,s1
    80002d64:	fffff537          	lui	a0,0xfffff
    80002d68:	02813823          	sd	s0,48(sp)
    80002d6c:	02113c23          	sd	ra,56(sp)
    80002d70:	03213023          	sd	s2,32(sp)
    80002d74:	01313c23          	sd	s3,24(sp)
    80002d78:	01413823          	sd	s4,16(sp)
    80002d7c:	01513423          	sd	s5,8(sp)
    80002d80:	01613023          	sd	s6,0(sp)
    80002d84:	04010413          	addi	s0,sp,64
    80002d88:	00a4f4b3          	and	s1,s1,a0
    80002d8c:	00f487b3          	add	a5,s1,a5
    80002d90:	06f5e463          	bltu	a1,a5,80002df8 <freerange+0xa8>
    80002d94:	00003a97          	auipc	s5,0x3
    80002d98:	a7ca8a93          	addi	s5,s5,-1412 # 80005810 <end>
    80002d9c:	0954e263          	bltu	s1,s5,80002e20 <freerange+0xd0>
    80002da0:	01100993          	li	s3,17
    80002da4:	01b99993          	slli	s3,s3,0x1b
    80002da8:	0734fc63          	bgeu	s1,s3,80002e20 <freerange+0xd0>
    80002dac:	00058a13          	mv	s4,a1
    80002db0:	00001917          	auipc	s2,0x1
    80002db4:	7f090913          	addi	s2,s2,2032 # 800045a0 <kmem>
    80002db8:	00002b37          	lui	s6,0x2
    80002dbc:	0140006f          	j	80002dd0 <freerange+0x80>
    80002dc0:	000017b7          	lui	a5,0x1
    80002dc4:	00f484b3          	add	s1,s1,a5
    80002dc8:	0554ec63          	bltu	s1,s5,80002e20 <freerange+0xd0>
    80002dcc:	0534fa63          	bgeu	s1,s3,80002e20 <freerange+0xd0>
    80002dd0:	00001637          	lui	a2,0x1
    80002dd4:	00100593          	li	a1,1
    80002dd8:	00048513          	mv	a0,s1
    80002ddc:	00000097          	auipc	ra,0x0
    80002de0:	50c080e7          	jalr	1292(ra) # 800032e8 <__memset>
    80002de4:	00093703          	ld	a4,0(s2)
    80002de8:	016487b3          	add	a5,s1,s6
    80002dec:	00e4b023          	sd	a4,0(s1)
    80002df0:	00993023          	sd	s1,0(s2)
    80002df4:	fcfa76e3          	bgeu	s4,a5,80002dc0 <freerange+0x70>
    80002df8:	03813083          	ld	ra,56(sp)
    80002dfc:	03013403          	ld	s0,48(sp)
    80002e00:	02813483          	ld	s1,40(sp)
    80002e04:	02013903          	ld	s2,32(sp)
    80002e08:	01813983          	ld	s3,24(sp)
    80002e0c:	01013a03          	ld	s4,16(sp)
    80002e10:	00813a83          	ld	s5,8(sp)
    80002e14:	00013b03          	ld	s6,0(sp)
    80002e18:	04010113          	addi	sp,sp,64
    80002e1c:	00008067          	ret
    80002e20:	00001517          	auipc	a0,0x1
    80002e24:	55850513          	addi	a0,a0,1368 # 80004378 <digits+0x18>
    80002e28:	fffff097          	auipc	ra,0xfffff
    80002e2c:	3d4080e7          	jalr	980(ra) # 800021fc <panic>

0000000080002e30 <kfree>:
    80002e30:	fe010113          	addi	sp,sp,-32
    80002e34:	00813823          	sd	s0,16(sp)
    80002e38:	00113c23          	sd	ra,24(sp)
    80002e3c:	00913423          	sd	s1,8(sp)
    80002e40:	02010413          	addi	s0,sp,32
    80002e44:	03451793          	slli	a5,a0,0x34
    80002e48:	04079c63          	bnez	a5,80002ea0 <kfree+0x70>
    80002e4c:	00003797          	auipc	a5,0x3
    80002e50:	9c478793          	addi	a5,a5,-1596 # 80005810 <end>
    80002e54:	00050493          	mv	s1,a0
    80002e58:	04f56463          	bltu	a0,a5,80002ea0 <kfree+0x70>
    80002e5c:	01100793          	li	a5,17
    80002e60:	01b79793          	slli	a5,a5,0x1b
    80002e64:	02f57e63          	bgeu	a0,a5,80002ea0 <kfree+0x70>
    80002e68:	00001637          	lui	a2,0x1
    80002e6c:	00100593          	li	a1,1
    80002e70:	00000097          	auipc	ra,0x0
    80002e74:	478080e7          	jalr	1144(ra) # 800032e8 <__memset>
    80002e78:	00001797          	auipc	a5,0x1
    80002e7c:	72878793          	addi	a5,a5,1832 # 800045a0 <kmem>
    80002e80:	0007b703          	ld	a4,0(a5)
    80002e84:	01813083          	ld	ra,24(sp)
    80002e88:	01013403          	ld	s0,16(sp)
    80002e8c:	00e4b023          	sd	a4,0(s1)
    80002e90:	0097b023          	sd	s1,0(a5)
    80002e94:	00813483          	ld	s1,8(sp)
    80002e98:	02010113          	addi	sp,sp,32
    80002e9c:	00008067          	ret
    80002ea0:	00001517          	auipc	a0,0x1
    80002ea4:	4d850513          	addi	a0,a0,1240 # 80004378 <digits+0x18>
    80002ea8:	fffff097          	auipc	ra,0xfffff
    80002eac:	354080e7          	jalr	852(ra) # 800021fc <panic>

0000000080002eb0 <kalloc>:
    80002eb0:	fe010113          	addi	sp,sp,-32
    80002eb4:	00813823          	sd	s0,16(sp)
    80002eb8:	00913423          	sd	s1,8(sp)
    80002ebc:	00113c23          	sd	ra,24(sp)
    80002ec0:	02010413          	addi	s0,sp,32
    80002ec4:	00001797          	auipc	a5,0x1
    80002ec8:	6dc78793          	addi	a5,a5,1756 # 800045a0 <kmem>
    80002ecc:	0007b483          	ld	s1,0(a5)
    80002ed0:	02048063          	beqz	s1,80002ef0 <kalloc+0x40>
    80002ed4:	0004b703          	ld	a4,0(s1)
    80002ed8:	00001637          	lui	a2,0x1
    80002edc:	00500593          	li	a1,5
    80002ee0:	00048513          	mv	a0,s1
    80002ee4:	00e7b023          	sd	a4,0(a5)
    80002ee8:	00000097          	auipc	ra,0x0
    80002eec:	400080e7          	jalr	1024(ra) # 800032e8 <__memset>
    80002ef0:	01813083          	ld	ra,24(sp)
    80002ef4:	01013403          	ld	s0,16(sp)
    80002ef8:	00048513          	mv	a0,s1
    80002efc:	00813483          	ld	s1,8(sp)
    80002f00:	02010113          	addi	sp,sp,32
    80002f04:	00008067          	ret

0000000080002f08 <initlock>:
    80002f08:	ff010113          	addi	sp,sp,-16
    80002f0c:	00813423          	sd	s0,8(sp)
    80002f10:	01010413          	addi	s0,sp,16
    80002f14:	00813403          	ld	s0,8(sp)
    80002f18:	00b53423          	sd	a1,8(a0)
    80002f1c:	00052023          	sw	zero,0(a0)
    80002f20:	00053823          	sd	zero,16(a0)
    80002f24:	01010113          	addi	sp,sp,16
    80002f28:	00008067          	ret

0000000080002f2c <acquire>:
    80002f2c:	fe010113          	addi	sp,sp,-32
    80002f30:	00813823          	sd	s0,16(sp)
    80002f34:	00913423          	sd	s1,8(sp)
    80002f38:	00113c23          	sd	ra,24(sp)
    80002f3c:	01213023          	sd	s2,0(sp)
    80002f40:	02010413          	addi	s0,sp,32
    80002f44:	00050493          	mv	s1,a0
    80002f48:	10002973          	csrr	s2,sstatus
    80002f4c:	100027f3          	csrr	a5,sstatus
    80002f50:	ffd7f793          	andi	a5,a5,-3
    80002f54:	10079073          	csrw	sstatus,a5
    80002f58:	fffff097          	auipc	ra,0xfffff
    80002f5c:	8e8080e7          	jalr	-1816(ra) # 80001840 <mycpu>
    80002f60:	07852783          	lw	a5,120(a0)
    80002f64:	06078e63          	beqz	a5,80002fe0 <acquire+0xb4>
    80002f68:	fffff097          	auipc	ra,0xfffff
    80002f6c:	8d8080e7          	jalr	-1832(ra) # 80001840 <mycpu>
    80002f70:	07852783          	lw	a5,120(a0)
    80002f74:	0004a703          	lw	a4,0(s1)
    80002f78:	0017879b          	addiw	a5,a5,1
    80002f7c:	06f52c23          	sw	a5,120(a0)
    80002f80:	04071063          	bnez	a4,80002fc0 <acquire+0x94>
    80002f84:	00100713          	li	a4,1
    80002f88:	00070793          	mv	a5,a4
    80002f8c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80002f90:	0007879b          	sext.w	a5,a5
    80002f94:	fe079ae3          	bnez	a5,80002f88 <acquire+0x5c>
    80002f98:	0ff0000f          	fence
    80002f9c:	fffff097          	auipc	ra,0xfffff
    80002fa0:	8a4080e7          	jalr	-1884(ra) # 80001840 <mycpu>
    80002fa4:	01813083          	ld	ra,24(sp)
    80002fa8:	01013403          	ld	s0,16(sp)
    80002fac:	00a4b823          	sd	a0,16(s1)
    80002fb0:	00013903          	ld	s2,0(sp)
    80002fb4:	00813483          	ld	s1,8(sp)
    80002fb8:	02010113          	addi	sp,sp,32
    80002fbc:	00008067          	ret
    80002fc0:	0104b903          	ld	s2,16(s1)
    80002fc4:	fffff097          	auipc	ra,0xfffff
    80002fc8:	87c080e7          	jalr	-1924(ra) # 80001840 <mycpu>
    80002fcc:	faa91ce3          	bne	s2,a0,80002f84 <acquire+0x58>
    80002fd0:	00001517          	auipc	a0,0x1
    80002fd4:	3b050513          	addi	a0,a0,944 # 80004380 <digits+0x20>
    80002fd8:	fffff097          	auipc	ra,0xfffff
    80002fdc:	224080e7          	jalr	548(ra) # 800021fc <panic>
    80002fe0:	00195913          	srli	s2,s2,0x1
    80002fe4:	fffff097          	auipc	ra,0xfffff
    80002fe8:	85c080e7          	jalr	-1956(ra) # 80001840 <mycpu>
    80002fec:	00197913          	andi	s2,s2,1
    80002ff0:	07252e23          	sw	s2,124(a0)
    80002ff4:	f75ff06f          	j	80002f68 <acquire+0x3c>

0000000080002ff8 <release>:
    80002ff8:	fe010113          	addi	sp,sp,-32
    80002ffc:	00813823          	sd	s0,16(sp)
    80003000:	00113c23          	sd	ra,24(sp)
    80003004:	00913423          	sd	s1,8(sp)
    80003008:	01213023          	sd	s2,0(sp)
    8000300c:	02010413          	addi	s0,sp,32
    80003010:	00052783          	lw	a5,0(a0)
    80003014:	00079a63          	bnez	a5,80003028 <release+0x30>
    80003018:	00001517          	auipc	a0,0x1
    8000301c:	37050513          	addi	a0,a0,880 # 80004388 <digits+0x28>
    80003020:	fffff097          	auipc	ra,0xfffff
    80003024:	1dc080e7          	jalr	476(ra) # 800021fc <panic>
    80003028:	01053903          	ld	s2,16(a0)
    8000302c:	00050493          	mv	s1,a0
    80003030:	fffff097          	auipc	ra,0xfffff
    80003034:	810080e7          	jalr	-2032(ra) # 80001840 <mycpu>
    80003038:	fea910e3          	bne	s2,a0,80003018 <release+0x20>
    8000303c:	0004b823          	sd	zero,16(s1)
    80003040:	0ff0000f          	fence
    80003044:	0f50000f          	fence	iorw,ow
    80003048:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000304c:	ffffe097          	auipc	ra,0xffffe
    80003050:	7f4080e7          	jalr	2036(ra) # 80001840 <mycpu>
    80003054:	100027f3          	csrr	a5,sstatus
    80003058:	0027f793          	andi	a5,a5,2
    8000305c:	04079a63          	bnez	a5,800030b0 <release+0xb8>
    80003060:	07852783          	lw	a5,120(a0)
    80003064:	02f05e63          	blez	a5,800030a0 <release+0xa8>
    80003068:	fff7871b          	addiw	a4,a5,-1
    8000306c:	06e52c23          	sw	a4,120(a0)
    80003070:	00071c63          	bnez	a4,80003088 <release+0x90>
    80003074:	07c52783          	lw	a5,124(a0)
    80003078:	00078863          	beqz	a5,80003088 <release+0x90>
    8000307c:	100027f3          	csrr	a5,sstatus
    80003080:	0027e793          	ori	a5,a5,2
    80003084:	10079073          	csrw	sstatus,a5
    80003088:	01813083          	ld	ra,24(sp)
    8000308c:	01013403          	ld	s0,16(sp)
    80003090:	00813483          	ld	s1,8(sp)
    80003094:	00013903          	ld	s2,0(sp)
    80003098:	02010113          	addi	sp,sp,32
    8000309c:	00008067          	ret
    800030a0:	00001517          	auipc	a0,0x1
    800030a4:	30850513          	addi	a0,a0,776 # 800043a8 <digits+0x48>
    800030a8:	fffff097          	auipc	ra,0xfffff
    800030ac:	154080e7          	jalr	340(ra) # 800021fc <panic>
    800030b0:	00001517          	auipc	a0,0x1
    800030b4:	2e050513          	addi	a0,a0,736 # 80004390 <digits+0x30>
    800030b8:	fffff097          	auipc	ra,0xfffff
    800030bc:	144080e7          	jalr	324(ra) # 800021fc <panic>

00000000800030c0 <holding>:
    800030c0:	00052783          	lw	a5,0(a0)
    800030c4:	00079663          	bnez	a5,800030d0 <holding+0x10>
    800030c8:	00000513          	li	a0,0
    800030cc:	00008067          	ret
    800030d0:	fe010113          	addi	sp,sp,-32
    800030d4:	00813823          	sd	s0,16(sp)
    800030d8:	00913423          	sd	s1,8(sp)
    800030dc:	00113c23          	sd	ra,24(sp)
    800030e0:	02010413          	addi	s0,sp,32
    800030e4:	01053483          	ld	s1,16(a0)
    800030e8:	ffffe097          	auipc	ra,0xffffe
    800030ec:	758080e7          	jalr	1880(ra) # 80001840 <mycpu>
    800030f0:	01813083          	ld	ra,24(sp)
    800030f4:	01013403          	ld	s0,16(sp)
    800030f8:	40a48533          	sub	a0,s1,a0
    800030fc:	00153513          	seqz	a0,a0
    80003100:	00813483          	ld	s1,8(sp)
    80003104:	02010113          	addi	sp,sp,32
    80003108:	00008067          	ret

000000008000310c <push_off>:
    8000310c:	fe010113          	addi	sp,sp,-32
    80003110:	00813823          	sd	s0,16(sp)
    80003114:	00113c23          	sd	ra,24(sp)
    80003118:	00913423          	sd	s1,8(sp)
    8000311c:	02010413          	addi	s0,sp,32
    80003120:	100024f3          	csrr	s1,sstatus
    80003124:	100027f3          	csrr	a5,sstatus
    80003128:	ffd7f793          	andi	a5,a5,-3
    8000312c:	10079073          	csrw	sstatus,a5
    80003130:	ffffe097          	auipc	ra,0xffffe
    80003134:	710080e7          	jalr	1808(ra) # 80001840 <mycpu>
    80003138:	07852783          	lw	a5,120(a0)
    8000313c:	02078663          	beqz	a5,80003168 <push_off+0x5c>
    80003140:	ffffe097          	auipc	ra,0xffffe
    80003144:	700080e7          	jalr	1792(ra) # 80001840 <mycpu>
    80003148:	07852783          	lw	a5,120(a0)
    8000314c:	01813083          	ld	ra,24(sp)
    80003150:	01013403          	ld	s0,16(sp)
    80003154:	0017879b          	addiw	a5,a5,1
    80003158:	06f52c23          	sw	a5,120(a0)
    8000315c:	00813483          	ld	s1,8(sp)
    80003160:	02010113          	addi	sp,sp,32
    80003164:	00008067          	ret
    80003168:	0014d493          	srli	s1,s1,0x1
    8000316c:	ffffe097          	auipc	ra,0xffffe
    80003170:	6d4080e7          	jalr	1748(ra) # 80001840 <mycpu>
    80003174:	0014f493          	andi	s1,s1,1
    80003178:	06952e23          	sw	s1,124(a0)
    8000317c:	fc5ff06f          	j	80003140 <push_off+0x34>

0000000080003180 <pop_off>:
    80003180:	ff010113          	addi	sp,sp,-16
    80003184:	00813023          	sd	s0,0(sp)
    80003188:	00113423          	sd	ra,8(sp)
    8000318c:	01010413          	addi	s0,sp,16
    80003190:	ffffe097          	auipc	ra,0xffffe
    80003194:	6b0080e7          	jalr	1712(ra) # 80001840 <mycpu>
    80003198:	100027f3          	csrr	a5,sstatus
    8000319c:	0027f793          	andi	a5,a5,2
    800031a0:	04079663          	bnez	a5,800031ec <pop_off+0x6c>
    800031a4:	07852783          	lw	a5,120(a0)
    800031a8:	02f05a63          	blez	a5,800031dc <pop_off+0x5c>
    800031ac:	fff7871b          	addiw	a4,a5,-1
    800031b0:	06e52c23          	sw	a4,120(a0)
    800031b4:	00071c63          	bnez	a4,800031cc <pop_off+0x4c>
    800031b8:	07c52783          	lw	a5,124(a0)
    800031bc:	00078863          	beqz	a5,800031cc <pop_off+0x4c>
    800031c0:	100027f3          	csrr	a5,sstatus
    800031c4:	0027e793          	ori	a5,a5,2
    800031c8:	10079073          	csrw	sstatus,a5
    800031cc:	00813083          	ld	ra,8(sp)
    800031d0:	00013403          	ld	s0,0(sp)
    800031d4:	01010113          	addi	sp,sp,16
    800031d8:	00008067          	ret
    800031dc:	00001517          	auipc	a0,0x1
    800031e0:	1cc50513          	addi	a0,a0,460 # 800043a8 <digits+0x48>
    800031e4:	fffff097          	auipc	ra,0xfffff
    800031e8:	018080e7          	jalr	24(ra) # 800021fc <panic>
    800031ec:	00001517          	auipc	a0,0x1
    800031f0:	1a450513          	addi	a0,a0,420 # 80004390 <digits+0x30>
    800031f4:	fffff097          	auipc	ra,0xfffff
    800031f8:	008080e7          	jalr	8(ra) # 800021fc <panic>

00000000800031fc <push_on>:
    800031fc:	fe010113          	addi	sp,sp,-32
    80003200:	00813823          	sd	s0,16(sp)
    80003204:	00113c23          	sd	ra,24(sp)
    80003208:	00913423          	sd	s1,8(sp)
    8000320c:	02010413          	addi	s0,sp,32
    80003210:	100024f3          	csrr	s1,sstatus
    80003214:	100027f3          	csrr	a5,sstatus
    80003218:	0027e793          	ori	a5,a5,2
    8000321c:	10079073          	csrw	sstatus,a5
    80003220:	ffffe097          	auipc	ra,0xffffe
    80003224:	620080e7          	jalr	1568(ra) # 80001840 <mycpu>
    80003228:	07852783          	lw	a5,120(a0)
    8000322c:	02078663          	beqz	a5,80003258 <push_on+0x5c>
    80003230:	ffffe097          	auipc	ra,0xffffe
    80003234:	610080e7          	jalr	1552(ra) # 80001840 <mycpu>
    80003238:	07852783          	lw	a5,120(a0)
    8000323c:	01813083          	ld	ra,24(sp)
    80003240:	01013403          	ld	s0,16(sp)
    80003244:	0017879b          	addiw	a5,a5,1
    80003248:	06f52c23          	sw	a5,120(a0)
    8000324c:	00813483          	ld	s1,8(sp)
    80003250:	02010113          	addi	sp,sp,32
    80003254:	00008067          	ret
    80003258:	0014d493          	srli	s1,s1,0x1
    8000325c:	ffffe097          	auipc	ra,0xffffe
    80003260:	5e4080e7          	jalr	1508(ra) # 80001840 <mycpu>
    80003264:	0014f493          	andi	s1,s1,1
    80003268:	06952e23          	sw	s1,124(a0)
    8000326c:	fc5ff06f          	j	80003230 <push_on+0x34>

0000000080003270 <pop_on>:
    80003270:	ff010113          	addi	sp,sp,-16
    80003274:	00813023          	sd	s0,0(sp)
    80003278:	00113423          	sd	ra,8(sp)
    8000327c:	01010413          	addi	s0,sp,16
    80003280:	ffffe097          	auipc	ra,0xffffe
    80003284:	5c0080e7          	jalr	1472(ra) # 80001840 <mycpu>
    80003288:	100027f3          	csrr	a5,sstatus
    8000328c:	0027f793          	andi	a5,a5,2
    80003290:	04078463          	beqz	a5,800032d8 <pop_on+0x68>
    80003294:	07852783          	lw	a5,120(a0)
    80003298:	02f05863          	blez	a5,800032c8 <pop_on+0x58>
    8000329c:	fff7879b          	addiw	a5,a5,-1
    800032a0:	06f52c23          	sw	a5,120(a0)
    800032a4:	07853783          	ld	a5,120(a0)
    800032a8:	00079863          	bnez	a5,800032b8 <pop_on+0x48>
    800032ac:	100027f3          	csrr	a5,sstatus
    800032b0:	ffd7f793          	andi	a5,a5,-3
    800032b4:	10079073          	csrw	sstatus,a5
    800032b8:	00813083          	ld	ra,8(sp)
    800032bc:	00013403          	ld	s0,0(sp)
    800032c0:	01010113          	addi	sp,sp,16
    800032c4:	00008067          	ret
    800032c8:	00001517          	auipc	a0,0x1
    800032cc:	10850513          	addi	a0,a0,264 # 800043d0 <digits+0x70>
    800032d0:	fffff097          	auipc	ra,0xfffff
    800032d4:	f2c080e7          	jalr	-212(ra) # 800021fc <panic>
    800032d8:	00001517          	auipc	a0,0x1
    800032dc:	0d850513          	addi	a0,a0,216 # 800043b0 <digits+0x50>
    800032e0:	fffff097          	auipc	ra,0xfffff
    800032e4:	f1c080e7          	jalr	-228(ra) # 800021fc <panic>

00000000800032e8 <__memset>:
    800032e8:	ff010113          	addi	sp,sp,-16
    800032ec:	00813423          	sd	s0,8(sp)
    800032f0:	01010413          	addi	s0,sp,16
    800032f4:	1a060e63          	beqz	a2,800034b0 <__memset+0x1c8>
    800032f8:	40a007b3          	neg	a5,a0
    800032fc:	0077f793          	andi	a5,a5,7
    80003300:	00778693          	addi	a3,a5,7
    80003304:	00b00813          	li	a6,11
    80003308:	0ff5f593          	andi	a1,a1,255
    8000330c:	fff6071b          	addiw	a4,a2,-1
    80003310:	1b06e663          	bltu	a3,a6,800034bc <__memset+0x1d4>
    80003314:	1cd76463          	bltu	a4,a3,800034dc <__memset+0x1f4>
    80003318:	1a078e63          	beqz	a5,800034d4 <__memset+0x1ec>
    8000331c:	00b50023          	sb	a1,0(a0)
    80003320:	00100713          	li	a4,1
    80003324:	1ae78463          	beq	a5,a4,800034cc <__memset+0x1e4>
    80003328:	00b500a3          	sb	a1,1(a0)
    8000332c:	00200713          	li	a4,2
    80003330:	1ae78a63          	beq	a5,a4,800034e4 <__memset+0x1fc>
    80003334:	00b50123          	sb	a1,2(a0)
    80003338:	00300713          	li	a4,3
    8000333c:	18e78463          	beq	a5,a4,800034c4 <__memset+0x1dc>
    80003340:	00b501a3          	sb	a1,3(a0)
    80003344:	00400713          	li	a4,4
    80003348:	1ae78263          	beq	a5,a4,800034ec <__memset+0x204>
    8000334c:	00b50223          	sb	a1,4(a0)
    80003350:	00500713          	li	a4,5
    80003354:	1ae78063          	beq	a5,a4,800034f4 <__memset+0x20c>
    80003358:	00b502a3          	sb	a1,5(a0)
    8000335c:	00700713          	li	a4,7
    80003360:	18e79e63          	bne	a5,a4,800034fc <__memset+0x214>
    80003364:	00b50323          	sb	a1,6(a0)
    80003368:	00700e93          	li	t4,7
    8000336c:	00859713          	slli	a4,a1,0x8
    80003370:	00e5e733          	or	a4,a1,a4
    80003374:	01059e13          	slli	t3,a1,0x10
    80003378:	01c76e33          	or	t3,a4,t3
    8000337c:	01859313          	slli	t1,a1,0x18
    80003380:	006e6333          	or	t1,t3,t1
    80003384:	02059893          	slli	a7,a1,0x20
    80003388:	40f60e3b          	subw	t3,a2,a5
    8000338c:	011368b3          	or	a7,t1,a7
    80003390:	02859813          	slli	a6,a1,0x28
    80003394:	0108e833          	or	a6,a7,a6
    80003398:	03059693          	slli	a3,a1,0x30
    8000339c:	003e589b          	srliw	a7,t3,0x3
    800033a0:	00d866b3          	or	a3,a6,a3
    800033a4:	03859713          	slli	a4,a1,0x38
    800033a8:	00389813          	slli	a6,a7,0x3
    800033ac:	00f507b3          	add	a5,a0,a5
    800033b0:	00e6e733          	or	a4,a3,a4
    800033b4:	000e089b          	sext.w	a7,t3
    800033b8:	00f806b3          	add	a3,a6,a5
    800033bc:	00e7b023          	sd	a4,0(a5)
    800033c0:	00878793          	addi	a5,a5,8
    800033c4:	fed79ce3          	bne	a5,a3,800033bc <__memset+0xd4>
    800033c8:	ff8e7793          	andi	a5,t3,-8
    800033cc:	0007871b          	sext.w	a4,a5
    800033d0:	01d787bb          	addw	a5,a5,t4
    800033d4:	0ce88e63          	beq	a7,a4,800034b0 <__memset+0x1c8>
    800033d8:	00f50733          	add	a4,a0,a5
    800033dc:	00b70023          	sb	a1,0(a4)
    800033e0:	0017871b          	addiw	a4,a5,1
    800033e4:	0cc77663          	bgeu	a4,a2,800034b0 <__memset+0x1c8>
    800033e8:	00e50733          	add	a4,a0,a4
    800033ec:	00b70023          	sb	a1,0(a4)
    800033f0:	0027871b          	addiw	a4,a5,2
    800033f4:	0ac77e63          	bgeu	a4,a2,800034b0 <__memset+0x1c8>
    800033f8:	00e50733          	add	a4,a0,a4
    800033fc:	00b70023          	sb	a1,0(a4)
    80003400:	0037871b          	addiw	a4,a5,3
    80003404:	0ac77663          	bgeu	a4,a2,800034b0 <__memset+0x1c8>
    80003408:	00e50733          	add	a4,a0,a4
    8000340c:	00b70023          	sb	a1,0(a4)
    80003410:	0047871b          	addiw	a4,a5,4
    80003414:	08c77e63          	bgeu	a4,a2,800034b0 <__memset+0x1c8>
    80003418:	00e50733          	add	a4,a0,a4
    8000341c:	00b70023          	sb	a1,0(a4)
    80003420:	0057871b          	addiw	a4,a5,5
    80003424:	08c77663          	bgeu	a4,a2,800034b0 <__memset+0x1c8>
    80003428:	00e50733          	add	a4,a0,a4
    8000342c:	00b70023          	sb	a1,0(a4)
    80003430:	0067871b          	addiw	a4,a5,6
    80003434:	06c77e63          	bgeu	a4,a2,800034b0 <__memset+0x1c8>
    80003438:	00e50733          	add	a4,a0,a4
    8000343c:	00b70023          	sb	a1,0(a4)
    80003440:	0077871b          	addiw	a4,a5,7
    80003444:	06c77663          	bgeu	a4,a2,800034b0 <__memset+0x1c8>
    80003448:	00e50733          	add	a4,a0,a4
    8000344c:	00b70023          	sb	a1,0(a4)
    80003450:	0087871b          	addiw	a4,a5,8
    80003454:	04c77e63          	bgeu	a4,a2,800034b0 <__memset+0x1c8>
    80003458:	00e50733          	add	a4,a0,a4
    8000345c:	00b70023          	sb	a1,0(a4)
    80003460:	0097871b          	addiw	a4,a5,9
    80003464:	04c77663          	bgeu	a4,a2,800034b0 <__memset+0x1c8>
    80003468:	00e50733          	add	a4,a0,a4
    8000346c:	00b70023          	sb	a1,0(a4)
    80003470:	00a7871b          	addiw	a4,a5,10
    80003474:	02c77e63          	bgeu	a4,a2,800034b0 <__memset+0x1c8>
    80003478:	00e50733          	add	a4,a0,a4
    8000347c:	00b70023          	sb	a1,0(a4)
    80003480:	00b7871b          	addiw	a4,a5,11
    80003484:	02c77663          	bgeu	a4,a2,800034b0 <__memset+0x1c8>
    80003488:	00e50733          	add	a4,a0,a4
    8000348c:	00b70023          	sb	a1,0(a4)
    80003490:	00c7871b          	addiw	a4,a5,12
    80003494:	00c77e63          	bgeu	a4,a2,800034b0 <__memset+0x1c8>
    80003498:	00e50733          	add	a4,a0,a4
    8000349c:	00b70023          	sb	a1,0(a4)
    800034a0:	00d7879b          	addiw	a5,a5,13
    800034a4:	00c7f663          	bgeu	a5,a2,800034b0 <__memset+0x1c8>
    800034a8:	00f507b3          	add	a5,a0,a5
    800034ac:	00b78023          	sb	a1,0(a5)
    800034b0:	00813403          	ld	s0,8(sp)
    800034b4:	01010113          	addi	sp,sp,16
    800034b8:	00008067          	ret
    800034bc:	00b00693          	li	a3,11
    800034c0:	e55ff06f          	j	80003314 <__memset+0x2c>
    800034c4:	00300e93          	li	t4,3
    800034c8:	ea5ff06f          	j	8000336c <__memset+0x84>
    800034cc:	00100e93          	li	t4,1
    800034d0:	e9dff06f          	j	8000336c <__memset+0x84>
    800034d4:	00000e93          	li	t4,0
    800034d8:	e95ff06f          	j	8000336c <__memset+0x84>
    800034dc:	00000793          	li	a5,0
    800034e0:	ef9ff06f          	j	800033d8 <__memset+0xf0>
    800034e4:	00200e93          	li	t4,2
    800034e8:	e85ff06f          	j	8000336c <__memset+0x84>
    800034ec:	00400e93          	li	t4,4
    800034f0:	e7dff06f          	j	8000336c <__memset+0x84>
    800034f4:	00500e93          	li	t4,5
    800034f8:	e75ff06f          	j	8000336c <__memset+0x84>
    800034fc:	00600e93          	li	t4,6
    80003500:	e6dff06f          	j	8000336c <__memset+0x84>

0000000080003504 <__memmove>:
    80003504:	ff010113          	addi	sp,sp,-16
    80003508:	00813423          	sd	s0,8(sp)
    8000350c:	01010413          	addi	s0,sp,16
    80003510:	0e060863          	beqz	a2,80003600 <__memmove+0xfc>
    80003514:	fff6069b          	addiw	a3,a2,-1
    80003518:	0006881b          	sext.w	a6,a3
    8000351c:	0ea5e863          	bltu	a1,a0,8000360c <__memmove+0x108>
    80003520:	00758713          	addi	a4,a1,7
    80003524:	00a5e7b3          	or	a5,a1,a0
    80003528:	40a70733          	sub	a4,a4,a0
    8000352c:	0077f793          	andi	a5,a5,7
    80003530:	00f73713          	sltiu	a4,a4,15
    80003534:	00174713          	xori	a4,a4,1
    80003538:	0017b793          	seqz	a5,a5
    8000353c:	00e7f7b3          	and	a5,a5,a4
    80003540:	10078863          	beqz	a5,80003650 <__memmove+0x14c>
    80003544:	00900793          	li	a5,9
    80003548:	1107f463          	bgeu	a5,a6,80003650 <__memmove+0x14c>
    8000354c:	0036581b          	srliw	a6,a2,0x3
    80003550:	fff8081b          	addiw	a6,a6,-1
    80003554:	02081813          	slli	a6,a6,0x20
    80003558:	01d85893          	srli	a7,a6,0x1d
    8000355c:	00858813          	addi	a6,a1,8
    80003560:	00058793          	mv	a5,a1
    80003564:	00050713          	mv	a4,a0
    80003568:	01088833          	add	a6,a7,a6
    8000356c:	0007b883          	ld	a7,0(a5)
    80003570:	00878793          	addi	a5,a5,8
    80003574:	00870713          	addi	a4,a4,8
    80003578:	ff173c23          	sd	a7,-8(a4)
    8000357c:	ff0798e3          	bne	a5,a6,8000356c <__memmove+0x68>
    80003580:	ff867713          	andi	a4,a2,-8
    80003584:	02071793          	slli	a5,a4,0x20
    80003588:	0207d793          	srli	a5,a5,0x20
    8000358c:	00f585b3          	add	a1,a1,a5
    80003590:	40e686bb          	subw	a3,a3,a4
    80003594:	00f507b3          	add	a5,a0,a5
    80003598:	06e60463          	beq	a2,a4,80003600 <__memmove+0xfc>
    8000359c:	0005c703          	lbu	a4,0(a1)
    800035a0:	00e78023          	sb	a4,0(a5)
    800035a4:	04068e63          	beqz	a3,80003600 <__memmove+0xfc>
    800035a8:	0015c603          	lbu	a2,1(a1)
    800035ac:	00100713          	li	a4,1
    800035b0:	00c780a3          	sb	a2,1(a5)
    800035b4:	04e68663          	beq	a3,a4,80003600 <__memmove+0xfc>
    800035b8:	0025c603          	lbu	a2,2(a1)
    800035bc:	00200713          	li	a4,2
    800035c0:	00c78123          	sb	a2,2(a5)
    800035c4:	02e68e63          	beq	a3,a4,80003600 <__memmove+0xfc>
    800035c8:	0035c603          	lbu	a2,3(a1)
    800035cc:	00300713          	li	a4,3
    800035d0:	00c781a3          	sb	a2,3(a5)
    800035d4:	02e68663          	beq	a3,a4,80003600 <__memmove+0xfc>
    800035d8:	0045c603          	lbu	a2,4(a1)
    800035dc:	00400713          	li	a4,4
    800035e0:	00c78223          	sb	a2,4(a5)
    800035e4:	00e68e63          	beq	a3,a4,80003600 <__memmove+0xfc>
    800035e8:	0055c603          	lbu	a2,5(a1)
    800035ec:	00500713          	li	a4,5
    800035f0:	00c782a3          	sb	a2,5(a5)
    800035f4:	00e68663          	beq	a3,a4,80003600 <__memmove+0xfc>
    800035f8:	0065c703          	lbu	a4,6(a1)
    800035fc:	00e78323          	sb	a4,6(a5)
    80003600:	00813403          	ld	s0,8(sp)
    80003604:	01010113          	addi	sp,sp,16
    80003608:	00008067          	ret
    8000360c:	02061713          	slli	a4,a2,0x20
    80003610:	02075713          	srli	a4,a4,0x20
    80003614:	00e587b3          	add	a5,a1,a4
    80003618:	f0f574e3          	bgeu	a0,a5,80003520 <__memmove+0x1c>
    8000361c:	02069613          	slli	a2,a3,0x20
    80003620:	02065613          	srli	a2,a2,0x20
    80003624:	fff64613          	not	a2,a2
    80003628:	00e50733          	add	a4,a0,a4
    8000362c:	00c78633          	add	a2,a5,a2
    80003630:	fff7c683          	lbu	a3,-1(a5)
    80003634:	fff78793          	addi	a5,a5,-1
    80003638:	fff70713          	addi	a4,a4,-1
    8000363c:	00d70023          	sb	a3,0(a4)
    80003640:	fec798e3          	bne	a5,a2,80003630 <__memmove+0x12c>
    80003644:	00813403          	ld	s0,8(sp)
    80003648:	01010113          	addi	sp,sp,16
    8000364c:	00008067          	ret
    80003650:	02069713          	slli	a4,a3,0x20
    80003654:	02075713          	srli	a4,a4,0x20
    80003658:	00170713          	addi	a4,a4,1
    8000365c:	00e50733          	add	a4,a0,a4
    80003660:	00050793          	mv	a5,a0
    80003664:	0005c683          	lbu	a3,0(a1)
    80003668:	00178793          	addi	a5,a5,1
    8000366c:	00158593          	addi	a1,a1,1
    80003670:	fed78fa3          	sb	a3,-1(a5)
    80003674:	fee798e3          	bne	a5,a4,80003664 <__memmove+0x160>
    80003678:	f89ff06f          	j	80003600 <__memmove+0xfc>

000000008000367c <__putc>:
    8000367c:	fe010113          	addi	sp,sp,-32
    80003680:	00813823          	sd	s0,16(sp)
    80003684:	00113c23          	sd	ra,24(sp)
    80003688:	02010413          	addi	s0,sp,32
    8000368c:	00050793          	mv	a5,a0
    80003690:	fef40593          	addi	a1,s0,-17
    80003694:	00100613          	li	a2,1
    80003698:	00000513          	li	a0,0
    8000369c:	fef407a3          	sb	a5,-17(s0)
    800036a0:	fffff097          	auipc	ra,0xfffff
    800036a4:	b3c080e7          	jalr	-1220(ra) # 800021dc <console_write>
    800036a8:	01813083          	ld	ra,24(sp)
    800036ac:	01013403          	ld	s0,16(sp)
    800036b0:	02010113          	addi	sp,sp,32
    800036b4:	00008067          	ret

00000000800036b8 <__getc>:
    800036b8:	fe010113          	addi	sp,sp,-32
    800036bc:	00813823          	sd	s0,16(sp)
    800036c0:	00113c23          	sd	ra,24(sp)
    800036c4:	02010413          	addi	s0,sp,32
    800036c8:	fe840593          	addi	a1,s0,-24
    800036cc:	00100613          	li	a2,1
    800036d0:	00000513          	li	a0,0
    800036d4:	fffff097          	auipc	ra,0xfffff
    800036d8:	ae8080e7          	jalr	-1304(ra) # 800021bc <console_read>
    800036dc:	fe844503          	lbu	a0,-24(s0)
    800036e0:	01813083          	ld	ra,24(sp)
    800036e4:	01013403          	ld	s0,16(sp)
    800036e8:	02010113          	addi	sp,sp,32
    800036ec:	00008067          	ret

00000000800036f0 <console_handler>:
    800036f0:	fe010113          	addi	sp,sp,-32
    800036f4:	00813823          	sd	s0,16(sp)
    800036f8:	00113c23          	sd	ra,24(sp)
    800036fc:	00913423          	sd	s1,8(sp)
    80003700:	02010413          	addi	s0,sp,32
    80003704:	14202773          	csrr	a4,scause
    80003708:	100027f3          	csrr	a5,sstatus
    8000370c:	0027f793          	andi	a5,a5,2
    80003710:	06079e63          	bnez	a5,8000378c <console_handler+0x9c>
    80003714:	00074c63          	bltz	a4,8000372c <console_handler+0x3c>
    80003718:	01813083          	ld	ra,24(sp)
    8000371c:	01013403          	ld	s0,16(sp)
    80003720:	00813483          	ld	s1,8(sp)
    80003724:	02010113          	addi	sp,sp,32
    80003728:	00008067          	ret
    8000372c:	0ff77713          	andi	a4,a4,255
    80003730:	00900793          	li	a5,9
    80003734:	fef712e3          	bne	a4,a5,80003718 <console_handler+0x28>
    80003738:	ffffe097          	auipc	ra,0xffffe
    8000373c:	6dc080e7          	jalr	1756(ra) # 80001e14 <plic_claim>
    80003740:	00a00793          	li	a5,10
    80003744:	00050493          	mv	s1,a0
    80003748:	02f50c63          	beq	a0,a5,80003780 <console_handler+0x90>
    8000374c:	fc0506e3          	beqz	a0,80003718 <console_handler+0x28>
    80003750:	00050593          	mv	a1,a0
    80003754:	00001517          	auipc	a0,0x1
    80003758:	b8450513          	addi	a0,a0,-1148 # 800042d8 <CONSOLE_STATUS+0x2c8>
    8000375c:	fffff097          	auipc	ra,0xfffff
    80003760:	afc080e7          	jalr	-1284(ra) # 80002258 <__printf>
    80003764:	01013403          	ld	s0,16(sp)
    80003768:	01813083          	ld	ra,24(sp)
    8000376c:	00048513          	mv	a0,s1
    80003770:	00813483          	ld	s1,8(sp)
    80003774:	02010113          	addi	sp,sp,32
    80003778:	ffffe317          	auipc	t1,0xffffe
    8000377c:	6d430067          	jr	1748(t1) # 80001e4c <plic_complete>
    80003780:	fffff097          	auipc	ra,0xfffff
    80003784:	3e0080e7          	jalr	992(ra) # 80002b60 <uartintr>
    80003788:	fddff06f          	j	80003764 <console_handler+0x74>
    8000378c:	00001517          	auipc	a0,0x1
    80003790:	c4c50513          	addi	a0,a0,-948 # 800043d8 <digits+0x78>
    80003794:	fffff097          	auipc	ra,0xfffff
    80003798:	a68080e7          	jalr	-1432(ra) # 800021fc <panic>
	...
