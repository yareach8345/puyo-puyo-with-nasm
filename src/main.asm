%include "src/inc/sys.inc"

extern write
extern sock_open, sock_close, sock_connect, sock_send, sock_receive

section .bss
    sock_fd resq 0

section .data
    msg db "error", 0x0a, 0
    xsock_addr:
        sun_family dw AF_UNIX
        sun_path db "/tmp/.X11-unix/X0"
        times 108 - ($ - xsock_addr - 2) db 0
    xsock_addr_size equ $ - xsock_addr

    ; authファイルからトークンを取得するコードはまだ未作成
    ; auth問題で失敗する場合、 'xhost +local:' コマンドを実行
    x11_req:
        db 'l', 0
        dw 11, 0
        dw 0 
        dw 0
        dw 0
    x11_req_len equ $ - x11_req

section .text
global _start
_start:
    ;; ソケット生成
    call sock_open
    mov [sock_fd], rax

    ;; 生成成功有無チェック
    cmp rax, 0
    jne nerr
    
    mov rax, msg
    call write

    mov rax, SYS_END
    mov rdi, 1
    syscall

nerr:

    mov rdi, [sock_fd]
    mov rsi, xsock_addr
    mov rdx, xsock_addr_size
    call sock_connect

    ;;  連結チェック
    cmp rax, 0
    jge nerr2
    
    mov rax, msg
    call write

    mov rax, SYS_END
    mov rdi, 2
    syscall

nerr2:

    mov rdi, [sock_fd]
    mov rsi, x11_req
    mov rdx, x11_req_len
    call sock_send

    cmp rax, 0
    jne nerr3
    
    mov rax, msg
    call write

    mov rax, SYS_END
    mov rdi, 3
    syscall

nerr3:

    mov rbx, rsp
    sub rsp, 64

    mov rdi, [sock_fd]
    mov rsi, rsp
    mov rdx, 40
    call sock_receive

    cmp rax, 0
    jg nerr4
    
    mov rax, msg
    call write

    mov rax, SYS_END
    mov rdi, 4
    syscall

nerr4:

    mov al, 0
    mov [rsp + 63], al
    mov rax, rsp
    call write

    add rsp, 64

    mov rdi, [sock_fd]
    call sock_close

    mov rax, SYS_END
    mov rdi, 0
    syscall