section .rodata
s db "Sully_%d.s", 0
w db "w", 0
f db "section .rodata%cs db %cSully_%%d.s%c, 0%cw db %cw%c, 0%cf db %c%s%c, 0%cc db %cSULLY=Sully_%%d; nasm -felf64 $SULLY.s -o $SULLY.o; gcc -lc $SULLY.o -o $SULLY; ./$SULLY%c, 0%ci dq %d%csection .text%cglobal main%cextern snprintf%cextern printf%cextern exit%cextern fopen%cextern fclose%cextern fprintf%cextern system%cmain:%ccmp byte [rel i], 0%cje .end%csub rsp, 24%clea rdi, [rsp]%cmov rsi, 16%clea rdx, [rel s]%cmov rcx, [rel i]%cdec rcx%ccall snprintf wrt ..plt%clea rdi, [rsp]%clea rsi, [rel w]%ccall fopen wrt ..plt%csub rsp, 576%cmov rbx, rax%cmov rdi, rbx%clea rsi, [rel f]%cmov rdx, 10%cmov r8, 34%cmov r9, 10%cmov ecx, 71%c.push_loop:%cpush 10%cdec ecx%cjnz .push_loop%cmov rcx, [rel i]%cdec rcx%cpush rcx%cpush 10%cpush 34%cpush 34%cpush 10%cpush 34%clea rcx, [rel f]%cpush rcx%cpush 34%cpush 10%cpush 34%cpush 34%cmov rcx, 34%ccall fprintf wrt ..plt%cmov rdi, rbx%ccall fclose wrt ..plt%csub rsp, 96%clea rdi, [rsp]%cmov rsi, 96%clea rdx, [rel c]%cmov rcx, [rel i]%cdec rcx%ccall snprintf wrt ..plt%clea rdi, [rsp]%ccall system wrt ..plt%cadd rsp, 24%cjmp .end%c.end:%cmov rdi, 0%ccall exit wrt ..plt%c", 0
c db "SULLY=Sully_%d; nasm -felf64 $SULLY.s -o $SULLY.o; gcc -lc $SULLY.o -o $SULLY; ./$SULLY", 0
i dq 5
section .text
global main
extern snprintf
extern printf
extern exit
extern fopen
extern fclose
extern fprintf
extern system
main:
cmp byte [rel i], 0
je .end
sub rsp, 24
lea rdi, [rsp]
mov rsi, 16
lea rdx, [rel s]
mov rcx, [rel i]
; Don't decrement for original - use full value for filename
call snprintf wrt ..plt
lea rdi, [rsp]
lea rsi, [rel w]
call fopen wrt ..plt
sub rsp, 576
mov rbx, rax
mov rdi, rbx
lea rsi, [rel f]
mov rdx, 10
mov r8, 34
mov r9, 10
mov ecx, 71
.push_loop:
push 10
dec ecx
jnz .push_loop
mov rcx, [rel i]
; Use original value for content, not decremented  
push rcx
push 10
push 34
push 34
push 10
push 34
lea rcx, [rel f]
push rcx
push 34
push 10
push 34
push 34
mov rcx, 34
call fprintf wrt ..plt
mov rdi, rbx
call fclose wrt ..plt
sub rsp, 96
lea rdi, [rsp]
mov rsi, 96
lea rdx, [rel c]
mov rcx, [rel i]
; Use original value for command generation
call snprintf wrt ..plt
lea rdi, [rsp]
call system wrt ..plt
add rsp, 24
jmp .end
.end:
mov rdi, 0
call exit wrt ..plt