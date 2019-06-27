	.file	1 "uartrx.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, gp= 0
	.mask	0x800f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$19,32($sp)
	sw	$18,28($sp)
	sw	$17,24($sp)
	sw	$16,20($sp)
	li	$2,1			# 0x1
	li	$3,1006632960			# 0x3c000000
	sw	$2,224($3)
	andi	$2,$2,0xff
	ori	$2,$2,0x80
	li	$4,-121			# 0xffffffffffffff87
	and	$2,$2,$4
	li	$4,-8			# 0xfffffffffffffff8
	and	$2,$2,$4
	ori	$2,$2,0x1
	sw	$2,224($3)
	move	$16,$0
	li	$17,1006632960			# 0x3c000000
	lui	$19,%hi(s)
	addiu	$19,$19,%lo(s)
	b	$L2
	li	$18,4			# 0x4

$L3:
	jal	delay_cycle
	li	$4,1			# 0x1

	b	$L2
	nop

$L4:
	jal	to_stdout
	li	$4,10			# 0xa

	jal	to_stdout
	move	$4,$18

	addiu	$3,$16,1
$L10:
	addu	$16,$16,$19
	lb	$2,0($16)
	nop
	beq	$2,$18,$L9
	move	$16,$3

$L2:
	lw	$2,228($17)
	nop
	srl	$2,$2,5
	andi	$2,$2,0x1
	beq	$2,$0,$L3
	nop

	lw	$4,236($17)
	nop
	sll	$4,$4,24
	sra	$4,$4,24
	addu	$2,$16,$19
	beq	$4,$18,$L4
	sb	$4,0($2)

	jal	to_stdout
	nop

	b	$L10
	addiu	$3,$16,1

$L9:
	li	$2,1			# 0x1
	lw	$31,36($sp)
	lw	$19,32($sp)
	lw	$18,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,40

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main

	.comm	s,32,4
	.ident	"GCC: (GNU) 7.4.0"
