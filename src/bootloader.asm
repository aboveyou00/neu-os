

  org 0x7c00
  jmp 0:main

main:
  mov ax, 0x0003
  int 0x10 ; Set 80x25 text mode. Also clears the screen

  mov si, hello_world_str
  call print_string

  mov ax, 42
  call itos
  call print_string

halt:
  hlt
  jmp halt

itos:
  mov si, storage.end-1
  .itos_loop:
    mov dx, 0
    mov cx, 10
    div cx
    xchg ax, dx
    add al, '0'
    dec si
    mov [si], al
    mov ax, dx
    or ax, ax
    jnz .itos_loop
  .after:
    ret
storage times 4 db 0
  .end:

print_string:
  lodsb
  or al, al
  jz .done

  mov ah, 0x0E
  int 0x10 ; Print 'character'
  jmp print_string

  .done:
    ret

hello_world_str db 'Hello, World!', CARRIAGE_RETURN, LINE_FEED, NULL

pad:
  times 510-($-$$) db 0
boot_signature:
  db 0x55,0xAA
