section .data
    data: db "section .data%c    data: db %c%s%c, 0%c%csection .text%cglobal main%cextern printf%c%cprintout:%c    push rbp%c    mov rbp, rsp%c    lea rdi, [rel data]%c    mov rsi, 10%c    mov rdx, 34%c    lea rcx, [rel data]%c    mov r8, 34%c    mov r9, 10%c    sub rsp, 48%c    mov qword [rsp+40], 10%c    mov qword [rsp+32], 47%c    mov qword [rsp+24], 10%c    mov qword [rsp+16], 10%c    mov qword [rsp+8], 47%c    mov qword [rsp], 10%c    mov rax, 0%c    call printf wrt ..plt%c    add rsp, 48%c    mov rsp, rbp%c    pop rbp%c    ret%c%c; comment outside%c%cmain:%c; comment in main%c    push rbp%c    mov rbp, rsp%c    call printout%c    mov rsp, rbp%c    pop rbp%c    xor eax, eax%c    ret%c", 0

section .text
global main
extern printf

printout:
    push rbp
    mov rbp, rsp
    lea rdi, [rel data]
    mov rsi, 10
    mov rdx, 34
    lea rcx, [rel data]
    mov r8, 34
    mov r9, 10
    sub rsp, 48
    mov qword [rsp+40], 10
    mov qword [rsp+32], 47
    mov qword [rsp+24], 10
    mov qword [rsp+16], 10
    mov qword [rsp+8], 47
    mov qword [rsp], 10
    mov rax, 0
    call printf wrt ..plt
    add rsp, 48
    mov rsp, rbp
    pop rbp
    ret

; comment outside

main:
; comment in main
    push rbp
    mov rbp, rsp
    call printout
    mov rsp, rbp
    pop rbp
    xor eax, eax
    ret