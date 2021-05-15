# asm-reading-list

I'm learning ASM primarily to better understand the output of my Rust and C++ programs. This repo is a link-dump, hopefully will evolve in to a useful resource for others learning ASM in 2021 for similar reasons!

---

🎥 Video | ⚠️ No HTTPS | 🏫 .edu TLD

[TutorialsPoint - NASM](https://www.tutorialspoint.com/assembly_programming/assembly_basic_syntax.htm)

[X64 Linux Assembly Environment Setup](https://epi052.gitlab.io/notes-to-self/blog/2018-07-22-x64-linux-assembly-environment-setup/)

[Let's Learn x86-64 Assembly!](https://gpfault.net/posts/asm-tut-0.txt.html)

🎥 [Series - Modern x64 Assembly](https://youtu.be/rxsBghsrvpI)

⚠️ 🏫 [Assembly Language from a Modern Point of View](http://heather.cs.ucdavis.edu/~matloff/assembbook.html) | [HTTPS via Outline.com](https://outline.com/2uWDR9)

🏫 [NASM Tutorial](https://cs.lmu.edu/~ray/notes/nasmtutorial/)

🏫 (RasPi) [Baking Pi – Operating Systems Development](https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/os/)

[RIP Tutorial - Getting started with Assembly Language](https://riptutorial.com/assembly)

[Understanding Windows x64 Assembly](https://sonictk.github.io/asm_tutorial/) (:octocat: [GitHub](https://github.com/sonictk/asm_tutorial)


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
