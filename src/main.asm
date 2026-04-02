%include "src/sys.inc"

extern test_print

section .data
    msg db "Hello, World!", 0x0a, 0

section .text
global _start
_start:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, msg
    xor rdx, rdx

    ; count length of msg and store to rdx
cnt_chr:
    cmp byte [rsi + rdx], 0
    je cnt_chr_end
    inc rdx
    jmp cnt_chr
cnt_chr_end:

    syscall

    call test_print

    mov rax, SYS_END
    mov rdi, 0
    syscall