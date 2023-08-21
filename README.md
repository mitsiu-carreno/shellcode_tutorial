# Shellcode tutorial
## Description
This is a project to follow along with this awesome [blog](https://axcheron.github.io/linux-shellcode-101-from-hell-to-shell/)

## Common commands
Compile and link source code:
```sh
$ gcc -o <binary> <source_code.c>
```

Trace system calls 
```sh
$ strace <binary>
```

See disassembled binary 
```sh
$ objdump -Mintel -D <binary>
```

Output binary for a given asm instruction
```sh
$ rasm2 -a x86 -b 32 "<asm_instruction>"
```

### Asm -> binary
Install compiler
```sh
$ sudo apt-get install libc6-dev-i386
```
Compile asm
```sh
$ nasm -f elf32 <asm.asm>
```
Link asm object file
```sh
$ ld -m elf_i386 <obj.o> -o <binary>
```

