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
	movl	i(%rip), %eax
	cmpl	$9, %eax
	jg	.L2
	movl	i5(%rip), %edx
	movl	i2(%rip), %eax
	addl	%edx, %eax
	movl	%eax, j5(%rip)
	jmp	.L3
.L2:
	movl	i5(%rip), %edx
	movl	i2(%rip), %eax
	addl	%edx, %eax
	movl	%eax, k5(%rip)
.L3:
	movl	j5(%rip), %edx
	movl	k5(%rip), %eax
	addl	%edx, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc