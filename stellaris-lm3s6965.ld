MEMORY {
	FLASH(rx)	: ORIGIN = 0x00000000, LENGTH = 256K
	RAM(rwx)	: ORIGIN = 0x20000000, LENGTH = 32K
}

ENTRY(reset_handler)

SECTIONS {
	. = ORIGIN(FLASH);
	.text . : {
		. = ALIGN(4);
		KEEP(*(.interrupt_vector))
		. = ALIGN(2);
		*(.text)
	}

	. = ORIGIN(RAM);
	.data : {
		. = ALIGN(4);
		KEEP(*(.data))
	}
	/* .rodata : { *(.rodata) } */
	/* .bss : { *(.bss) } */

	.port 0x41004400 : {
		. = ALIGN(4);
		KEEP(*(.port_table))
	}
}

