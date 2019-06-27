	.file	1 "fib.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.text
	.align	2
	.globl	fib
	.set	nomips16
	.set	nomicromips
	.ent	fib
	.type	fib, @function
fib:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	li	$2,1			# 0x1
	sw	$2,0($4)
	sw	$2,4($4)
	sltu	$2,$5,3
	bne	$2,$0,$L5
	li	$3,2			# 0x2

	li	$2,2			# 0x2
	li	$8,1073676288			# 0x3fff0000
	ori	$8,$8,0xffff
$L3:
	addu	$2,$2,$8
	sll	$2,$2,2
	addu	$2,$4,$2
	lw	$6,-4($2)
	lw	$7,0($2)
	nop
	addu	$6,$6,$7
	sw	$6,4($2)
	addiu	$3,$3,1
	sll	$3,$3,24
	sra	$3,$3,24
	sltu	$6,$3,$5
	bne	$6,$0,$L3
	move	$2,$3

$L5:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	fib
	.size	fib, .-fib
	.align	2
	.globl	myprint
	.set	nomips16
	.set	nomicromips
	.ent	myprint
	.type	myprint, @function
myprint:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L14
	nop

	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$17,24($sp)
	sw	$16,20($sp)
	move	$16,$4
	sll	$17,$5,2
	addu	$17,$4,$17
$L8:
	lw	$4,0($16)
	jal	print
	addiu	$16,$16,4

	bne	$16,$17,$L8
	nop

	lw	$31,28($sp)
	lw	$17,24($sp)
	lw	$16,20($sp)
	jr	$31
	addiu	$sp,$sp,32

$L14:
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	myprint
	.size	myprint, .-myprint
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$sp,64,$31		# vars= 40, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-64
	sw	$31,60($sp)
	li	$5,10			# 0xa
	jal	fib
	addiu	$4,$sp,16

	li	$5,10			# 0xa
	jal	myprint
	addiu	$4,$sp,16

	li	$2,1			# 0x1
	lw	$31,60($sp)
	nop
	jr	$31
	addiu	$sp,$sp,64

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 7.4.0"
