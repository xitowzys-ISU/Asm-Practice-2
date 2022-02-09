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

section .text
    global _start

_start:
    mov ebx, 0

_loop:
    mov cl, [array + ebx]
    cmp cl, 97
    jge _toUpper
_continue:
    inc ebx
    cmp ebx, alen
    jne _loop

    print alen, array
    
    mov ebx, 0
    mov eax, 1;sys_exit
    int 0x80; call hernel
    
_toUpper:
    sub cl, 32
    mov [array + ebx], cl
    jmp _continue
    
section .data
    array db "MeSSaGe"
    alen equ $ - array
    
section .bss
    result resb 1