<p align="center">
  <img src="https://user-images.githubusercontent.com/292208/118355849-41cc4900-b56a-11eb-9ecd-580f939fd9f1.png">
</p>

Also see my [Rust Reading List](https://github.com/rsouth/rust-reading-list/blob/main/README.md)

> I'm learning ASM primarily to better understand the output of my Rust and C++ programs. This repo is a link-dump, hopefully will evolve in to a useful resource for others learning ASM in 2021 for similar reasons!

🎥 Video | ⚠️ No HTTPS | 🏫 .edu TLD


## 💻 Environment

Currently coding on Ubuntu in VIM and hitting NASM/YASM + ld from the terminal. I would like to get together a good environment on both Windows and Linux and will document / link here once I do.


## 📚 Tutorials / Series

[TutorialsPoint - NASM](https://www.tutorialspoint.com/assembly_programming/assembly_basic_syntax.htm)

[Let's Learn x86-64 Assembly!](https://gpfault.net/posts/asm-tut-0.txt.html)

⚠️ 🏫 [Assembly Language from a Modern Point of View](http://heather.cs.ucdavis.edu/~matloff/assembbook.html) | [HTTPS via Outline.com](https://outline.com/2uWDR9)

🏫 [NASM Tutorial](https://cs.lmu.edu/~ray/notes/nasmtutorial/)

🏫 (RasPi) [Baking Pi – Operating Systems Development](https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/os/)

[RIP Tutorial - Getting started with Assembly Language](https://riptutorial.com/assembly)

[Understanding Windows x64 Assembly](https://sonictk.github.io/asm_tutorial/) (:octocat: [GitHub](https://github.com/sonictk/asm_tutorial)


## 🎥 Videos

🎥 [Series - Modern x64 Assembly](https://youtu.be/rxsBghsrvpI)


## 🚀 Downloads

📄 [x84-x64 Assembly Language Programming with Ubuntu - Ed Jorgensen, Ph.D. (Version 1.1.40, Jan 2020)](https://github.com/rsouth/asm-reading-list/blob/main/assembly64.pdf)

📄 [What Every Programmer Should Know About Memory - Ulrich Drepper (Nov 2007)](https://github.com/rsouth/asm-reading-list/blob/main/cpumemory.pdf)


## ⚡ Tools

[GodBolt Compiler Explorer](https://godbolt.org/) - See the output from various compilers; useful for seeing the resulting ASM and evaluating the difference between different implementations.


## 🦀 Rust + ASM

[Read Rust - ASM Tag](https://readrust.net/tags/asm)

[r/rust - How to see the assembly code for rust code getting compiled](https://www.reddit.com/r/rust/comments/9i5df2/how_to_see_the_assembly_code_for_rust_code/)

:octocat: [gnzlbg/cargo-asm - cargo subcommand showing the assembly or llvm-ir generated for Rust code](https://github.com/gnzlbg/cargo-asm)

:octocat: [jeremydavis519/rusty-asm - A layer of syntactic sugar between Rust and inline assembly](https://github.com/jeremydavis519/rusty-asm)

[Interacting with assembly in Rust](https://blog.logrocket.com/interacting-with-assembly-in-rust/)

[asm - The Rust Unstable Book](https://doc.rust-lang.org/unstable-book/library-features/asm.html)


## 📝 Notes / 💬 Discussions

[X64 Linux Assembly Environment Setup](https://epi052.gitlab.io/notes-to-self/blog/2018-07-22-x64-linux-assembly-environment-setup/)

[Ask HN: What's the best resource for learning modern x64 assembly?](https://news.ycombinator.com/item?id=22279051)


## Dumping Ground

[Introduction to 64 Bit Assembly Language Programming for Linux and OS X](http://rayseyfarth.com/asm/)

[Introductory Intel x86-64: Architecture, Assembly, Applications, & Alliteration](https://opensecuritytraining.info/IntroX86-64.html)

[Guide to writing X86-64 Assembly](https://tonycodes.com/assembly)

[Software optimization resources](https://agner.org/optimize/)

[Reverse Engineering for Beginners / Understanding Assembly Language](https://beginners.re/) (PDF Download on this page)

[ELF: From The Programmer's Perspective](http://beefchunk.com/documentation/sys-programming/binary_formats/elf/elf_from_the_programmers_perspective/elf.html)

[Under the Hood (1998)](http://bytepointer.com/resources/pietrek_asm_pt1.htm)

[Reference - Sandpile - The world's leading source for technical x86 processor information.](https://sandpile.org/)

[Assembly Language For Real](https://hackaday.com/2020/08/25/assembly-language-for-real/)



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
