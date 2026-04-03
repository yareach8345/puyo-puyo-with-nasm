%include "src/inc/sys.inc"

section .text
global con_write

; ====================================================================
; Function      : con_write - Console Write
; Input         : RAX - address of message
; Output        : RAX - The number of bytes written
; Destroys      : RAX, RDI, RSI, RDX
; ====================================================================
con_write:
    mov rsi, rax
    mov rax, SYS_WRITE
    mov rdi, STDOUT

    xor rdx, rdx

    con_write_letter_cnt_loop:
        cmp [rsi + rdx], byte 0
        je con_write_letter_cnt_loop_end
        inc rdx
        jmp con_write_letter_cnt_loop
    con_write_letter_cnt_loop_end:

    syscall

    ret