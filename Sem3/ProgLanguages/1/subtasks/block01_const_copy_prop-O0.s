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
	movl	$2, j4(%rip)
	movl	i2(%rip), %edx
	movl	j4(%rip), %eax
	cmpl	%eax, %edx
	jge	.L2
	movl	i4(%rip), %edx
	movl	j4(%rip), %eax
	cmpl	%eax, %edx
	jge	.L2
	movl	$2, i2(%rip)
.L2:
	movl	k5(%rip), %eax
	movl	%eax, j4(%rip)
	movl	i2(%rip), %edx
	movl	j4(%rip), %eax
	cmpl	%eax, %edx
	jge	.L3
	movl	i4(%rip), %edx
	movl	j4(%rip), %eax
	cmpl	%eax, %edx
	jge	.L3
	movl	$3, i5(%rip)
.L3:
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc