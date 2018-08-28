
.thumb
.syntax unified

.section	.interrupt_vector
.align	4

.word	__stack_top
.word	reset_handler
.word	nmi_handler
.word	hardfault_handler
.word	0
.word	0
.word	0
.word	0
.word	0
.word	0
.word	0
.word	0 /* svcall_handler */
.word	0
.word	0
.word	0 /* pendingsv */
.word	0 /* systick_handler */
.word	0 /* irq0_handler */
.word	0 /* irq1_handler */
.word	0 /* irq2_handler */
.word	0 /* irq3_handler */
.word	0 /* irq4_handler */
.word	0 /* irq5_handler */
.word	0 /* irq6_handler */
.word	0 /* irq7_handler */
.word	0 /* irq8_handler */
.word	0 /* irq9_handler */
.word	0 /* irq10_handler */
.word	0 /* irq11_handler */
.word	0 /* irq12_handler */
.word	0 /* irq13_handler */
.word	0 /* irq14_handler */
.word	0 /* irq15_handler */
.word	0 /* irq16_handler */
.word	0 /* irq17_handler */
.word	0 /* irq18_handler */
.word	0 /* irq19_handler */
.word	0 /* irq20_handler */
.word	0 /* irq21_handler */
.word	0 /* irq22_handler */
.word	0 /* irq23_handler */
.word	0 /* irq24_handler */
.word	0 /* irq25_handler */
.word	0 /* irq26_handler */
.word	0 /* irq27_handler */

.text
.align 2

.global reset_handler

reset_handler:
.func reset_handler, reset_handler
.type reset_handler, %function
.thumb_func

init_gpio_pin:
	ldr	r1,	=(1 << 17)
	ldr	r2,	=port_dir_set
	str	r1,	[r2]

set_led_on:
	ldr	r2,	=port_out_set
	str	r1,	[r2]

	ldr	r3,	=(1 << 24)
wait_one_sec_on:
	subs	r3,	#1
	bne	wait_one_sec_on

set_led_off:
	ldr	r2,	=port_out_clear
	str	r1,	[r2]

	ldr	r3,	=(1 << 27)
wait_one_sec_off:
	subs	r3,	#1
	bne	wait_one_sec_off

	b	set_led_on
.endfunc

nmi_handler:
.func nmi_handler, nmi_handler
.type nmi_handler, %function
.thumb_func
	nop
.endfunc

hardfault_handler:
.func hardfault_handler, hardfault_handler
.type hardfault_handler, %function
.thumb_func
	nop
.endfunc

.data
.align 4

__stack_top:

.section	.port_table
port_dir:
.word	0
port_dir_clear:
.word	0
port_dir_set:
.word	0
port_dir_toggle:
.word	0
port_out:
.word	0
port_out_clear:
.word	0
port_out_set:
.word	0
port_out_toggle:
.word	0
port_in:
.word	0
port_ctrl:
.word	0
port_wrconfig:
.word	0
.word	0	/* reserved */
port_pmux0:
.byte	0
port_pmux1:
.byte	0
port_pmux2:
.byte	0
port_pmux3:
.byte	0
port_pmux4:
.byte	0
port_pmux5:
.byte	0
port_pmux6:
.byte	0
port_pmux7:
.byte	0
port_pmux8:
.byte	0
port_pmux9:
.byte	0
port_pmux10:
.byte	0
port_pmux11:
.byte	0
port_pmux12:
.byte	0
port_pmux13:
.byte	0
port_pmux14:
.byte	0
port_pmux15:
.byte	0
port_pincfg0:
.byte	0
port_pincfg1:
.byte	0
port_pincfg2:
.byte	0
port_pincfg3:
.byte	0
port_pincfg4:
.byte	0
port_pincfg5:
.byte	0
port_pincfg6:
.byte	0
port_pincfg7:
.byte	0
port_pincfg8:
.byte	0
port_pincfg9:
.byte	0
port_pincfg10:
.byte	0
port_pincfg11:
.byte	0
port_pincfg12:
.byte	0
port_pincfg13:
.byte	0
port_pincfg14:
.byte	0
port_pincfg15:
.byte	0
port_pincfg16:
.byte	0
port_pincfg17:
.byte	0
port_pincfg18:
.byte	0
port_pincfg19:
.byte	0
port_pincfg20:
.byte	0
port_pincfg21:
.byte	0
port_pincfg22:
.byte	0
port_pincfg23:
.byte	0
port_pincfg24:
.byte	0
port_pincfg25:
.byte	0
port_pincfg26:
.byte	0
port_pincfg27:
.byte	0
port_pincfg28:
.byte	0
port_pincfg29:
.byte	0
port_pincfg30:
.byte	0
port_pincfg31:
.byte	0

	
