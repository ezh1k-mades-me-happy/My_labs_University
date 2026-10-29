main:
.LFB0:
	.cfi_startproc
	endbr64
	movl	j5(%rip), %eax
	movq	.LC0(%rip), %rdx
	movl	$655368, 8+ivector4(%rip)
	movl	$6, i(%rip)
	sall	$2, %eax
	movq	%rdx, ivector4(%rip)
	movl	%eax, k2(%rip)
	ret
	.cfi_endproc
