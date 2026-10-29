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
	movl	$0, j5(%rip)
	movl	$10000, k5(%rip)
.L2:
	movl	k5(%rip), %eax
	subl	$1, %eax
	movl	%eax, k5(%rip)
	movl	j5(%rip), %eax
	addl	$1, %eax
	movl	%eax, j5(%rip)
	movl	k5(%rip), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	leal	(%rax,%rdx), %ecx
	movl	j5(%rip), %edx
	movl	%edx, %eax
	sall	$2, %eax
	leal	(%rdx,%rax), %esi
	movl	%ecx, %eax
	cltd
	idivl	%esi
	movl	%eax, i5(%rip)
	movl	k5(%rip), %eax
	testl	%eax, %eax
	jg	.L2
	movl	i5(%rip), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc