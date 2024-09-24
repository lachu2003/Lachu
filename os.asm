; boot.asm - Simple Bootloader

[org 0x7C00]    ; Set origin where BIOS loads the bootloader

start:
    mov ax, 0x07C0   ; Set up stack
    add ax, 288
    mov ss, ax
    mov sp, 4096

    mov si, boot_msg ; Load message into SI register
    call print_string ; Print the message

    jmp $            ; Infinite loop

print_string:
    lodsb            ; Load byte from [SI] to AL
    or al, al        ; Check if end of string (null terminator)
    jz halt
    mov ah, 0x0E     ; BIOS teletype output function
    int 0x10         ; BIOS interrupt to print the character
    jmp print_string ; Repeat
halt:
    jmp $            ; Infinite loop to halt the system

boot_msg db 'Booting my OS...', 0

times 510-($-$$) db 0  ; Fill remaining space in boot sector with zeros
dw 0xAA55              ; Boot sector signature (required)
