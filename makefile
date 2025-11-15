KERNEL_SRC	= kernel/src
DRIVER_DIR 	= drivers/
BIN_DIR		= bin
ISODIR		= isodir
INC 		= include
CC 		= x86_64-elf-gcc
C_FLAGS		= -ffreestanding -O2 -nostdlib -mcmodel=kernel
INC_DIR 	= include/
all: build

rmbin:
	rm -rf bin
mkbin: rmbin
	mkdir -p bin
build: mkbin
	${CC} -c ${C_FLAGS} -I${INC_DIR} ${KERNEL_SRC}/main.c -o ${BIN_DIR}/kernel_main.o
	${CC} -c ${C_FLAGS} -I${INC_DIR} ${KERNEL_SRC}/kernel.c -o ${BIN_DIR}/kernel.o
	${CC} -c ${C_FLAGS} -I${INC_DIR} ${DRIVER_DIR}/video/framebuffer.c -o ${BIN_DIR}/framebuffer.o

	${CC} -T ${KERNEL_SRC}/linker.ld ${BIN_DIR}/kernel_main.o \
		${BIN_DIR}/framebuffer.o ${BIN_DIR}/kernel.o -o ${BIN_DIR}/SwirlOS.bin \
		-lgcc -nostdlib
iso: build
	cp ${BIN_DIR}/SwirlOS.bin boot/EFI/limine/boot/SwirlOS.bin

	xorriso -as mkisofs -R -r -J -b limine-bios-cd.bin \
        -no-emul-boot -boot-load-size 4 -boot-info-table -hfsplus \
        -apm-block-size 2048 --efi-boot limine-uefi-cd.bin \
        -efi-boot-part --efi-boot-image --protective-msdos-label \
        boot/EFI/limine -o ${BIN_DIR}/SwirlOS.iso

	limine bios-install ${BIN_DIR}/SwirlOS.iso
run: iso
	qemu-system-x86_64 -cdrom bin/SwirlOS.iso \
		-bios boot/EFI/OVMF.4m.fd \
		-no-reboot \
		-m 2048