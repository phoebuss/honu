/*
#if defined(CONF_USE_BLUETOOTH)
#define BT_RSV_DRAM 0x10000
#else
#define BT_RSV_DRAM 0
#endif
*/

BT_RSV_DRAM = 0x10000;

MEMORY
{
    iram (RX) : ORIGIN = 0x40080000, LENGTH = 0x2000 /* 128KB */

    /* The entire segment should have been 328KB (SRAM1 + SRAM2). We can only
     * make use of at most 176KB due to usage from ROM APIs. */
    dram (RW) : ORIGIN = 0x3FFB0000 + BT_RSV_DRAM, LENGTH = 0x2C200 - BT_RSV_DRAM /* 176KB */ }

ENTRY(__start);

SECTIONS
{
    .text ORIGIN(iram) + 0x400 :
    {
        __text_start = ABSOLUTE(.);

/*        . = 0x400; /* first 1k reserved for vectors */
        *(.literal .text);

        __text_end = ABSOLUTE(.);
    } > iram

    .rodata :
    {
        . = ALIGN(4);
        __rodata_start = ABSOLUTE(.);

        *(.rodata);

        __rodata_end = ABSOLUTE(.);
    } > dram

    .data :
    {
        . = ALIGN(4);
        __data_start = ABSOLUTE(.);

        *(.data);

        __data_end = ABSOLUTE(.);
    } > dram

    .bss :
    {
        . = ALIGN(4);
        __bss_start = ABSOLUTE(.);

        *(.bss);

        __bss_end = ABSOLUTE(.);
    } > dram

    .heap (NOLOAD) :
    {
        . = ALIGN(16);
        __heap_start = ABSOLUTE(.);
    } > dram

    /DISCARD/ : {*(*)}
}

ASSERT(((__text_end - ORIGIN(iram)) <= LENGTH(iram)),
        "iram overflow!!!");
ASSERT(((__heap_start - ORIGIN(dram)) <= LENGTH(dram)),
        "dram overflow!!!");

/*PROVIDE(esp_rom_printf = 0x40007d54);*/
