# OS1 — A Small Multithreaded RISC-V Kernel

An educational operating system kernel for the **RISC-V (RV64IMA)** architecture, developed for the Operating Systems 1 course at the School of Electrical Engineering, University of Belgrade. The kernel runs on the **qemu** emulator over a modified **xv6** environment, and implements memory management, threads, semaphores, and asynchronous context switching — all written from scratch, without relying on any host operating system services.

## What's implemented

| Area | Functionality |
|------|---------------|
| **Memory** | `mem_alloc` / `mem_free` — custom allocator over fixed-size blocks |
| **Threads** | `thread_create`, `thread_exit`, `thread_dispatch` — creation, termination, and voluntary CPU yield |
| **Semaphores** | `sem_open/close/wait/signal` + `wait_n` / `signal_n` — counting semaphores with a blocked-thread queue |
| **Time** | `time_sleep` — thread sleeping, woken by the timer interrupt |
| **Console** | `getc` / `putc` — interrupt-driven buffered I/O |
| **Context switch** | Synchronous (via `ecall`) and **asynchronous** (via timer interrupt, round-robin) |

Exposes three interface layers: **ABI** (via `ecall`), a **C API**, and a **C++ API** (classes `Thread`, `Semaphore`, `PeriodicThread`).

## Architecture

The kernel is layered — each layer uses only those below it:

```
main.cpp                          startup and initialization
  │
  ├── syscall_cpp  ──► syscall_c ──► (ecall) ──► handleTrap
  │     (C++ API)       (C API)                   (RiscV.cpp)
  │
  └── ConsoleHandler ──► BoundedBuffer ──► _sem ──► TCB ──► Scheduler
                                                     │       │
                                            MemoryAllocator  │
                                                  RiscV ─────┘
                                           trap.S, contextSwitch.S
```

- **`RiscV` + `trap.S`** — single entry point for all traps (interrupts, system calls, exceptions); dispatch by `scause`.
- **`TCB`** (Thread Control Block) — per-thread state; context is saved on the thread's own stack (`ra` + `s0–s11`).
- **`contextSwitch.S`** — saving and restoring context between two threads.
- **`Scheduler`** — FIFO queue of ready threads.
- **`_sem`** — semaphore with its own blocked-thread queue.
- **`ConsoleHandler` + `BoundedBuffer`** — buffered console; all hardware access happens in trap context (atomic).

### Privilege model
User threads run in **user mode (U-mode)** with interrupts enabled. System calls and interrupts are handled in **supervisor mode (S-mode)** with interrupts masked (`SIE=0`), which makes the kernel's critical sections automatically atomic on a single-processor system.

## Build and run

Requires a RISC-V toolchain and qemu:

```bash
# build and run
make qemu

# run with gdb support (remote debugging)
make qemu-gdb
```

Compiler: `riscv64-linux-gnu-g++` (`-march=rv64ima -mabi=lp64`, freestanding). Debugging: `gdb-multiarch`.

## Structure

```
src/   implementations (.cpp, .S)
inc/   headers (.hpp, .h)
```

## Note

This repository contains only the kernel solution itself. The environment libraries (`hw.lib`, `mem.lib`, `console.lib`) and the tests are not included.
