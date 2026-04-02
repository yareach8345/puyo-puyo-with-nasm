section .data
    test_msg db "test_msg", 0x0a
    test_msg_len equ $ - test_msg

section .text
global test_print
test_print:

    mov rax, 0x01
    mov rdi, 0x01
    mov rsi, test_msg
    mov rdx, test_msg_len
    syscall

    ret