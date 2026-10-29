main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movl	$7, %edi
	call	loop_unrolling
	movzwl	ivector4(%rip), %eax
	cwtl
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
loop_unrolling:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	$0, i(%rip)
	jmp	.L4
.L5:
	movl	i(%rip), %eax
	cltq
	leaq	(%rax,%rax), %rdx
	leaq	ivector4(%rip), %rax
	movw	$0, (%rdx,%rax)
	movl	i(%rip), %eax
	addl	$1, %eax
	movl	%eax, i(%rip)
.L4:
	movl	i(%rip), %eax
	cmpl	$5, %eax
	jle	.L5
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc