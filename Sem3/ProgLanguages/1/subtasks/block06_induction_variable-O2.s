main:
.LFB0:
	.cfi_startproc
	endbr64
	leaq	12+ivector5(%rip), %rax
	leaq	800(%rax), %rdx
.L2:
	movl	$5, (%rax)
	addq	$16, %rax
	movl	$5, -8(%rax)
	cmpq	%rdx, %rax
	jne	.L2
	movl	$100, i(%rip)
	movl	12+ivector5(%rip), %eax
	ret
	.cfi_endproc