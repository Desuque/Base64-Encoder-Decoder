	.file	1 "tp0.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.rdata
	.align	2
$LC0:
	.ascii	"Usage:\n"
	.ascii	" tp0 -h\n"
	.ascii	" tp0 -V\n"
	.ascii	" tp0 [options]\n"
	.ascii	"Options:\n"
	.ascii	" -V, --version\t\tPrint version and quit.\n"
	.ascii	" -h, --help\t\tPrint this information.\n"
	.ascii	" -i, --input\t\tLocation of the input file.\n"
	.ascii	" -o, --output\t\tLocation of the output file.\n"
	.ascii	" -a, --action\t\tProgram action: encode (default) or dec"
	.ascii	"ode.\n"
	.ascii	"Examples:\n"
	.ascii	" tp0 -a encode -i ~/input -o ~/output\n"
	.ascii	" tp0 -a decode\n\000"
	.text
	.align	2
	.globl	help
	.ent	help
help:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	la	$a0,$LC0
	la	$t9,printf
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	help
	.size	help, .-help
	.rdata
	.align	2
$LC1:
	.ascii	"Encoder/Decoder Base64\n"
	.ascii	"66.20 Organizacion de Computadoras FIUBA\n\000"
	.text
	.align	2
	.globl	version
	.ent	version
version:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	la	$a0,$LC1
	la	$t9,printf
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	version
	.size	version, .-version
	.rdata
	.align	2
$LC2:
	.ascii	"\000"
	.space	7
	.text
	.align	2
	.globl	CharToBinary
	.ent	CharToBinary
CharToBinary:
	.frame	$fp,72,$ra		# vars= 32, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,72
	.cprestore 16
	sw	$ra,64($sp)
	sw	$fp,60($sp)
	sw	$gp,56($sp)
	move	$fp,$sp
	move	$v0,$a0
	sw	$a1,76($fp)
	sb	$v0,24($fp)
	lbu	$v0,$LC2
	sb	$v0,32($fp)
	sb	$zero,33($fp)
	sb	$zero,34($fp)
	sb	$zero,35($fp)
	sb	$zero,36($fp)
	sb	$zero,37($fp)
	sb	$zero,38($fp)
	sb	$zero,39($fp)
	sw	$zero,40($fp)
	li	$v0,7			# 0x7
	sw	$v0,44($fp)
$L20:
	lw	$v0,44($fp)
	bgez	$v0,$L23
	b	$L21
$L23:
	addu	$v1,$fp,32
	lw	$v0,40($fp)
	addu	$v1,$v1,$v0
	sw	$v1,48($fp)
	lb	$v1,24($fp)
	lw	$v0,44($fp)
	sra	$v0,$v1,$v0
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L24
	li	$v0,49			# 0x31
	sb	$v0,52($fp)
	b	$L25
$L24:
	li	$v1,48			# 0x30
	sb	$v1,52($fp)
$L25:
	lbu	$v1,52($fp)
	lw	$v0,48($fp)
	sb	$v1,0($v0)
	lw	$v0,40($fp)
	addu	$v0,$v0,1
	sw	$v0,40($fp)
	lw	$v0,44($fp)
	addu	$v0,$v0,-1
	sw	$v0,44($fp)
	b	$L20
$L21:
	addu	$v0,$fp,32
	lw	$a0,76($fp)
	move	$a1,$v0
	la	$t9,strcat
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,64($sp)
	lw	$fp,60($sp)
	addu	$sp,$sp,72
	j	$ra
	.end	CharToBinary
	.size	CharToBinary, .-CharToBinary
	.globl	memcpy
	.rdata
	.align	2
$LC3:
	.ascii	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123"
	.ascii	"456789+/=\000"
	.text
	.align	2
	.globl	encodeBase64
	.ent	encodeBase64
encodeBase64:
	.frame	$fp,120,$ra		# vars= 80, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,120
	.cprestore 16
	sw	$ra,112($sp)
	sw	$fp,108($sp)
	sw	$gp,104($sp)
	move	$fp,$sp
	sw	$a0,120($fp)
	sw	$a1,124($fp)
	sw	$a2,128($fp)
	addu	$v0,$fp,24
	la	$v1,$LC3
	move	$a0,$v0
	move	$a1,$v1
	li	$a2,66			# 0x42
	la	$t9,memcpy
	jal	$ra,$t9
	lw	$v1,120($fp)
	addu	$v0,$fp,24
	addu	$v0,$v0,$v1
	lbu	$v0,0($v0)
	sb	$v0,96($fp)
	lw	$v1,124($fp)
	lw	$v0,128($fp)
	addu	$v1,$v1,$v0
	lbu	$v0,96($fp)
	sb	$v0,0($v1)
	move	$sp,$fp
	lw	$ra,112($sp)
	lw	$fp,108($sp)
	addu	$sp,$sp,120
	j	$ra
	.end	encodeBase64
	.size	encodeBase64, .-encodeBase64
	.rdata
	.align	2
$LC4:
	.ascii	"\n\000"
	.text
	.align	2
	.globl	BinaryToDecimal
	.ent	BinaryToDecimal
BinaryToDecimal:
	.frame	$fp,80,$ra		# vars= 40, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,80
	.cprestore 16
	sw	$ra,72($sp)
	sw	$fp,68($sp)
	sw	$gp,64($sp)
	move	$fp,$sp
	sw	$a0,80($fp)
	sw	$a1,84($fp)
	sw	$a2,88($fp)
	li	$v0,6			# 0x6
	sw	$v0,24($fp)
	lw	$a0,80($fp)
	la	$t9,strlen
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$a0,80($fp)
	la	$t9,strlen
	jal	$ra,$t9
	move	$v1,$v0
	lw	$v0,24($fp)
	divu	$0,$v1,$v0
	mflo	$v1
	.set	noreorder
	bne	$v0,$0,1f
	nop
	break	7
1:
	.set	reorder
	sw	$v1,32($fp)
	li	$v0,48			# 0x30
	sw	$v0,36($fp)
	sw	$zero,44($fp)
	sw	$zero,48($fp)
$L28:
	lw	$v0,48($fp)
	lw	$v1,32($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L31
	b	$L29
$L31:
	sw	$zero,40($fp)
	sw	$zero,52($fp)
$L32:
	lw	$v0,52($fp)
	lw	$v1,24($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,$L35
	b	$L33
$L35:
	lw	$v1,48($fp)
	lw	$v0,24($fp)
	mult	$v1,$v0
	mflo	$v1
	lw	$v0,52($fp)
	addu	$v1,$v1,$v0
	lw	$v0,80($fp)
	addu	$v0,$v1,$v0
	lb	$v1,0($v0)
	lw	$v0,36($fp)
	subu	$v0,$v1,$v0
	sw	$v0,56($fp)
	lw	$v0,40($fp)
	sll	$v1,$v0,1
	lw	$v0,56($fp)
	or	$v0,$v1,$v0
	sw	$v0,40($fp)
	lw	$v0,52($fp)
	addu	$v0,$v0,1
	sw	$v0,52($fp)
	b	$L32
$L33:
	lw	$a0,40($fp)
	lw	$a1,84($fp)
	lw	$a2,44($fp)
	la	$t9,encodeBase64
	jal	$ra,$t9
	lw	$v0,44($fp)
	addu	$v0,$v0,1
	sw	$v0,44($fp)
	lw	$v0,48($fp)
	addu	$v0,$v0,1
	sw	$v0,48($fp)
	b	$L28
$L29:
	lw	$v1,28($fp)
	lw	$v0,24($fp)
	div	$0,$v1,$v0
	mfhi	$v1
	.set	noreorder
	bne	$v0,$0,1f
	nop
	break	7
1:
	.set	reorder
	sw	$v1,56($fp)
	lw	$v0,56($fp)
	beq	$v0,$zero,$L36
	sw	$zero,40($fp)
	lw	$v0,28($fp)
	lw	$v1,56($fp)
	subu	$v0,$v0,$v1
	sw	$v0,52($fp)
$L37:
	lw	$v0,52($fp)
	lw	$v1,28($fp)
	sltu	$v0,$v0,$v1
	bne	$v0,$zero,$L40
	b	$L38
$L40:
	lw	$v1,80($fp)
	lw	$v0,52($fp)
	addu	$v0,$v1,$v0
	lb	$v1,0($v0)
	lw	$v0,36($fp)
	subu	$v0,$v1,$v0
	sw	$v0,48($fp)
	lw	$v0,40($fp)
	sll	$v1,$v0,1
	lw	$v0,48($fp)
	or	$v0,$v1,$v0
	sw	$v0,40($fp)
	lw	$v0,52($fp)
	addu	$v0,$v0,1
	sw	$v0,52($fp)
	b	$L37
$L38:
	lw	$v1,88($fp)
	lw	$v0,32($fp)
	subu	$v0,$v1,$v0
	addu	$v0,$v0,-1
	sw	$v0,52($fp)
	sw	$zero,48($fp)
$L41:
	lw	$v1,24($fp)
	lw	$v0,56($fp)
	subu	$v1,$v1,$v0
	lw	$v0,48($fp)
	sltu	$v0,$v0,$v1
	bne	$v0,$zero,$L44
	b	$L42
$L44:
	lw	$v0,40($fp)
	sll	$v0,$v0,1
	sw	$v0,40($fp)
	lw	$v0,48($fp)
	addu	$v0,$v0,1
	sw	$v0,48($fp)
	b	$L41
$L42:
	lw	$v0,40($fp)
	bne	$v0,$zero,$L45
	li	$v0,64			# 0x40
	sw	$v0,40($fp)
$L45:
	lw	$a0,40($fp)
	lw	$a1,84($fp)
	lw	$a2,44($fp)
	la	$t9,encodeBase64
	jal	$ra,$t9
	lw	$v0,44($fp)
	addu	$v0,$v0,1
	sw	$v0,44($fp)
	li	$v0,64			# 0x40
	sw	$v0,40($fp)
	sw	$zero,48($fp)
$L46:
	lw	$v0,48($fp)
	lw	$v1,52($fp)
	sltu	$v0,$v0,$v1
	bne	$v0,$zero,$L49
	b	$L36
$L49:
	lw	$a0,40($fp)
	lw	$a1,84($fp)
	lw	$a2,44($fp)
	la	$t9,encodeBase64
	jal	$ra,$t9
	lw	$v0,44($fp)
	addu	$v0,$v0,1
	sw	$v0,44($fp)
	lw	$v0,48($fp)
	addu	$v0,$v0,1
	sw	$v0,48($fp)
	b	$L46
$L36:
	la	$a0,$LC4
	la	$t9,printf
	jal	$ra,$t9
	move	$v0,$zero
	move	$sp,$fp
	lw	$ra,72($sp)
	lw	$fp,68($sp)
	addu	$sp,$sp,80
	j	$ra
	.end	BinaryToDecimal
	.size	BinaryToDecimal, .-BinaryToDecimal
	.rdata
	.align	2
$LC5:
	.ascii	"rb\000"
	.align	2
$LC6:
	.ascii	"El archivo no existe o no puede ser abierto.\n\000"
	.text
	.align	2
	.globl	fileOpen
	.ent	fileOpen
fileOpen:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	lw	$a0,48($fp)
	la	$a1,$LC5
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	bne	$v0,$zero,$L51
	la	$a0,$LC6
	la	$a1,__sF+176
	la	$t9,fputs
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L51:
	lw	$v0,24($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	fileOpen
	.size	fileOpen, .-fileOpen
	.align	2
	.globl	fileClose
	.ent	fileClose
fileClose:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,40($fp)
	lw	$a0,40($fp)
	la	$t9,fclose
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	fileClose
	.size	fileClose, .-fileClose
	.align	2
	.globl	fileGetSize
	.ent	fileGetSize
fileGetSize:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	lw	$a0,48($fp)
	la	$t9,fileOpen
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$a0,24($fp)
	move	$a1,$zero
	li	$a2,2			# 0x2
	la	$t9,fseek
	jal	$ra,$t9
	lw	$a0,24($fp)
	la	$t9,ftell
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$a0,24($fp)
	move	$a1,$zero
	move	$a2,$zero
	la	$t9,fseek
	jal	$ra,$t9
	lw	$a0,24($fp)
	la	$t9,fileClose
	jal	$ra,$t9
	lw	$v0,28($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	fileGetSize
	.size	fileGetSize, .-fileGetSize
	.align	2
	.globl	fileRead
	.ent	fileRead
fileRead:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	sw	$zero,28($fp)
$L55:
	lw	$a0,48($fp)
	la	$t9,fgetc
	jal	$ra,$t9
	sb	$v0,24($fp)
	lbu	$v0,24($fp)
	sll	$v0,$v0,24
	sra	$v1,$v0,24
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L57
	b	$L54
$L57:
	lw	$v1,52($fp)
	lw	$v0,28($fp)
	addu	$v1,$v1,$v0
	lbu	$v0,24($fp)
	sb	$v0,0($v1)
	lw	$v0,28($fp)
	addu	$v0,$v0,1
	sw	$v0,28($fp)
	b	$L55
$L54:
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	fileRead
	.size	fileRead, .-fileRead
	.align	2
	.globl	fileProcessing
	.ent	fileProcessing
fileProcessing:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	lw	$a0,48($fp)
	la	$t9,fileOpen
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	beq	$v0,$zero,$L58
	lw	$a0,24($fp)
	lw	$a1,52($fp)
	la	$t9,fileRead
	jal	$ra,$t9
	lw	$a0,24($fp)
	la	$t9,fileClose
	jal	$ra,$t9
$L58:
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	fileProcessing
	.size	fileProcessing, .-fileProcessing
	.rdata
	.align	2
$LC7:
	.ascii	"\000"
	.text
	.align	2
	.globl	bufferOpen
	.ent	bufferOpen
bufferOpen:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	lw	$a0,48($fp)
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	beq	$v0,$zero,$L61
	lw	$a0,24($fp)
	la	$a1,$LC7
	la	$t9,strcpy
	jal	$ra,$t9
$L61:
	lw	$v0,24($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	bufferOpen
	.size	bufferOpen, .-bufferOpen
	.align	2
	.globl	bufferClose
	.ent	bufferClose
bufferClose:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,40($fp)
	lw	$v0,40($fp)
	beq	$v0,$zero,$L62
	lw	$a0,40($fp)
	la	$t9,free
	jal	$ra,$t9
$L62:
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	bufferClose
	.size	bufferClose, .-bufferClose
	.align	2
	.globl	PosicionToBinary
	.ent	PosicionToBinary
PosicionToBinary:
	.frame	$fp,64,$ra		# vars= 24, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,64
	.cprestore 16
	sw	$ra,56($sp)
	sw	$fp,52($sp)
	sw	$gp,48($sp)
	move	$fp,$sp
	sw	$a0,64($fp)
	sw	$a1,68($fp)
	lbu	$v0,$LC2
	sb	$v0,24($fp)
	sb	$zero,25($fp)
	sb	$zero,26($fp)
	sb	$zero,27($fp)
	sb	$zero,28($fp)
	sb	$zero,29($fp)
	sb	$zero,30($fp)
	sb	$zero,31($fp)
	sw	$zero,32($fp)
	li	$v0,7			# 0x7
	sw	$v0,36($fp)
$L65:
	lw	$v0,36($fp)
	bgez	$v0,$L68
	b	$L66
$L68:
	lw	$v0,32($fp)
	beq	$v0,$zero,$L69
	lw	$v1,32($fp)
	li	$v0,1			# 0x1
	beq	$v1,$v0,$L69
	lw	$v1,32($fp)
	addu	$v0,$fp,24
	addu	$v0,$v0,$v1
	addu	$v0,$v0,-2
	sw	$v0,40($fp)
	lw	$v1,64($fp)
	lw	$v0,36($fp)
	sra	$v0,$v1,$v0
	andi	$v0,$v0,0x1
	beq	$v0,$zero,$L70
	li	$v0,49			# 0x31
	sb	$v0,44($fp)
	b	$L71
$L70:
	li	$v1,48			# 0x30
	sb	$v1,44($fp)
$L71:
	lbu	$v1,44($fp)
	lw	$v0,40($fp)
	sb	$v1,0($v0)
$L69:
	lw	$v0,32($fp)
	addu	$v0,$v0,1
	sw	$v0,32($fp)
	lw	$v0,36($fp)
	addu	$v0,$v0,-1
	sw	$v0,36($fp)
	b	$L65
$L66:
	lw	$a0,68($fp)
	addu	$a1,$fp,24
	la	$t9,strcat
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,56($sp)
	lw	$fp,52($sp)
	addu	$sp,$sp,64
	j	$ra
	.end	PosicionToBinary
	.size	PosicionToBinary, .-PosicionToBinary
	.globl	memcpy
	.align	2
	.globl	decodeBase64
	.ent	decodeBase64
decodeBase64:
	.frame	$fp,128,$ra		# vars= 88, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,128
	.cprestore 16
	sw	$ra,120($sp)
	sw	$fp,116($sp)
	sw	$gp,112($sp)
	move	$fp,$sp
	move	$v0,$a0
	sb	$v0,24($fp)
	addu	$v0,$fp,32
	la	$v1,$LC3
	move	$a0,$v0
	move	$a1,$v1
	li	$a2,66			# 0x42
	la	$t9,memcpy
	jal	$ra,$t9
	sw	$zero,104($fp)
	addu	$v0,$fp,32
	move	$a0,$v0
	la	$t9,strlen
	jal	$ra,$t9
	move	$v1,$v0
	lw	$v0,104($fp)
	sltu	$v0,$v0,$v1
	bne	$v0,$zero,$L76
	b	$L74
$L76:
	addu	$v1,$fp,32
	lw	$v0,104($fp)
	addu	$v0,$v1,$v0
	lb	$v1,24($fp)
	lb	$v0,0($v0)
	bne	$v1,$v0,$L77
	lw	$v0,104($fp)
	sw	$v0,108($fp)
	b	$L72
$L77:
	li	$v0,1			# 0x1
	sw	$v0,108($fp)
	b	$L72
$L74:
	sw	$zero,108($fp)
$L72:
	lw	$v0,108($fp)
	move	$sp,$fp
	lw	$ra,120($sp)
	lw	$fp,116($sp)
	addu	$sp,$sp,128
	j	$ra
	.end	decodeBase64
	.size	decodeBase64, .-decodeBase64
	.rdata
	.align	2
$LC9:
	.ascii	"Cadena base 64: %s\000"
	.text
	.align	2
	.globl	decode
	.ent	decode
decode:
	.frame	$fp,80,$ra		# vars= 40, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,80
	.cprestore 16
	sw	$ra,72($sp)
	sw	$fp,68($sp)
	sw	$gp,64($sp)
	move	$fp,$sp
	sw	$a0,80($fp)
	sw	$a1,84($fp)
	sw	$zero,24($fp)
	lw	$a0,80($fp)
	la	$t9,strlen
	jal	$ra,$t9
	move	$v1,$v0
	move	$v0,$v1
	sll	$v0,$v0,1
	addu	$v0,$v0,$v1
	sll	$v0,$v0,1
	addu	$v0,$v0,-5
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,24($fp)
	la	$a0,$LC9
	lw	$a1,80($fp)
	la	$t9,printf
	jal	$ra,$t9
	sw	$zero,28($fp)
$L79:
	lw	$a0,80($fp)
	la	$t9,strlen
	jal	$ra,$t9
	addu	$v1,$v0,-1
	lw	$v0,28($fp)
	sltu	$v0,$v0,$v1
	bne	$v0,$zero,$L82
	b	$L80
$L82:
	lbu	$v0,$LC2
	sb	$v0,32($fp)
	sb	$zero,33($fp)
	sb	$zero,34($fp)
	sb	$zero,35($fp)
	sb	$zero,36($fp)
	sb	$zero,37($fp)
	lw	$v1,80($fp)
	lw	$v0,28($fp)
	addu	$v0,$v1,$v0
	lb	$v0,0($v0)
	move	$a0,$v0
	la	$t9,decodeBase64
	jal	$ra,$t9
	addu	$v1,$fp,32
	move	$a0,$v0
	move	$a1,$v1
	la	$t9,PosicionToBinary
	jal	$ra,$t9
	addu	$v0,$fp,32
	lw	$a0,24($fp)
	move	$a1,$v0
	la	$t9,strcat
	jal	$ra,$t9
	lw	$v0,28($fp)
	addu	$v0,$v0,1
	sw	$v0,28($fp)
	b	$L79
$L80:
	lbu	$v0,$LC2
	sb	$v0,40($fp)
	sb	$zero,41($fp)
	sb	$zero,42($fp)
	sb	$zero,43($fp)
	sb	$zero,44($fp)
	sb	$zero,45($fp)
	sb	$zero,46($fp)
	sb	$zero,47($fp)
	sw	$zero,28($fp)
	sw	$zero,48($fp)
$L83:
	lw	$a0,24($fp)
	la	$t9,strlen
	jal	$ra,$t9
	lw	$v1,28($fp)
	sltu	$v0,$v1,$v0
	bne	$v0,$zero,$L85
	b	$L84
$L85:
	sw	$zero,52($fp)
$L86:
	lw	$v0,52($fp)
	sltu	$v0,$v0,8
	bne	$v0,$zero,$L89
	b	$L87
$L89:
	addu	$v1,$fp,40
	lw	$v0,52($fp)
	addu	$a0,$v1,$v0
	lw	$v1,24($fp)
	lw	$v0,28($fp)
	addu	$v0,$v1,$v0
	lbu	$v0,0($v0)
	sb	$v0,0($a0)
	lw	$v0,28($fp)
	addu	$v0,$v0,1
	sw	$v0,28($fp)
	lw	$v0,52($fp)
	addu	$v0,$v0,1
	sw	$v0,52($fp)
	b	$L86
$L87:
	addu	$v0,$fp,40
	move	$a0,$v0
	move	$a1,$zero
	li	$a2,2			# 0x2
	la	$t9,strtol
	jal	$ra,$t9
	sb	$v0,56($fp)
	lb	$v0,56($fp)
	beq	$v0,$zero,$L83
	lw	$v1,84($fp)
	lw	$v0,48($fp)
	addu	$v1,$v1,$v0
	lbu	$v0,56($fp)
	sb	$v0,0($v1)
	lw	$v0,48($fp)
	addu	$v0,$v0,1
	sw	$v0,48($fp)
	b	$L83
$L84:
	lw	$a0,84($fp)
	la	$t9,strlen
	jal	$ra,$t9
	lw	$v1,84($fp)
	addu	$v0,$v0,$v1
	sb	$zero,0($v0)
	move	$sp,$fp
	lw	$ra,72($sp)
	lw	$fp,68($sp)
	addu	$sp,$sp,80
	j	$ra
	.end	decode
	.size	decode, .-decode
	.rdata
	.align	2
$LC10:
	.ascii	"w+\000"
	.align	2
$LC11:
	.ascii	"Error abriendo el archivo.\000"
	.text
	.align	2
	.globl	grabarArchivo
	.ent	grabarArchivo
grabarArchivo:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	lw	$a0,48($fp)
	la	$a1,$LC10
	la	$t9,fopen
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	bne	$v0,$zero,$L92
	la	$a0,$LC11
	la	$a1,__sF+176
	la	$t9,fputs
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
$L92:
	lw	$a0,52($fp)
	lw	$a1,24($fp)
	la	$t9,fputs
	jal	$ra,$t9
	lw	$a0,24($fp)
	la	$t9,fclose
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	grabarArchivo
	.size	grabarArchivo, .-grabarArchivo
	.align	2
	.globl	leerArchivo
	.ent	leerArchivo
leerArchivo:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	lw	$a0,48($fp)
	la	$t9,fileGetSize
	jal	$ra,$t9
	sw	$v0,24($fp)
	lw	$v0,24($fp)
	bne	$v0,$zero,$L94
	move	$a0,$zero
	la	$t9,exit
	jal	$ra,$t9
$L94:
	lw	$a0,24($fp)
	la	$t9,bufferOpen
	jal	$ra,$t9
	move	$v1,$v0
	lw	$v0,52($fp)
	sw	$v1,0($v0)
	lw	$v0,24($fp)
	sll	$v1,$v0,2
	lw	$v0,52($fp)
	addu	$v0,$v1,$v0
	sw	$zero,0($v0)
	lw	$v0,52($fp)
	lw	$a0,48($fp)
	lw	$a1,0($v0)
	la	$t9,fileProcessing
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	leerArchivo
	.size	leerArchivo, .-leerArchivo
	.align	2
	.globl	activeParameter
	.ent	activeParameter
activeParameter:
	.frame	$fp,48,$ra		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$ra,40($sp)
	sw	$fp,36($sp)
	sw	$gp,32($sp)
	move	$fp,$sp
	sw	$a0,48($fp)
	sw	$a1,52($fp)
	sw	$a2,56($fp)
	sw	$a3,60($fp)
	sw	$zero,24($fp)
$L96:
	lw	$v0,24($fp)
	lw	$v1,48($fp)
	sltu	$v0,$v0,$v1
	bne	$v0,$zero,$L99
	b	$L97
$L99:
	lw	$v0,24($fp)
	sll	$v1,$v0,2
	lw	$v0,52($fp)
	addu	$v0,$v1,$v0
	lw	$a0,0($v0)
	lw	$a1,56($fp)
	la	$t9,strcmp
	jal	$ra,$t9
	beq	$v0,$zero,$L101
	lw	$v0,24($fp)
	sll	$v1,$v0,2
	lw	$v0,52($fp)
	addu	$v0,$v1,$v0
	lw	$a0,0($v0)
	lw	$a1,60($fp)
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L98
$L101:
	li	$v0,1			# 0x1
	sw	$v0,28($fp)
	b	$L95
$L98:
	lw	$v0,24($fp)
	addu	$v0,$v0,1
	sw	$v0,24($fp)
	b	$L96
$L97:
	sw	$zero,28($fp)
$L95:
	lw	$v0,28($fp)
	move	$sp,$fp
	lw	$ra,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$ra
	.end	activeParameter
	.size	activeParameter, .-activeParameter
	.align	2
	.globl	readSTDIN
	.ent	readSTDIN
readSTDIN:
	.frame	$fp,40,$ra		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,32($sp)
	sw	$fp,28($sp)
	sw	$gp,24($sp)
	move	$fp,$sp
	sw	$a0,40($fp)
	sw	$a1,44($fp)
	move	$a0,$zero
	lw	$a1,40($fp)
	lw	$a2,44($fp)
	la	$t9,read
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	readSTDIN
	.size	readSTDIN, .-readSTDIN
	.align	2
	.globl	charCopy
	.ent	charCopy
charCopy:
	.frame	$fp,40,$ra		# vars= 0, regs= 4/0, args= 16, extra= 8
	.mask	0xd0010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$ra,36($sp)
	sw	$fp,32($sp)
	sw	$gp,28($sp)
	sw	$s0,24($sp)
	move	$fp,$sp
	sw	$a0,40($fp)
	sw	$a1,44($fp)
	lw	$s0,40($fp)
	lw	$a0,44($fp)
	la	$t9,strlen
	jal	$ra,$t9
	addu	$v0,$v0,1
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,0($s0)
	lw	$s0,40($fp)
	lw	$a0,44($fp)
	la	$t9,strlen
	jal	$ra,$t9
	move	$v1,$v0
	lw	$v0,0($s0)
	addu	$v0,$v1,$v0
	sb	$zero,0($v0)
	lw	$v0,40($fp)
	lw	$a0,0($v0)
	lw	$a1,44($fp)
	la	$t9,strcat
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,36($sp)
	lw	$fp,32($sp)
	lw	$s0,24($sp)
	addu	$sp,$sp,40
	j	$ra
	.end	charCopy
	.size	charCopy, .-charCopy
	.align	2
	.globl	calculateLen
	.ent	calculateLen
calculateLen:
	.frame	$fp,56,$ra		# vars= 16, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$ra,48($sp)
	sw	$fp,44($sp)
	sw	$gp,40($sp)
	move	$fp,$sp
	sw	$a0,56($fp)
	lw	$a0,56($fp)
	la	$t9,strlen
	jal	$ra,$t9
	sll	$v0,$v0,3
	addu	$v0,$v0,-8
	sw	$v0,24($fp)
	lw	$a0,24($fp)
	li	$v0,715784192			# 0x2aaa0000
	ori	$v0,$v0,0xaaab
	mult	$a0,$v0
	mfhi	$v1
	sra	$v0,$a0,31
	subu	$v0,$v1,$v0
	sw	$v0,28($fp)
	lw	$v0,28($fp)
	andi	$v0,$v0,0x3
	beq	$v0,$zero,$L105
	lw	$v0,28($fp)
	addu	$v0,$v0,4
	sw	$v0,28($fp)
	lw	$v0,28($fp)
	sw	$v0,32($fp)
	lw	$v0,32($fp)
	bgez	$v0,$L106
	lw	$v1,32($fp)
	addu	$v1,$v1,3
	sw	$v1,32($fp)
$L106:
	lw	$v1,32($fp)
	sra	$v0,$v1,2
	sw	$v0,28($fp)
	lw	$v0,28($fp)
	sll	$v0,$v0,2
	sw	$v0,28($fp)
$L105:
	lw	$v0,28($fp)
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	calculateLen
	.size	calculateLen, .-calculateLen
	.align	2
	.globl	encode
	.ent	encode
encode:
	.frame	$fp,56,$ra		# vars= 16, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$ra,48($sp)
	sw	$fp,44($sp)
	sw	$gp,40($sp)
	move	$fp,$sp
	sw	$a0,56($fp)
	sw	$a1,60($fp)
	lw	$a0,56($fp)
	la	$t9,strlen
	jal	$ra,$t9
	sll	$v0,$v0,3
	addu	$v0,$v0,-8
	sw	$v0,24($fp)
	lw	$a0,24($fp)
	la	$t9,bufferOpen
	jal	$ra,$t9
	sw	$v0,28($fp)
	sw	$zero,32($fp)
$L108:
	lw	$a0,56($fp)
	la	$t9,strlen
	jal	$ra,$t9
	addu	$v1,$v0,-1
	lw	$v0,32($fp)
	sltu	$v0,$v0,$v1
	bne	$v0,$zero,$L111
	b	$L109
$L111:
	lw	$v1,56($fp)
	lw	$v0,32($fp)
	addu	$v0,$v1,$v0
	lb	$v0,0($v0)
	move	$a0,$v0
	lw	$a1,28($fp)
	la	$t9,CharToBinary
	jal	$ra,$t9
	lw	$v0,32($fp)
	addu	$v0,$v0,1
	sw	$v0,32($fp)
	b	$L108
$L109:
	lw	$a0,56($fp)
	la	$t9,calculateLen
	jal	$ra,$t9
	lw	$a0,28($fp)
	lw	$a1,60($fp)
	move	$a2,$v0
	la	$t9,BinaryToDecimal
	jal	$ra,$t9
	move	$sp,$fp
	lw	$ra,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$ra
	.end	encode
	.size	encode, .-encode
	.rdata
	.align	2
$LC12:
	.ascii	"version\000"
	.align	2
$LC13:
	.ascii	"help\000"
	.align	2
$LC14:
	.ascii	"input\000"
	.align	2
$LC15:
	.ascii	"output\000"
	.align	2
$LC16:
	.ascii	"action\000"
	.data
	.align	2
	.type	long_options.0, @object
	.size	long_options.0, 96
long_options.0:
	.word	$LC12
	.word	0
	.word	0
	.word	86
	.word	$LC13
	.word	0
	.word	0
	.word	104
	.word	$LC14
	.word	1
	.word	0
	.word	105
	.word	$LC15
	.word	1
	.word	0
	.word	111
	.word	$LC16
	.word	2
	.word	0
	.word	97
	.word	0
	.word	0
	.word	0
	.word	0
	.rdata
	.align	2
$LC17:
	.ascii	"Vhi:o:a:\000"
	.align	2
$LC18:
	.ascii	"decode\000"
	.align	2
$LC19:
	.ascii	"Ouput:%s\n\000"
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,80,$ra		# vars= 32, regs= 3/0, args= 24, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$t9
	.set	reorder
	subu	$sp,$sp,80
	.cprestore 24
	sw	$ra,72($sp)
	sw	$fp,68($sp)
	sw	$gp,64($sp)
	move	$fp,$sp
	sw	$a0,80($fp)
	sw	$a1,84($fp)
	sw	$zero,32($fp)
	li	$v0,1			# 0x1
	sb	$v0,36($fp)
	li	$v0,1			# 0x1
	sb	$v0,37($fp)
	li	$v0,1			# 0x1
	sb	$v0,38($fp)
	sw	$zero,40($fp)
	sw	$zero,44($fp)
	sw	$zero,48($fp)
$L113:
	sw	$zero,56($fp)
	addu	$v0,$fp,56
	sw	$v0,16($sp)
	lw	$a0,80($fp)
	lw	$a1,84($fp)
	la	$a2,$LC17
	la	$a3,long_options.0
	la	$t9,getopt_long
	jal	$ra,$t9
	sw	$v0,52($fp)
	lw	$v1,52($fp)
	li	$v0,-1			# 0xffffffffffffffff
	bne	$v1,$v0,$L116
	b	$L114
$L116:
	lw	$v0,52($fp)
	addu	$v0,$v0,-63
	sw	$v0,60($fp)
	lw	$v1,60($fp)
	sltu	$v0,$v1,49
	beq	$v0,$zero,$L125
	lw	$v0,60($fp)
	sll	$v1,$v0,2
	la	$v0,$L126
	addu	$v0,$v1,$v0
	lw	$v0,0($v0)
	.cpadd	$v0
	j	$v0
	.rdata
	.align	2
$L126:
	.gpword	$L113
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L118
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L122
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L119
	.gpword	$L120
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L125
	.gpword	$L121
	.text
$L118:
	la	$t9,version
	jal	$ra,$t9
	b	$L113
$L119:
	la	$t9,help
	jal	$ra,$t9
	b	$L113
$L120:
	sb	$zero,37($fp)
	addu	$v0,$fp,48
	move	$a0,$v0
	lw	$a1,optarg
	la	$t9,charCopy
	jal	$ra,$t9
	b	$L113
$L121:
	sb	$zero,38($fp)
	addu	$v0,$fp,44
	move	$a0,$v0
	lw	$a1,optarg
	la	$t9,charCopy
	jal	$ra,$t9
	b	$L113
$L122:
	lw	$a0,optarg
	la	$a1,$LC18
	la	$t9,strcmp
	jal	$ra,$t9
	bne	$v0,$zero,$L113
	sb	$zero,36($fp)
	b	$L113
$L125:
	la	$t9,abort
	jal	$ra,$t9
$L114:
	lbu	$v0,37($fp)
	beq	$v0,$zero,$L127
	li	$a0,400			# 0x190
	la	$t9,bufferOpen
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$a0,32($fp)
	li	$a1,400			# 0x190
	la	$t9,readSTDIN
	jal	$ra,$t9
	b	$L128
$L127:
	lw	$a0,48($fp)
	addu	$a1,$fp,32
	la	$t9,leerArchivo
	jal	$ra,$t9
$L128:
	lbu	$v0,36($fp)
	beq	$v0,$zero,$L129
	lw	$a0,32($fp)
	la	$t9,calculateLen
	jal	$ra,$t9
	sw	$v0,56($fp)
	lw	$v0,56($fp)
	addu	$v0,$v0,1
	move	$a0,$v0
	la	$t9,bufferOpen
	jal	$ra,$t9
	sw	$v0,40($fp)
	lw	$a0,40($fp)
	la	$t9,strlen
	jal	$ra,$t9
	lw	$a0,40($fp)
	move	$a1,$zero
	move	$a2,$v0
	la	$t9,memset
	jal	$ra,$t9
	lw	$a0,32($fp)
	lw	$a1,40($fp)
	la	$t9,encode
	jal	$ra,$t9
	b	$L130
$L129:
	lw	$a0,32($fp)
	la	$t9,strlen
	jal	$ra,$t9
	move	$v1,$v0
	move	$v0,$v1
	sll	$v0,$v0,1
	addu	$v0,$v0,$v1
	sll	$v0,$v0,1
	srl	$v0,$v0,3
	addu	$v0,$v0,1
	move	$a0,$v0
	la	$t9,bufferOpen
	jal	$ra,$t9
	sw	$v0,40($fp)
	lw	$a0,40($fp)
	la	$t9,strlen
	jal	$ra,$t9
	addu	$v0,$v0,1
	lw	$a0,40($fp)
	move	$a1,$zero
	move	$a2,$v0
	la	$t9,memset
	jal	$ra,$t9
	lw	$a0,32($fp)
	lw	$a1,40($fp)
	la	$t9,decode
	jal	$ra,$t9
$L130:
	lbu	$v0,38($fp)
	beq	$v0,$zero,$L131
	lw	$a0,40($fp)
	la	$a1,__sF+88
	la	$t9,fputs
	jal	$ra,$t9
	la	$a0,$LC4
	la	$t9,printf
	jal	$ra,$t9
	b	$L132
$L131:
	la	$a0,$LC19
	lw	$a1,44($fp)
	la	$t9,printf
	jal	$ra,$t9
	lw	$a0,44($fp)
	lw	$a1,40($fp)
	la	$t9,grabarArchivo
	jal	$ra,$t9
$L132:
	lw	$a0,32($fp)
	la	$t9,bufferClose
	jal	$ra,$t9
	lw	$a0,44($fp)
	la	$t9,bufferClose
	jal	$ra,$t9
	lw	$a0,48($fp)
	la	$t9,bufferClose
	jal	$ra,$t9
	lw	$a0,40($fp)
	la	$t9,bufferClose
	jal	$ra,$t9
	move	$v0,$zero
	move	$sp,$fp
	lw	$ra,72($sp)
	lw	$fp,68($sp)
	addu	$sp,$sp,80
	j	$ra
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
