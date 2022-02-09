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
    mov ecx, 10
    mov edx, 0
    mov eax, 124
    div ecx

    mov eax, edx ; edx - reminder, eax - quotent
    add eax, '0'; Fix number -> ascii
    mov [result], eax
    print 1, result 

    mov eax, 1;sys_exit
    int 0x80; call hernel
    
section .bss
    result resb 1
