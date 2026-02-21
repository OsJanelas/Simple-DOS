[BITS 16]
[ORG 0x7C00]

start:
    mov si, welcome_msg
    call print_string

main_loop:
    mov si, prompt
    call print_string

    mov ah, 0x00
    int 0x16

    mov ah, 0x0E
    int 0x10

    cmp al, 'r'
    je reboot

    jmp main_loop

print_string:
    lodsb
    or al, al
    jz done
    mov ah, 0x0E
    int 0x10
    jmp print_string
done:
    ret

reboot:
    jmp 0xFFFF:0000

welcome_msg db 'YOUR DOS RUNNED! Press [r] to restart', 13, 10, 0
prompt db '> ', 0

times 510-($-$$) db 0
dw 0xAA55