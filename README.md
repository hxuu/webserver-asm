# Assembly Web Server

A lightweight HTTP server written in x86\_64 assembly with FASM.

> I did this project after struggling with a CTF challenge that caused skill issue
on my end. Also, I got inspired from watching Tsoding daily video titled: Web in Native Assembly (Linux x86_64)


## Features
- Handles `GET` requests

## Requirements
- Linux x86\_64
- [FASM](https://flatassembler.net/) assembler

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/hxuu/website-asm
   cd website-asm
   ```

---

# Backlog

This section defines what is due.

1. create the socket [done]

> Let's do that by translating the C code into a fasm macro, which is a reusable
block of code just like a function, but instead, pastes the content of it in compile time.

2. bind the socket to and address and a port [done]

> idk how to do that (YET).  Let's use chatgpt to guide us into learning the stuff
we need to do that.

a. setup the socket\_in structure in memory [done]
b. prepare the bind syscall (easy) [done]
c. do whatever you gotta do~

3. provide mechanism to close the socket [done]

4. listening to the socket and accepting connections [done]

---

This was an instructive project overall. Noice~
