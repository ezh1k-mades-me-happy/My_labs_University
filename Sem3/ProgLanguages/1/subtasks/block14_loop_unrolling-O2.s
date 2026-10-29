main:
.LFB0:
	.cfi_startproc
	endbr64
	movq	$0, ivector4(%rip)
	xorl	%eax, %eax
	movl	$0, 8+ivector4(%rip)
	movl	$6, i(%rip)
	ret
	.cfi_endproc
loop_unrolling:
.LFB1:
	.cfi_startproc
	endbr64
	movq	$0, ivector4(%rip)
	movl	$0, 8+ivector4(%rip)
	movl	$6, i(%rip)
	ret
	.cfi_endproc