ENTRY(_start)

MEMORY
{
    IMEM (rx)  : ORIGIN = 0x00000000, LENGTH = 16K
    DMEM (rw)  : ORIGIN = 0x00004000, LENGTH = 4K
}

_estack = ORIGIN(DMEM) + LENGTH(DMEM);

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
        _heap_start = .; /* if this is outsiode the .bss{} block, then when dmem is empty the pointer is incorrect and ends up in imem */
    } > DMEM

    /* heap len  */
    . += 0x800;
    _heap_end = .;

    /* small guard region */
    . += 0x100; /* guard region of 256B */

    /* bottom of stack */
    _stack_bottom = .;
}
