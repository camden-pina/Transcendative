# Include the .config file
include .config

# Determine architecture
ARCH :=
ifeq ($(CONFIG_X86_64_BIOS),y)
ARCH := x86_64-bios
CC := i686-elf-gcc
LD := i686-elf-ld
else ifeq ($(CONFIG_X86_64_UEFI),y)
ARCH := x86_64-uefi
CC := x86_64-elf-gcc
LD := x86_64-elf-ld
endif

BUILD_DIR := $(CURDIR)
export BUILD_DIR

# Set targets and linker
TARGET := build/boot-$(ARCH).bin
ISO := build/os-$(ARCH).iso
export CC
export LD
export ARCH

# Set subdirectories
SUB_MAKEFILE_DIR := src/arch/$(ARCH)

.PHONY: all clean run iso submake

# Build rules
all: $(TARGET)

$(TARGET): submake

iso: $(ISO)

$(ISO): $(TARGET)

	@mkdir -p build/isofiles

	# grub
	@mkdir -p build/isofiles/boot/grub
	@cp src/arch/$(ARCH)/grub.cfg build/isofiles/boot/grub

ifeq ($(CONFIG_X86_64_BIOS),y)
	@cp $(TARGET) build/isofiles/boot/kernel.bin
	@grub-mkrescue -o $(ISO) build/isofiles -d modules/i386-pc
else ifeq ($(CONFIG_X86_64_UEFI),y)
	@cp $(TARGET) build/isofiles/boot/kernel.bin
	@grub-mkrescue -o $(ISO) build/isofiles -d modules/x86_64-efi
endif
	@rm -r build/isofiles

submake:
	@$(MAKE) -C $(SUB_MAKEFILE_DIR)

clean:
	@rm -rf build

run: $(ISO)
ifeq ($(CONFIG_X86_64_BIOS),y)
	qemu-system-x86_64 -cdrom $(ISO)
else ifeq ($(CONFIG_X86_64_UEFI),y)
	qemu-system-x86_64 -drive file=$(ISO),if=ide -bios RELEASEX64_OVMF.fd
endif

run-debug:
ifeq ($(CONFIG_X86_64_UEFI),y)
	qemu-system-x86_64 -drive file=$(ISO),if=ide -bios RELEASEX64_OVMF.fd -s -S
endif
