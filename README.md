# asm-reading-list

I'm learning ASM primarily to better understand the output of my Rust and C++ programs. This repo is a link-dump, hopefully will evolve in to a useful resource for others learning ASM in 2021 for similar reasons!

---

🎥 Video | ⚠️ No HTTPS | 🏫 .edu TLD


## Environment

Currently coding on Ubuntu in VIM and hitting NASM/YASM + ld from the terminal. I would like to get together a good environment on both Windows and Linux and will document / link here when I do


## Tutorials / Series

[TutorialsPoint - NASM](https://www.tutorialspoint.com/assembly_programming/assembly_basic_syntax.htm)

[Let's Learn x86-64 Assembly!](https://gpfault.net/posts/asm-tut-0.txt.html)

⚠️ 🏫 [Assembly Language from a Modern Point of View](http://heather.cs.ucdavis.edu/~matloff/assembbook.html) | [HTTPS via Outline.com](https://outline.com/2uWDR9)

🏫 [NASM Tutorial](https://cs.lmu.edu/~ray/notes/nasmtutorial/)

🏫 (RasPi) [Baking Pi – Operating Systems Development](https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/os/)

[RIP Tutorial - Getting started with Assembly Language](https://riptutorial.com/assembly)

[Understanding Windows x64 Assembly](https://sonictk.github.io/asm_tutorial/) (:octocat: [GitHub](https://github.com/sonictk/asm_tutorial)


## Videos

🎥 [Series - Modern x64 Assembly](https://youtu.be/rxsBghsrvpI)


## Tools

[GodBolt Compiler Explorer](https://godbolt.org/) - See the output from various compilers; useful for seeing the resulting ASM and evaluating the difference between different implementations.


## Notes

[X64 Linux Assembly Environment Setup](https://epi052.gitlab.io/notes-to-self/blog/2018-07-22-x64-linux-assembly-environment-setup/)

---

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
