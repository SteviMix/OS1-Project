.extern trap_handler

.align 4
.global trap
.type trap, @function
trap:

    csrrw sp, sscratch, sp
    addi sp, sp, -256

    .irp index, 1, 5, 6, 7, 10, 11, 12, 13, 14, 15, 16, 17, 28, 29, 30, 31
    sd x\index, \index*8(sp)
    .endr

    csrr t0, sscratch
    sd t0, 16(sp)

    mv a0, sp

    call trap_handler

    ld t0, 16(sp)

    .irp index, 1, 5, 6, 7, 10, 11, 12, 13, 14, 15, 16, 17, 28, 29, 30, 31
    ld x\index, \index*8(sp)
    .endr

    addi sp,sp,256
    csrw sscratch, sp
    mv sp, t0

    sret