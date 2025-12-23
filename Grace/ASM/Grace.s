; One Comment
BITS 64

section .data
model db "; One Comment%1$cBITS 64%1$c%1$csection .data%1$c    model db %2$c%3$s%2$c, 0%1$c    filename db %2$cGrace_kid.s%2$c, 0%1$c    mode_w db %2$cw%2$c, 0%1$c%1$c%1$csection .text%1$c    global main%1$c    extern fopen%1$c    extern fclose%1$c    extern fprintf%1$c%1$c%4$cmacro FT 0%1$cmain:%1$c    push rbp%1$c    mov rbp, rsp%1$c    push rbx%1$c    sub rsp, 8%1$c%1$c    open_file:%1$c        lea rdi, [rel filename]%1$c        lea rsi, [rel mode_w]%1$c        call fopen wrt ..plt%1$c%1$c        test rax, rax%1$c        jz .open_failed%1$c        mov rbx, rax%1$c        jmp write_in_file%1$c    %1$c    .open_failed:%1$c        mov eax, 1%1$c        jmp exit_process%1$c%1$c    write_in_file:%1$c        mov rdi, rbx%1$c        lea rsi, [rel model]%1$c        mov rdx, 10%1$c        mov rcx, 34%1$c        lea r8, [rel model]%1$c        mov r9, 37%1$c        xor rax, rax%1$c        call fprintf wrt ..plt%1$c%1$c    close_file:%1$c        mov rdi, rbx%1$c        call fclose wrt ..plt%1$c    %1$c    exit_process:%1$c        add rsp, 8%1$c        pop rbx%1$c        pop rbp%1$c        xor eax, eax%1$c        ret%1$c%4$cendmacro%1$c%1$cFT%1$c", 0
    filename db "Grace_kid.s", 0
    mode_w db "w", 0


section .text
    global main
    extern fopen
    extern fclose
    extern fprintf

%macro FT 0
main:
    push rbp
    mov rbp, rsp
    push rbx
    sub rsp, 8

    open_file:
        lea rdi, [rel filename]
        lea rsi, [rel mode_w]
        call fopen wrt ..plt

        test rax, rax
        jz .open_failed
        mov rbx, rax
        jmp write_in_file
    
    .open_failed:
        mov eax, 1
        jmp exit_process

    write_in_file:
        mov rdi, rbx
        lea rsi, [rel model]
        mov rdx, 10
        mov rcx, 34
        lea r8, [rel model]
        mov r9, 37
        xor rax, rax
        call fprintf wrt ..plt

    close_file:
        mov rdi, rbx
        call fclose wrt ..plt
    
    exit_process:
        add rsp, 8
        pop rbx
        pop rbp
        xor eax, eax
        ret
%endmacro

FT