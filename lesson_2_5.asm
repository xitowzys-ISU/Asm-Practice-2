%macro print 2
    pushd
    mov edx, %1
    mov ecx, %2
    mov ebx, 1
    mov eax, 4
    int 0x80
    popd
%endmacro

%macro pushd 0
    push eax
    push ebx
    push ecx
    push edx
%endmacro

%macro popd 0
    pop edx
    pop ecx
    pop ebx
    pop eax
%endmacro

%macro dprint 0
    pushd
    mov ecx, 10
    mov bx, 0

%%_divide:
    mov edx, 0
    div ecx
    push dx
    inc bx
    test eax, eax
    jnz %%_divide

%%_digit:
    pop ax
    add ax, '0'
    mov [result], ax
    print 1, result
    dec bx
    cmp bx, 0
    jnz %%_digit
    popd
%endmacro

section .text
    global _start

_start:
    mov ebx, 0
    
_loop:
    add al, [array + ebx]
    inc ebx
    cmp ebx, alen
    jne _loop
    
    dprint
    
    mov ebx, 0
    mov eax, 1;sys_exit
    int 0x80; call hernel
    
section .data
    array db 10, 13, 14, 7, 8, 12
    alen equ $ - array
    number dd 39400
    message db "Done"
    len equ $ - message
    newline db 0xA, 0xD
    nlen equ $ - newline
    
section .bss
    result resb 1