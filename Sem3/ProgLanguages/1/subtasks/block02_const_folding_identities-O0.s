main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movl	$3, i3(%rip)
	movsd	.LC0(%rip), %xmm0
	movsd	%xmm0, flt_1(%rip)
	movl	$5, i2(%rip)
	movl	i(%rip), %eax
	movl	%eax, j2(%rip)
	movl	i(%rip), %eax
	movl	%eax, k2(%rip)
	movl	i(%rip), %eax
	movl	%eax, i4(%rip)
	movl	$0, i5(%rip)
	movl	i(%rip), %eax
	movl	$0, %ecx
	cltd
	idivl	%ecx
	movl	%eax, i2(%rip)
	movsd	flt_1(%rip), %xmm0
	pxor	%xmm1, %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, flt_2(%rip)
	movsd	.LC2(%rip), %xmm0
	movsd	%xmm0, flt_3(%rip)
	movsd	.LC3(%rip), %xmm0
	movsd	%xmm0, flt_4(%rip)
	movsd	flt_6(%rip), %xmm1
	pxor	%xmm0, %xmm0
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, flt_5(%rip)
	movsd	flt_2(%rip), %xmm1
	movsd	flt_3(%rip), %xmm0
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, flt_6(%rip)
	movl	i3(%rip), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc