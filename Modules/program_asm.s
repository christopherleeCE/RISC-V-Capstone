    .section .text
    .globl _start

_start:
    # # Load address of word_array
    # la   t0, word_array

    # # Load first word
    # lw   t1, 0(t0)

    # # Load byte (signed)
    # lb   t2, 4(t0)

    # # Load halfword (unsigned)
    # lhu  t3, 6(t0)

    # # Store something into data section
    # la   t4, writable_word
    # sw   t1, 0(t4)

    # # Write to BSS
    # la   t5, buffer
    # sw   t3, 0(t5)

    li sp, 10000

    nop
    nop
    nop
    nop
    nop
    ebreak
    ########################################################
    # Read-only data section
    ########################################################
    .section .rodata
const_string:
    .asciz "Hello DMEM"

const_table:
    .word 0xDEADBEEF
    .word 0xCAFEBABE
    .word 0x12345678


    ########################################################
    # Initialized data section
    ########################################################
    .section .data

# Word-aligned array
    .align 2
word_array:
    .word 0x11223344
    .byte 0x55
    .byte 0x66
    .half 0x7788
    .word 13
    .word -1

writable_word:
    .word 0xAABBCCDD


    ########################################################
    # Uninitialized data section
    ########################################################
    .section .bss

    .align 2
buffer:
    .space 64

counter:
    .space 4