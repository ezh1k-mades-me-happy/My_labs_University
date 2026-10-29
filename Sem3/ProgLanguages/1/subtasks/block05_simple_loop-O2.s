main:
.LFB0:
	.cfi_startproc
	endbr64
	movl	$0, k5(%rip)
	xorl	%eax, %eax
	movl	$10000, j5(%rip)
	movl	$0, i5(%rip)
	ret
	.cfi_endproc