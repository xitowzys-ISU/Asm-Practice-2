%macro print 2
    mov edx, %1
    mov ecx, %2
    mov ebx, 1
    mov eax, 4
    int 0x80
%endmacro

section .text
    global _start

_start:
    mov cl,  [count]

_repeat:
    push ecx
    print 1, symbol
    pop ecx
    dec cl
    cmp cl, 0
    jg _repeat

    mov eax, 1;sys_exit
    int 0x80; call hernel
    
section .data
    count db 10
    symbol db "*"