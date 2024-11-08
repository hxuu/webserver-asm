format ELF64 executable

entry main

SYS_socket = 41
SYS_write = 1
SYS_exit = 60

AF_INET = 2
SOCK_STREAM = 1

macro socket domain, type, protocol {
    mov rax, SYS_socket
    mov rdi, domain
    mov rsi, type
    mov rdx, protocol
    syscall
}

macro write fd, buf, count {
    mov rax, SYS_write
    mov rdi, fd
    mov rsi, buf
    mov rdx, count
    syscall
}

macro exit status {
    mov rax, SYS_exit
    mov rdi, status
    syscall
}


segment readable executable
main:
    write 1, buf, count
    socket AF_INET, SOCK_STREAM, 0 ;; 0 in protocol because TCP is the only in SOCK_STREAM
    exit 0

segment readable
    buf db "Start Web Server...", 10
    count = $ - buf
