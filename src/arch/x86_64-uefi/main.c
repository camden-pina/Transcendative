#include "multiboot2.h"
#include <stdint.h>

void kernel_entry(uint32_t magic, uint32_t mb_info) {
	int lols;
	// This is called every time
	if (magic != MULTIBOOT2_BOOTLOADER_MAGIC) {
		lols = 0 / 0;
	}

	// The computer never gets here.
	for (;;);
}

