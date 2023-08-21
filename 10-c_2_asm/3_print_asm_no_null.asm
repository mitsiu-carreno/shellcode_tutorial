; nasm -f elf32 3_print_asm_no_null.asm
; ld -m elf_i386 3_print_asm_no_null.o -o 3_print_asm_no_null

BITS 32

; NOTICE NO section .data

section .text
global _start

_start:
; msg 
xor eax, eax    ; EAX = 0
push eax        ; string terminator (null byte)
push 0x0a202120 ; line return (\x0a) + " ! " (added space for padding) (ascii -> hex) (little-endian)
push 0x504F4C50 ; line return (POLP) (ascii -> hex) notice O->L (little-endian)
mov ecx, esp    ; ESP is our string pointer 

; syscall to write() (previously EAX)
mov al, 4       ; AL is 1 byte, enough for the value 4 avoiding null bytes

; ebx = 1 (filedescriptor)
xor ebx, ebx    ; EBX = 0
inc ebx         ; EBX = 1

; edx = 8 (bytes to write)
xor edx, edx    ; EDX = 0
mov dl, 8       ; DL is 1 byte, enough for the value 8 (added space)

; Linux kernel interrupt handler (0x80) (interrupt call)
int 0x80

; syscall to exit()
mov al, 1     ; AL = 1 (exit call)
dec ebx       ; EBX was 1, now decremented (Error code = 0 success)
int 0x80      ; Linux kernel interrupt handler

; With objdump we can see that this binary does NOT has null bytes!!!
; Multipel tricks where used to avoid null bytes 
; Insted of moving 0 to a register, we use XOR it, the result is the same but no null bytes
; Also using al and dl registers instead of 
