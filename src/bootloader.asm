

  org 0x7c00
  jmp 0:main

main:
  mov ax, 0x0003
  int 0x10 ; Set 80x25 text mode. Also clears the screen

  mov si, hello_world_str
  call print_string

halt:
  hlt
  jmp halt

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
