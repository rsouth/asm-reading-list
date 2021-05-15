# asm-reading-list

I'm learning ASM primarily to better understand the output of my Rust and C++ programs. This repo is a link-dump, hopefully will evolve in to a useful resource for others learning ASM in 2021 for similar reasons!

------

https://www.tutorialspoint.com/assembly_programming/assembly_basic_syntax.htm

X64 Linux Assembly Environment Setup
https://epi052.gitlab.io/notes-to-self/blog/2018-07-22-x64-linux-assembly-environment-setup/

Hello World
```asm
; hello_world.asm

section .data
    msg       db     'Hello world!'
    nl        db     0x0a
    msgLen    equ    $-msg
section .text
global _start
_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msgLen
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

```

https://gpfault.net/posts/asm-tut-0.txt.html
https://youtu.be/rxsBghsrvpI
http://heather.cs.ucdavis.edu/~matloff/assembbook.html
http://win32assembly.programminghorizon.com/tut3.html
https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/os/
https://riptutorial.com/assembly
https://sonictk.github.io/asm_tutorial/
