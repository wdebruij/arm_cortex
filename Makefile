
TARGET=arm-none-eabi
AS=$(TARGET)-as
OBJCOPY=$(TARGET)-objcopy
OBJDUMP=$(TARGET)-objdump
NM=$(TARGET)-nm
LD=$(TARGET)-ld

CFLAGS=-O0 -ggdb -mthumb -mcpu=cortex-m0plus -nostartfiles

TSTAMP= `/bin/date "+%Y%m%d-%H%M%S"`

%.o: %.asm
	$(AS) -mcpu=cortex-m0plus -mthumb -o $@ $?

%.m0.elf: %.o cortex_m0plus.ld
	$(LD) -T cortex_m0plus.ld --gc-sections $< -o $@

%.m3.elf: %.o cortex_m3.ld
	$(LD) -T cortex_m3.ld --gc-sections $< -o $@

%.lm3s.elf: %.o stellaris-lm3s6965.ld
	$(LD) -T stellaris-lm3s6965.ld --gc-sections $< -o $@

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
	sudo ./bossac -o 0x2000 -e -w -v -R $<

.PHONY: all backup clean distclean qemu qemu-debug

.PRECIOUS: %.o %.elf %.bin

all: basic.m0.bin basic.m3.bin

backup:
	sudo ./bossac -r image-backup-$(TSTAMP).bin

clean:
	rm -f *.o

distclean: clean
	rm -f *.bin *.elf

qemu: basic.lm3s.bin
	qemu-system-arm \
		-cpu cortex-m3 \
		-M lm3s6965evb \
		-nographic \
		-monitor null \
		-serial null \
		-semihosting \
		-kernel $?

qemu-debug: basic.lm3s.bin
	# note the use of the .elf file in gdb (optional)
	echo "start gdb-multiarch basic.lm3s.elf with 'target remote localhost:8000; load; continue'"
	qemu-system-arm \
		-M lm3s6965evb \
		-nographic \
		-monitor null \
		-serial null \
		-semihosting \
		-kernel $? \
		-gdb tcp::8000 -S

