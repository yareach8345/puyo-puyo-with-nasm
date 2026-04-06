%include "src/inc/sys.inc"

section .text
global sock_open, sock_close, sock_connect, sock_send, sock_receive

; ====================================================================
; Function      : sock_open - Socket Open
; Input         : none
; Output        : RAX - fd(file descriptor) of generated socket, -1 on error
; Destroys      : RAX, RDI, RSI, RDX
; ====================================================================
sock_open:
    mov rax, SYS_SOCK
    mov rdi, AF_UNIX
    mov rsi, SOCK_TYPE_SOCK_STREAM
    mov rdx, 0
    syscall

    ret

; ====================================================================
; Function      : sock_close - Socket Close
; Input         : rdi - fd(file descriptor) of socket
; Output        : none
; Destroys      : RAX
; ====================================================================
sock_close:
    mov rax, SYS_CLOSE
    syscall

    ret

; ====================================================================
; Function      : sock_connect - Socket Connect
; Input         :
;       rdi - fd(file descriptor) of socket
;       rsi - a address of sockaddr struct
;       rdx - the size of sockaddr struct
; Output        : RAX - 0 on success, -1 on error
; Destroys      : RAX
; ====================================================================
sock_connect:
    mov rax, SYS_CONNECT
    syscall

    ret

; ====================================================================
; Function      : sock_send - Socket Send
; Input         :
;       rdi - fd(file descriptor) of socket
;       rsi - a address of buffer
;       rdx - byte count
; Output        : RAX - The number of bytes written
; Destroys      : RAX
; ====================================================================
sock_send:
    mov rax, SYS_WRITE
    syscall

    ret

; ====================================================================
; Function      : sock_receive - Socket Receive
; Input         :
;       rdi - fd(file descriptor) of socket
;       rsi - a address of buffer
;       rdx - byte count
; Output        : RAX - number of bytes read, -1 on error
; Destroys      : RAX
; ====================================================================
sock_receive:
    mov rax, SYS_READ
    syscall

    ret