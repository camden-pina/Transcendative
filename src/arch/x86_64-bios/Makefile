assembly_source_files := $(wildcard *.s)
assembly_object_files := $(patsubst %.s, \
			 $(BUILD_DIR)/build/arch/$(ARCH)/%.o, $(assembly_source_files))

all: $(BUILD_DIR)/build/boot-$(ARCH).bin

$(BUILD_DIR)/build/boot-$(ARCH).bin: $(assembly_object_files)
	$(LD) -n -T linker.ld -o $@ $(assembly_object_files)
	#$(LD) -n -o $@ $(assembly_object_files)
	#cp $(BUILD_DIR)/build/arch/$(ARCH)/stage1.o $(BUILD_DIR)/build/boot-$(ARCH).bin

# compile assembly files
$(BUILD_DIR)/build/arch/$(ARCH)/%.o: %.s
	mkdir -p $(shell dirname $@)
	nasm -f elf32 $< -o $@

# Run this after the build for all modules have sucessfuly completed.
populate_ramdisk:
	# Copy bootloader
	sudo cp $(BUILD_DIR)/build/boot-$(ARCH).bin $(ramdisk_mntpoint)
