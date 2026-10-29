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
	movl	$0, i(%rip)
	jmp	.L2
.L3:
	movl	i(%rip), %eax
	addl	%eax, %eax
	addl	$3, %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	ivector5(%rip), %rax
	movl	$5, (%rdx,%rax)
	movl	i(%rip), %eax
	addl	$1, %eax
	movl	%eax, i(%rip)
.L2:
	movl	i(%rip), %eax
	cmpl	$99, %eax
	jle	.L3
	movl	12+ivector5(%rip), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc