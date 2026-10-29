main:
.LFB23:
	.cfi_startproc
	endbr64
	movq	.LC0(%rip), %rax
	movl	$3, i3(%rip)
	movl	$0, i5(%rip)
	movq	%rax, flt_1(%rip)
	movl	i(%rip), %eax
	movl	%eax, j2(%rip)
	movl	%eax, k2(%rip)
	movl	%eax, i4(%rip)
	ud2
	.cfi_endproc