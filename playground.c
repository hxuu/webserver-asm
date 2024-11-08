// this file serves as my ground to extract the constant values i need.
#include <stdio.h>
#include <sys/socket.h>  // Needed for AF_INET

int main() {
    printf("AF_INET value: %d\n", AF_INET);
    printf("SOCK_STREAM value: %d\n", SOCK_STREAM);
    return 0;
}

