
TARGET=arm-none-eabi
AS=$(TARGET)-as
OBJCOPY=$(TARGET)-objcopy
OBJDUMP=$(TARGET)-objdump
NM=$(TARGET)-nm
LD=$(TARGET)-ld

CFLAGS=-O0 -mthumb -mcpu=cortex-m0plus -nostartfiles

TSTAMP= `/bin/date "+%Y%m%d-%H%M%S"`

%.o: %.asm
	$(AS) -mthumb -o $@ $?

%.elf: %.o
	$(LD) -T cortex_m0plus.ld --gc-sections $? -o $@

%.bin: %.elf
	$(OBJCOPY) -O binary --only-section=.text $? $@

# helper targets

%.disas_text: %.elf
	$(OBJDUMP) -d $?

%.disas: %.elf
	$(OBJDUMP) -D $?

# disassemble the raw binary file
%.disas_bin: %.bin
	$(OBJDUMP) -marm --disassembler-options=force-thumb -b binary -D $?

%.symtable: %.elf
	$(NM) -n $?

%.upload: %.bin
	sudo ./bossac -r image-backup-$(TSTAMP).bin
	sudo ./bossac -o 0x2000 -e -w -v -R $<

.PHONY: all clean distclean

.PRECIOUS: %.o %.elf %.bin

all: basic.bin

clean:
	rm -f *.o

distclean: clean
	rm -f *.bin *.elf

