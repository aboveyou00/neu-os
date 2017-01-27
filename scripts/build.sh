

set -e
mkdir -p bin

nasm -f bin -w+orphan-labels -i src/ -p src/special/mixins.asm src/bootloader.asm -o bin/bootloader

nasm -f bin -w+orphan-labels -i src/ -p src/special/mixins.asm src/special/floppya.asm -o bin/floppya.img

dd if=bin/bootloader of=bin/floppya.img
