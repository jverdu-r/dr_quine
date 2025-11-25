BITS 64

section .data
    model db "BITS 64%1$c%1$csection .data%1$c    model db %2$c%3$s%2$c, 0%1$c    filename db %2$cSully_%4$d.s%2$c, 0%1$c    mode_w db %2$cw%2$c, 0%1$c    compile_cmd db %2$cnasm -felf64 -g -o Sully_%4$d.o Sully_%4$d.s && gcc -no-pie Sully_%4$d.o -o Sully_%4$d%2$c, 0%1$c    run_cmd db %2$c./Sully_%4$d%2$c, 0%1$c%1$csection .text%1$c    global main%1$c    extern fopen%1$c    extern fclose%1$c    extern fprintf%1$c    extern system%1$c    extern sprintf%1$c%1$cmain:%1$c    push rbp%1$c    mov rbp, rsp%1$c    push rbx%1$c    push r12%1$c    sub rsp, 64%1$c%1$c    mov eax, %4$d%1$c    dec eax%1$c    cmp eax, 0%1$c    jl exit_process%1$c    mov r12, rax%1$c%1$c    ; Create filename%1$c    lea rdi, [rsp]%1$c    lea rsi, [rel filename]%1$c    mov rdx, r12%1$c    xor rax, rax%1$c    call sprintf wrt ..plt%1$c%1$c    ; Open file%1$c    lea rdi, [rsp]%1$c    lea rsi, [rel mode_w]%1$c    call fopen wrt ..plt%1$c    test rax, rax%1$c    jz exit_process%1$c    mov rbx, rax%1$c%1$c    ; Write source to file%1$c    mov rdi, rbx%1$c    lea rsi, [rel model]%1$c    mov rdx, 10%1$c    mov rcx, 34%1$c    lea r8, [rel model]%1$c    mov r9, r12%1$c    xor rax, rax%1$c    call fprintf wrt ..plt%1$c%1$c    ; Close file%1$c    mov rdi, rbx%1$c    call fclose wrt ..plt%1$c%1$c    ; Create compile command%1$c    lea rdi, [rsp+32]%1$c    lea rsi, [rel compile_cmd]%1$c    mov rdx, r12%1$c    mov rcx, r12%1$c    mov r8, r12%1$c    mov r9, r12%1$c    xor rax, rax%1$c    call sprintf wrt ..plt%1$c%1$c    ; Execute compile%1$c    lea rdi, [rsp+32]%1$c    call system wrt ..plt%1$c%1$c    ; Create run command%1$c    lea rdi, [rsp+32]%1$c    lea rsi, [rel run_cmd]%1$c    mov rdx, r12%1$c    xor rax, rax%1$c    call sprintf wrt ..plt%1$c%1$c    ; Execute program%1$c    lea rdi, [rsp+32]%1$c    call system wrt ..plt%1$c%1$cexit_process:%1$c    add rsp, 64%1$c    pop r12%1$c    pop rbx%1$c    pop rbp%1$c    xor eax, eax%1$c    ret%1$c", 0
    filename db "Sully_%d.s", 0
    mode_w db "w", 0
    compile_cmd db "nasm -felf64 -g -o Sully_%d.o Sully_%d.s && gcc -no-pie Sully_%d.o -o Sully_%d", 0
    run_cmd db "./Sully_%d", 0

section .text
    global main
    extern fopen
    extern fclose
    extern fprintf
    extern system
    extern sprintf

main:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    sub rsp, 64

    mov eax, 5
    dec eax
    cmp eax, 0
    jl exit_process
    mov r12, rax

    ; Create filename
    lea rdi, [rsp]
    lea rsi, [rel filename]
    mov rdx, r12
    xor rax, rax
    call sprintf wrt ..plt

    ; Open file
    lea rdi, [rsp]
    lea rsi, [rel mode_w]
    call fopen wrt ..plt
    test rax, rax
    jz exit_process
    mov rbx, rax

    ; Write source to file
    mov rdi, rbx
    lea rsi, [rel model]
    mov rdx, 10
    mov rcx, 34
    lea r8, [rel model]
    mov r9, r12  ; Use the decremented value (same as filename)
    xor rax, rax
    call fprintf wrt ..plt

    ; Close file
    mov rdi, rbx
    call fclose wrt ..plt

    ; Create compile command
    lea rdi, [rsp+32]
    lea rsi, [rel compile_cmd]
    mov rdx, r12
    mov rcx, r12
    mov r8, r12
    mov r9, r12
    xor rax, rax
    call sprintf wrt ..plt

    ; Execute compile
    lea rdi, [rsp+32]
    call system wrt ..plt

    ; Create run command
    lea rdi, [rsp+32]
    lea rsi, [rel run_cmd]
    mov rdx, r12
    xor rax, rax
    call sprintf wrt ..plt

    ; Execute program
    lea rdi, [rsp+32]
    call system wrt ..plt

exit_process:
    add rsp, 64
    pop r12
    pop rbx
    pop rbp
    xor eax, eax
    ret
