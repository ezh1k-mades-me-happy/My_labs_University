main:
.LFB0:
	.cfi_startproc
	endbr64
	movl	i2(%rip), %eax
	addl	i5(%rip), %eax
	cmpl	$9, i(%rip)
	jg	.L2
	movl	%eax, j5(%rip)
.L3:
	movl	k5(%rip), %eax
	addl	j5(%rip), %eax
	ret
.L2:
	movl	%eax, k5(%rip)
	jmp	.L3
	.cfi_endproc