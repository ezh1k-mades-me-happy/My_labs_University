main:
.LFB0:
	.cfi_startproc
	endbr64
	cmpl	$1, i2(%rip)
	jle	.L5
.L2:
	movl	k5(%rip), %eax
	cmpl	i2(%rip), %eax
	movl	%eax, j4(%rip)
	jle	.L3
	cmpl	i4(%rip), %eax
	jle	.L3
	movl	$3, i5(%rip)
.L3:
	xorl	%eax, %eax
	ret
.L5:
	cmpl	$1, i4(%rip)
	jg	.L2
	movl	$2, i2(%rip)
	jmp	.L2
	.cfi_endproc