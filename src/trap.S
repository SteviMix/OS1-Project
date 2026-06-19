.extern trap_handler

.align 4
.global trap
.type trap, @function
trap:
    addi sp, sp, -256

    .irp index, 1, 5, 6, 7, 10, 11, 12, 13, 14, 15, 16, 17, 28, 29, 30, 31
    sd x\index, \index*8(sp)
    .endr

    mv a0, sp

    call trap_handler

    .irp index, 1, 5, 6, 7, 10, 11, 12, 13, 14, 15, 16, 17, 28, 29, 30, 31
    ld x\index, \index*8(sp)
    .endr

    addi sp,sp,256
    sret