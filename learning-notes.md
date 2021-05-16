# Intro
I'm learning [NASM](https://www.nasm.us/docs.php) primarily on Linux but chosen partly because of support for both Linux and Windows. Actually using [YASM](https://yasm.tortall.net/) assembler.

NASM uses Intel-style syntax, as opposed to AT&T/Gas-style (_dst src_ rather than _src dst_, no %-prefix for registers). It's not the 'default' for Linux but seems to make the most sense for me as I want to develop for both Linux and Windows, and the syntax feels more comfortable and readable.

I've been looking at 32-bit so far as there seems to be no advantage to looking at 64-bit, and I have a passing familarity with the registers so hoping it becomes natural more quickly.

I'm writing this as I learn, as a quick-reference page for myself. That means not everything will be correct; please feel free to reach out if I misunderstood something.

# References

> Things that I need to look up frequently...

## Registers
(Ref: [1](https://www.aldeid.com/wiki/X86-assembly/Registers), [2](https://www.eecg.utoronto.ca/~amza/www.mindsec.com/files/x86regs.html))

```
32 bits :  EAX     EBX     ECX     EDX
16 bits :   AX      BX      CX      DX
 8 bits :   AH  AL  BH  BL  CH  CL  DH DL
```

Think **E** = Extended and **X** = Register.

`A` Accumulator register: It is used for I/O port access, arithmetic, interrupt calls, etc...
 - EAX generally contains the return of a function. If you see the EAX register just after a function call, chances are that EAX contains the return value of the function.
 - EAX and EDX are always implied in multiplication and division instructions
 - EAX can also be used as a temporary CPU memory for additions

`B` Base register: It is used as a base pointer for memory access; gets some interrupt return values.

`C` Counter register: It is used as a loop counter and for shifts; gets some interrupt values.

`D` Data register: It is used for I/O port access, arithmetic, some interrupt calls.

Honorary mention for `[E]SP` - \[Extended\] Stack Pointer; points to last item in the stack.


## Status Register / Flags (FLAGS Register)
 Ref: https://en.wikipedia.org/wiki/FLAGS_register
 https://www.aldeid.com/wiki/X86-assembly/Registers#Status_register
 
Commonly Used:
 
### PF (Parity Flag)
The parity flag (PF) indicates if the number of set bits is even or odd in the binary representation of the low 8 bits of the result of the last operation.

### ZF (Zero Flag)
The Zero Flag (ZF) is set (1) when the result of an operation is zero. Otherwise, it is cleared (0).

### SF (Sign Flag)
The Sign Flag (SF) is set (1) when the result of an operation is negative. Otherwise (positive result), it is cleared (0).

> Is it very important to remember that many instructions change the bits of the FLAGS register, so you should act on flag values immediately (or save them for later use).

## Syscalls

Ref: https://faculty.nps.edu/cseagle/assembly/sys_call.html

Ref (x64 only): https://filippo.io/linux-syscall-table/

eax | Name | Source | ebx | ecx | edx
---- | ---- | ------ | ---- | ---- | ----
1 | sys_exit | kernel/exit.c | int | - | -
3 | sys_read | fs/read_write.c | unsigned int | char* | size_t
4 | sys_write | fs/read_write.c | unsigned int | const char * | size_t
5 | sys_open | fs/open.c | const char * | int | int
6 | sys_close | fs/open.c | unsigned int | - | -
13 | sys_time | kernel/time.c | int * | - | -

```asm
                           ; example of using sys_write to write to stdout
    mov eax,4              ; Put the system call number in the EAX register.
    mov ebx,1              ; Store the arguments to the system call in the registers EBX, ECX, etc.
    mov ecx,the_string
    mov edx,the_string_len
    int 0x80               ; Call the relevant interrupt (80h).
                           ; The result is usually returned in the EAX register.
```


## File Descriptors

Ref: https://www.tutorialspoint.com/assembly_programming/assembly_file_management.htm

> A file descriptor is a 16-bit integer assigned to a file as a file id. When a new file is created or an existing file is opened, the file descriptor is used for accessing the file.

### Standard Streams

fd | stream
-- | ------
0  | stdin
1  | stdout
2  | stderr


## Jumps

[(no HTTPS)](http://unixwiz.net/techtips/x86-jumps.html) and [HTTPS Version](https://outline.com/zgfG5z)
https://www.tutorialspoint.com/assembly_programming/assembly_conditions.htm

### Unconditional

```asm
    jmp label    ; transfer flow, does not ret (call does)
```

### Conditional

Jump to an address in the code segment (i.e., a label) based on the content of the FLAGS register.

The FLAGS register is updated by:
 - All instructions that perform arithmetic operations
 - The `cmp` instruction, which subtracts one operand from another but doesn't store the result anywhere

Use in conjunction with `cmp`. See 'status registers / flags' above.

Instruction | Description | Flags tested
----------- | ----------- | ------------
JE / JZ | Jump Equal or Jump Zero | ZF
JNE / JNZ | Jump not Equal / Jump Not Zero | ZF
JG / JNLE | Jump Greater / Jump Not Less or Equal | OF, SF, ZF
JGE / JNL | Jump Greater or Equal / Jump Not Less | OF, SF
JL / JNGE | Jump Less / Jump Not Greater or Equal | OF, SF
JLE / JNG | Jump Less or Equal / Jump Not Greater | OF, SF, ZF

Examples:

JE / JZ - jump if ZF = 1

JNE / JNZ - jump if ZF = 0


> Checks the state of one or more of the status flags in the FLAGS register (CF, OF, PF, SF, and ZF) and, if the flags are in the specified state (condition), performs a jump to the target instruction specified by the destination operand. A condition code (cc) is associated with each instruction to indicate the condition being tested for. If the condition is not satisfied, the jump is not performed and execution continues with the instruction following the Jcc instruction.

```asm
    mov eax,1              ; eax = 1
    mov edx,1              ; edx = 1
    add edx,eax            ; edx = eax + edx
    cmp edx,2              ; if edx == 2
    je good_stuff          ; jump if ZF is set
```


## Flow Control

### `call` vs `jmp`

Use `call` to (allow flow to) return, `jmp` and other jumps do not.

```asm
    _some_func:            ; (2) function executes
        <code>
        ret                ; (3) `pop`s the return address off the stack and
                           ; continue execution at that address

    call _some_func        ; (1) transfer flow to _some_func, and push the address
                           ; of the next instruction (below) to the stack
    <code>                 ; (4) execution continues here
```

### Loops

Example from https://en.wikibooks.org/wiki/X86_Assembly/Control_Flow#Loop_Instructions

```asm
    mov ecx, 5             ; ecx ≔ 5
head:
    ; the code here would be executed 5 times
    loop head
```


