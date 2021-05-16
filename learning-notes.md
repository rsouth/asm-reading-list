# Intro
I'm learning [NASM](https://www.nasm.us/docs.php) primarily on Linux but chosen partly because of support for both Linux and Windows. Actually using [YASM](https://yasm.tortall.net/) assembler.

NASM uses Intel-style syntax, as opposed to AT&T/Gas-style (_dst src_ rather than _src dst_, no %-prefix for registers). It's not the 'default' for Linux but seems to make the most sense for me as I want to develop for both Linux and Windows, and the syntax feels more comfortable and readable.

I've been looking at 32-bit so far as there seems to be no advantage to looking at 64-bit, and I have a passing familarity with the registers so hoping it becomes natural more quickly.

I'm writing this as I learn, as a quick-reference page for myself. That means not everything will be correct; please feel free to reach out if I misunderstood something.

# References

> Things that I need to look up frequently...

## Registers

(Adapted from: https://www.eecg.utoronto.ca/~amza/www.mindsec.com/files/x86regs.html)

```
32 bits :  EAX     EBX     ECX     EDX
16 bits :   AX      BX      CX      DX
 8 bits :   AH  AL  BH  BL  CH  CL  DH DL
```

`A` Accumulator register: It is used for I/O port access, arithmetic, interrupt calls, etc...

`B` Base register: It is used as a base pointer for memory access; gets some interrupt return values.

`C` Counter register: It is used as a loop counter and for shifts; gets some interrupt values.

`D` Data register: It is used for I/O port access, arithmetic, some interrupt calls.

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