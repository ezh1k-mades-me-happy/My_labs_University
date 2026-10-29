main:
.LFB0:
	.cfi_startproc
	endbr64
	movslq	i2(%rip), %rdx
	leaq	ivector(%rip), %rax
	movl	$1, ivector(%rip)
	movl	$2, (%rax,%rdx,4)
	movl	ivector(%rip), %eax
	movl	$3, 8+ivector(%rip)
	ret
	.cfi_endproc