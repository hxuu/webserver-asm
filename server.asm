format ELF64 executable

entry main

SYS_socket = 41
SYS_write = 1
SYS_exit = 60
SYS_bind = 49

AF_INET = 2
PORT = 9999
INADDR_ANY = 0
SOCK_STREAM = 1

STDOUT = 1
STDERR = 2

;; int socket(int domain, int type, int protocol);
macro socket domain, type, protocol {
    mov rax, SYS_socket
    mov rdi, domain
    mov rsi, type
    mov rdx, protocol
    syscall
}

;; ssize_t write(int fd, const void buf[.count], size_t count);
macro write fd, start, start_len {
    mov rax, SYS_write
    mov rdi, fd
    mov rsi, start
    mov rdx, start_len
    syscall
}

;; [[noreturn]] void _exit(int status);
macro exit status {
    mov rax, SYS_exit
    mov rdi, status
    syscall
}

;; int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
macro bind sockfd, addr, addrlen {
    mov rax, SYS_bind
    mov rdi, sockfd
    mov rsi, addr
    mov rdx, addrlen
    syscall
}


segment readable executable
main:
    write STDOUT, start, start_len

    write STDOUT, create_socket_msg, create_socket_msg_len
    socket AF_INET, SOCK_STREAM, 0 ;; 0 in protocol because TCP is the only in SOCK_STREAM
    ;socket 444, 2000, 0 ;; 0 in protocol because TCP is the only in SOCK_STREAM
    cmp rax, 0
    jl fail

    mov qword [sockfd], rax ;; because rax holds the return value from socket syscall
    write STDOUT, ok, ok_len

    mov word [servaddr.sin_family], AF_INET
    mov ax, PORT
    xchg ah, al ;; change port into network repr (big-endian)
    mov word [servaddr.sin_port], ax
    mov dword [servaddr.sin_addr], INADDR_ANY

    write STDOUT, bind_msg, bind_msg_len
    bind [sockfd], servaddr.sin_family, sizeof_servaddr
    cmp rax, 0
    jl fail
    write STDOUT, ok, ok_len

    exit 0


fail:
    write STDERR, error, error_len
    exit 1


segment readable writeable
    sockfd dq 0
    ;; creating the sockaddr_in structure
    servaddr.sin_family dw 0
    servaddr.sin_port   dw 0
    servaddr.sin_addr   dd 0
    servaddr.sin_zero   dq 0
    sizeof_servaddr = $ - servaddr.sin_family

    start db "INFO: Starting Web Server", 10
    start_len = $ - start
    ok db "INFO: OK!", 10
    ok_len = $ - ok
    error db "INFO: ERROR!", 10
    error_len = $ - error

    create_socket_msg db "INFO: Creating Socket...", 10
    create_socket_msg_len = $ - create_socket_msg
    bind_msg db "INFO: Binding Socket...", 10
    bind_msg_len = $ - bind_msg
