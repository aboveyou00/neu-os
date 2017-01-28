

  org 0x7c00
  jmp 0:main

main:
  mov ax, 0
  mov ss, ax
  mov es, ax
  mov ss, ax
  mov sp, 0x7c00 ; Setup segments and stack

  mov ax, 0x0003
  int 0x10 ; Set 80x25 text mode. Also clears the screen

  call enable_a20
  call load_full_bootloader
  jmp enter_protected_mode

enable_a20:
  in al, 0x93
  or al, 0b10
  and al, ~0b01
  out 0x92, al
  mov si, str_a20_enabled
  call print_message
  ret

load_full_bootloader:
  
  .success:
    mov si, str_found_full_bootloader
    call print_message
    ret
  .err:
    mov si, err_no_full_bootloader
    call print_message
    jmp halt

enter_protected_mode:
  cli
  lgdt [gdtr]
  mov eax, cr0
  or al, 1
  mov cr0, eax
  jmp (gdt.code-gdt):enter_full_bootloader

enter_full_bootloader:
  mov si, str_in_protected_mode
  call print_message
  jmp halt

; itos:
;   mov si, storage.end-1
;   .itos_loop:
;     mov dx, 0
;     mov cx, 10
;     div cx
;     xchg ax, dx
;     add al, '0'
;     dec si
;     mov [si], al
;     mov ax, dx
;     or ax, ax
;     jnz .itos_loop
;   .after:
;     ret
; storage times 4 db 0
;   .end:

print_message:
  lodsb
  or al, al
  jz .done

  mov ah, 0x0E
  int 0x10 ; Print 'character'
  jmp print_message

  .done:
    ret

halt:
  cli
  hlt
  jmp halt

str_found_full_bootloader db 'found bootloader', CRLF, NULL
err_no_full_bootloader db 'err:no bootloader', CRLF, NULL
str_a20_enabled db 'enabled a20', CRLF, NULL
err_enable_a20 db 'err:a20 disabled', CRLF, NULL
str_in_protected_mode db 'in protected mode', CRLF, NULL

struc gdt_entry_struct
  .limit_low:   resb 2
  .base_low:    resb 2
  .base_middle: resb 1
  .access:      resb 1
  .granularity: resb 1
  .base_high:   resb 1
endstruc

gdt:
  .null times 2 dd 0
  .code istruc gdt_entry_struct
          at gdt_entry_struct.limit_low, dw 0xffff
          at gdt_entry_struct.base_low, dw 0
          at gdt_entry_struct.base_middle, db 0
          at gdt_entry_struct.access, db 10011010b
          at gdt_entry_struct.granularity, db 00001111b
          at gdt_entry_struct.base_high, db 0
        iend
  .data istruc gdt_entry_struct
          at gdt_entry_struct.limit_low, dw 0xffff
          at gdt_entry_struct.base_low, dw 0
          at gdt_entry_struct.base_middle, db 0
          at gdt_entry_struct.access, db 10010010b
          at gdt_entry_struct.granularity, db 00001111b
          at gdt_entry_struct.base_high, db 0
        iend
gdtr:
  .size dw $-gdt-1
  .offset dd gdt

pad:
  times 510-($-$$) db 0
boot_signature:
  db 0x55,0xAA
