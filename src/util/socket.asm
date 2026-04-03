%include "src/inc/sys.inc"

; サブルーチン内のコメントは引数の使用例を示す。
; 今後のドキュメント作成時参考するためのもの

section .text
global sock_open, sock_close, sock_connect, sock_send, sock_receive

sock_open:
    mov rax, SYS_SOCK
    mov rdi, AF_UNIX
    mov rsi, SOCK_TYPE_SOCK_STREAM
    mov rdx, 0
    syscall

    ret

sock_close:
    mov rax, SYS_CLOSE
    syscall

    ret

sock_connect:
    mov rax, SYS_CONNECT
    ; mov rdi, [sock_fd]
    ; mov rsi, xsock_addr
    ; mov rdx, xsock_addr_size
    syscall

    ret

sock_send:
    mov rax, SYS_WRITE
    ; mov rdi, [sock_fd]
    ; mov rsi, x11_req
    ; mov rdx, x11_req_len
    syscall

    ret

sock_receive:
    mov rax, SYS_READ
    ; mov rdi, [sock_fd]
    ; mov rsi, rsp
    ; mov rdx, 40
    syscall

    ret