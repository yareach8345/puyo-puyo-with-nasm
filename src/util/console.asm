%include "src/inc/sys.inc"

section .text
global write
write:
    mov rsi, rax
    mov rax, SYS_WRITE
    mov rdi, STDOUT

    xor rdx, rdx

    write_letter_cnt_loop:
        cmp [rsi + rdx], byte 0
        je write_letter_cnt_loop_end
        inc rdx
        jmp write_letter_cnt_loop
    write_letter_cnt_loop_end:

    syscall

    ret