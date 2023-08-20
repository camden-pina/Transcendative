.section .multiboot_header
.align 8
header_start:
    .long 0xe85250d6                // magic number (multiboot 2)
    .long 0                         // architecture (protected mode i386)
    .long header_end - header_start // header length
    .long -(0xe85250d6 + 0 + (header_end - header_start))

    // required end tag
    .long 0    // type
    .long 0    // flags
    .long 8    // size
header_end:


.section .text
.globl _start
_start:
    // Push the pointer to the Multiboot information structure
    pushq %rbx

    // Push the magic value
    pushq %rax

    movq %rax, %rdi
    movq %rbx, %rsi

    // Call kernel_entry
    call kernel_entry

    // Add any cleanup code if necessary

