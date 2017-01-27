


  org 0x7c00
  BREAK
  jmp 0:main

main:
  BREAK
  
halt:
  hlt
  jmp halt

hello_world_str: db 'Hello, World!', NULL

pad:
  times 510-($-$$) db 0
boot_signature:
  db 0x55,0xAA
