; One Comment
BITS 64

section .data
    model db "; One Comment%1$cBITS 64%1$c%1$csection .data%1$c    model db %2$c%3$s%2$c, 0%1$c%1$c; Another Comment%1$csection .text%1$c    global main%1$c    extern printf%1$c%1$c%4$cmacro FT 0%1$cmain:%1$c    push rbp%1$c    mov rbp, rsp%1$c%1$c    write_to_stdout:%1$c        ; Print the quine%1$c        lea rdi, [rel model]%1$c        mov rsi, 10%1$c        mov rdx, 34%1$c        lea rcx, [rel model]%1$c        mov r8, 37%1$c        xor rax, rax%1$c        call printf wrt ..plt%1$c%1$c    exit_process:%1$c        pop rbp%1$c        xor eax, eax%1$c        ret%1$c%4$cendmacro%1$c%1$cFT%1$c", 0

; Another Comment
section .text
    global main
    extern printf

%macro FT 0
main:
    push rbp
    mov rbp, rsp

    write_to_stdout:
        ; Print the quine
        lea rdi, [rel model]
        mov rsi, 10
        mov rdx, 34
        lea rcx, [rel model]
        mov r8, 37
        xor rax, rax
        call printf wrt ..plt

    exit_process:
        pop rbp
        xor eax, eax
        ret
%endmacro

FT