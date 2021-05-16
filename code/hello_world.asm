; simple_example.asm

; syscalls
;SYS_EXIT  equ 1
;SYS_READ  equ 3
;SYS_WRITE equ 4

; file descriptors
;STDIN     equ 0
;STDOUT    equ 1

bits 32
section					.data
	; null-terminated 'Hello World' and it's length
	; db defines a byte
	; see https://www.tutorialspoint.com/assembly_programming/assembly_variables.htm
	; equ == 'equate' == #define :) no allocation just defining label
	msg					db		'Hello World',0xa
	len					equ		$-msg

	ask					db		'Tell me your name...',0xa
	asklen				equ		$-ask

	is_equal			db		'Is Equal',0xa
	is_equal_len		equ		$-is_equal

	is_not_equal		db		'Is Not Equal',0xa
	is_not_equal_len	equ		$-is_not_equal

section					.bss
	name				resb	10

section 				.text
	global _start

	; == write to stdout ========================
	_print:
		mov ebx,1
		mov eax,4
		int 0x80
		ret

	; == is_eq function =========================
	_is_eq:
		mov edx,is_equal_len
		mov ecx,is_equal
		call _print
		jmp _exit

	; == is_not_eq function =====================
	_is_not_eq:
		mov edx,is_not_equal_len
		mov ecx,is_not_equal
		call _print
		jmp _exit

	; == _clear_buffer function =================
	_clear_buffer:
		mov     edx, 1
		mov     ecx, name
		mov     ebx, 0
		mov     eax, 3
		int     0x80
		cmp     byte [ecx + edx - 1], 0xa
		jne     _clear_buffer
		ret

	; == _exit function =========================
	_exit:
		mov eax,1
		int 0x80

	; == _start function - entry point ==========
	_start:
						; write 'Hello World' to stdout
		mov ebx,1		; 1 is the file descriptor for stdout
		mov eax,4		; 4 is the syscall for sys_write
		mov	edx,len		; length of 'Hello World'
		mov	ecx,msg		; null-terminated 'Hello World'
		int 0x80		; syscall

						; prompt for user input
						; note the syscall has moved to _print function
		mov edx,asklen
		mov ecx,ask
		call _print		; call returns execution

						; take user input from stdin
		mov ecx,name	; buffer
		mov ebx,0		; 0 is the file descriptor for stdin
		mov eax,3		; 3 is the syscall for sys_read
		int 0x80

		mov edx,eax		; eax contained the size of the input
						; check for LF byte
		cmp byte [ecx + eax - 1], 10
						; jump if the zero flag is set (==1) which means that
						; the cmp was 'not equal'. Otherwise flow continues.
		jz do_maffs
		call _clear_buffer

do_maffs:
						; addition example
		mov edx,1		; put 1 into edx
		mov ecx,1		; put 1 into ecx
		add ecx,edx		; ecx = ecx + edx
		cmp ecx,2		; if ecx == 2
		je _is_eq		; if ecx == 2

						; quit the program
		mov	eax,1		; system call for sys_exit
		int	0x80

