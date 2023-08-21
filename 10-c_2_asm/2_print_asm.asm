; nasm -f elf32 2_print_asm.asm 
; ld -m elf_i386 2_print_asm.o -o 2_print_asm

BITS 32
section .data
msg db "PLOP !", 0xa

section .text
global _start

_start:
mov eax, 4    ; syscall to write()
mov ebx, 1    ; filedescriptor
mov ecx, msg  ; pointer to string
mov edx, 7    ; number of bytes to write
int 0x80      ; interrupt call Linux kernel interrupt handler (0x80)

mov eax, 1    ; syscall exit()
mov ebx, 0    ; return error code 0
int 0x80      ; interrupt call Linux kernel interrupt handler (0x80)


; Once compiled and linked, with objdump we see a lot of null bytes
; This can't be used as shellcode because null bytes will trunc our string
; Also note msg is the "PLOP !" string but interpreted as instructions (they are not instructions)
;
