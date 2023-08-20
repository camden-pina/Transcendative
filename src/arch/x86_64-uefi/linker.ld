ENTRY(_start)

SECTIONS {
    . = 1M;

    .boot BLOCK(4K) : ALIGN(4K)
    {
        /* ensure that the multiboot header is at the beginning */
        *(.multiboot_header)
    }

    .text BLOCK(4K) : ALIGN(4K)
    {
        *(.text)
    }
}
