format ELF64 executable

entry main

SYS_socket = 41
SYS_write = 1
SYS_exit = 60

AF_INET = 2
SOCK_STREAM = 1

STDOUT = 1
STDERR = 2

macro socket domain, type, protocol {
    mov rax, SYS_socket
    mov rdi, domain
    mov rsi, type
    mov rdx, protocol
    syscall
}

macro write fd, start, start_len {
    mov rax, SYS_write
    mov rdi, fd
    mov rsi, start
    mov rdx, start_len
    syscall
}

macro exit status {
    mov rax, SYS_exit
    mov rdi, status
    syscall
}


segment readable executable
main:
    write STDOUT, start, start_len
    socket AF_INET, SOCK_STREAM, 0 ;; 0 in protocol because TCP is the only in SOCK_STREAM
    ;socket 444, 2000, 0 ;; 0 in protocol because TCP is the only in SOCK_STREAM
    cmp rax, 0
    jl fail
    write STDOUT, ok, ok_len
    mov dword [socketfd], eax ;; because rax holds the return value from socket syscall
    exit 0


fail:
    write STDERR, error, error_len
    exit 1

segment readable writeable
    socketfd dw 0
    start db "INFO: Starting Web Server", 10
    start_len = $ - start
    error db "INFO: ERROR!", 10
    error_len = $ - error
    ok db "INFO: OK!", 10
    ok_len = $ - ok
