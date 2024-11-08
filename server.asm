format ELF64 executable

entry main

segment readable executable
main:
    mov rax, 1
    mov rdi, 1
    mov rsi, buf
    mov rdx, count
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

segment readable
    buf db "Hello, world!", 10
    count = $ - buf
