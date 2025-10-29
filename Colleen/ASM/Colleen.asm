; x86_64 NASM quine that prints its own source.
; Uses incbin to embed the exact bytes of this file at assembly time,
; then uses the write syscall to print them (so runtime does NOT read the file).

global main

section .data
src:
    incbin "Colleen.asm"    ; embed the exact file bytes here
src_end:

section .text
main:
    ; write(1, src, src_end - src)
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    lea rsi, [rel src]  ; buf
    lea rdx, [rel src_end]
    sub rdx, rsi        ; len = src_end - src
    syscall
    xor rax, rax
    ret