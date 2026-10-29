main:
.LFB23:
	.cfi_startproc
	endbr64
	movsd	.LC0(%rip), %xmm0
	pxor	%xmm1, %xmm1
	movl	i(%rip), %eax
	xorl	%ecx, %ecx
	movsd	.LC2(%rip), %xmm2
	movl	$3, i3(%rip)
	movsd	%xmm0, flt_1(%rip)
	divsd	%xmm1, %xmm0
	cltd
	movl	%eax, j2(%rip)
	mulsd	flt_6(%rip), %xmm1
	movl	%eax, k2(%rip)
	movl	%eax, i4(%rip)
	idivl	%ecx
	movsd	%xmm2, flt_3(%rip)
	movl	$0, i5(%rip)
	movsd	%xmm1, flt_5(%rip)
	movl	%eax, i2(%rip)
	movq	.LC3(%rip), %rax
	movsd	%xmm0, flt_2(%rip)
	mulsd	%xmm2, %xmm0
	movq	%rax, flt_4(%rip)
	movl	$3, %eax
	movsd	%xmm0, flt_6(%rip)
	ret
	.cfi_endproc