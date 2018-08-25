MEMORY {
	BOOTLOADER(rx)	: ORIGIN = 0x0, LENGTH = 0x2000		/* 8K */
	FLASH(rx)	: ORIGIN = 0x2000, LENGTH = 0x3e000	/* 248K */
	RAM(rwx)	: ORIGIN = 0x20000000, LENGTH = 0x8000	/* 32K */
	DEVA(rw)	: ORIGIN = 0x40000000, LENGTH = 0x1C00	/* 7K */
	DEVB(rw)	: ORIGIN = 0x41000000, LENGTH = 0x1C00
	DEVC(rw)	: ORIGIN = 0x42000000, LENGTH = 0x1C00
}

SECTIONS {
	. = ORIGIN(FLASH);
	.interrupt_vector : {
		. = ALIGN(4);
		KEEP(*(.interrupt_vector))
	}
	.text . : {
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

