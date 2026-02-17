ENTRY(_start)

MEMORY
{
    IMEM (rx)  : ORIGIN = 0x00000000, LENGTH = 4K
    DMEM (rw)  : ORIGIN = 0x00010000, LENGTH = 4K
}

SECTIONS
{
    /* Instruction memory */
    .text : {
        *(.text*)
    } > IMEM

    /* Data memory (read-only constants included) */
    .rodata : {
        *(.rodata*)
        *(.srodata*)
    } > DMEM

    .data : {
        *(.data*)
        *(.sdata*)
    } > DMEM

    .bss : {
        *(.sbss*)
        *(.bss*)
        *(COMMON)
    } > DMEM
}
