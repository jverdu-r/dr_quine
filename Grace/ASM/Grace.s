%define FILENAME "Grace_kid.s"
%define FILEMODE "w"
%define CONTENT "%cdefine FILENAME %c%s%c%c%cdefine FILEMODE %c%s%c%c%cdefine CONTENT %c%s%c%c"

; Grace assembly quine
section .data
filename db FILENAME, 0
mode db FILEMODE, 0
data db CONTENT, 0

; Array of pointers to format strings
parts_array:
    dq part1, part2, part3, part4, part5, part6, part7, part8
    dq part9, part10, part11, part12, part13, part14, part15, part16
    dq part17, part18
parts_count equ ($ - parts_array) / 8

; Format strings for different parts of the source
part1 db "%cdefine FILENAME %c%s%c%c", 0          ; First macro
part2 db "%cdefine FILEMODE %c%s%c%c", 0          ; Second macro  
part3 db "%cdefine CONTENT %c%s%c%c%c", 0         ; Third macro
part4 db "; Grace assembly quine%c", 0             ; Comment
part5 db "section .data%c", 0                     ; Data section header
part6 db "filename db FILENAME, 0%c", 0           ; Data declarations
part7 db "mode db FILEMODE, 0%c", 0
part8 db "data db CONTENT, 0%c%c", 0              ; Data + blank line
part9 db "section .text%c", 0                     ; Text section header
part10 db "    global main%c", 0                  ; Global declaration
part11 db "    extern fopen, fprintf, fclose%c%c", 0  ; Extern + blank line
part12 db "main:%c", 0                            ; Main label
part13 db "    push rbp%c    mov rbp, rsp%c    push r12%c", 0  ; Function prologue
part14 db "    lea rdi, [rel filename]%c    lea rsi, [rel mode]%c", 0
part15 db "    call fopen wrt ..plt%c    mov r12, rax%c", 0
part16 db "    ; Write source code using loop%c", 0
part17 db "    mov rdi, r12%c    call fclose wrt ..plt%c", 0
part18 db "    pop r12%c    pop rbp%c    xor eax, eax%c    ret%c", 0

section .text
global main
extern fopen, fprintf, fclose

main:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    
    ; Open file
    lea rdi, [rel filename]
    lea rsi, [rel mode]
    call fopen wrt ..plt
    mov r12, rax
    test rax, rax
    jz exit_fail
    
    ; Initialize loop variables
    mov r13, 0                    ; loop counter
    lea r14, [rel parts_array]    ; pointer to parts array
    
write_loop:
    ; Check if we've written all parts
    cmp r13, parts_count
    jge loop_done
    
    ; Get current part pointer
    mov rsi, [r14 + r13*8]        ; Load parts_array[r13]
    mov rdi, r12                  ; FILE pointer
    
    ; Handle different parts with different arguments
    cmp r13, 0                    ; part1: %define FILENAME
    je write_part1
    cmp r13, 1                    ; part2: %define FILEMODE  
    je write_part2
    cmp r13, 2                    ; part3: %define CONTENT
    je write_part3
    cmp r13, 7                    ; part8: has extra newline
    je write_part8
    cmp r13, 10                   ; part11: has extra newline
    je write_part11
    cmp r13, 12                   ; part13: has 3 newlines
    je write_part13
    cmp r13, 13                   ; part14: has 2 newlines
    je write_part14
    cmp r13, 14                   ; part15: has 2 newlines
    je write_part15
    cmp r13, 16                   ; part17: has 2 newlines
    je write_part17
    cmp r13, 17                   ; part18: has 4 newlines
    je write_part18
    
    ; Default case: simple parts with just one newline
    mov rdx, 10                   ; newline
    mov rax, 0
    call fprintf wrt ..plt
    jmp next_part
    
write_part1:
    mov rdx, 37                   ; %
    mov rcx, 34                   ; "
    lea r8, [rel filename]        ; filename string
    mov r9, 34                    ; "
    push 10                       ; newline
    mov rax, 0
    call fprintf wrt ..plt
    add rsp, 8
    jmp next_part
    
write_part2:
    mov rdx, 37                   ; %
    mov rcx, 34                   ; "
    lea r8, [rel mode]            ; mode string  
    mov r9, 34                    ; "
    push 10                       ; newline
    mov rax, 0
    call fprintf wrt ..plt
    add rsp, 8
    jmp next_part
    
write_part3:
    mov rdx, 37                   ; %
    mov rcx, 34                   ; "
    lea r8, [rel data]            ; content string
    mov r9, 34                    ; "
    push 10                       ; newline
    push 10                       ; blank line
    mov rax, 0
    call fprintf wrt ..plt
    add rsp, 16
    jmp next_part

write_part8:
    mov rdx, 10                   ; newline
    mov rcx, 10                   ; blank line
    mov rax, 0
    call fprintf wrt ..plt
    jmp next_part

write_part11:
    mov rdx, 10                   ; newline
    mov rcx, 10                   ; blank line
    mov rax, 0
    call fprintf wrt ..plt
    jmp next_part

write_part13:
    mov rdx, 10                   ; newline
    mov rcx, 10                   ; newline
    mov r8, 10                    ; newline
    mov rax, 0
    call fprintf wrt ..plt
    jmp next_part

write_part14:
    mov rdx, 10                   ; newline
    mov rcx, 10                   ; newline
    mov rax, 0
    call fprintf wrt ..plt
    jmp next_part

write_part15:
    mov rdx, 10                   ; newline
    mov rcx, 10                   ; newline
    mov rax, 0
    call fprintf wrt ..plt
    jmp next_part

write_part17:
    mov rdx, 10                   ; newline
    mov rcx, 10                   ; newline
    mov rax, 0
    call fprintf wrt ..plt
    jmp next_part

write_part18:
    mov rdx, 10                   ; newline
    mov rcx, 10                   ; newline
    mov r8, 10                    ; newline
    mov r9, 10                    ; newline
    mov rax, 0
    call fprintf wrt ..plt
    jmp next_part
    
next_part:
    inc r13                       ; increment counter
    jmp write_loop
    
loop_done:
    ; Close file
    mov rdi, r12
    call fclose wrt ..plt
    
    pop r14
    pop r13
    pop r12
    pop rbp
    xor eax, eax
    ret

exit_fail:
    pop r14
    pop r13
    pop r12
    pop rbp
    mov eax, 1
    ret
