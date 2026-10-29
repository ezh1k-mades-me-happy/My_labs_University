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
	movl	j5(%rip), %eax
	sall	$2, %eax
	movl	%eax, k2(%rip)
	movl	$0, i(%rip)
	jmp	.L2
.L3:
	movl	i(%rip), %eax
	leal	(%rax,%rax), %edx
	movl	i(%rip), %eax
	movl	%edx, %ecx
	cltq
	leaq	(%rax,%rax), %rdx
	leaq	ivector4(%rip), %rax
	movw	%cx, (%rdx,%rax)
	movl	i(%rip), %eax
	addl	$1, %eax
	movl	%eax, i(%rip)
.L2:
	movl	i(%rip), %eax
	cmpl	$5, %eax
	jle	.L3
	movl	k2(%rip), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc