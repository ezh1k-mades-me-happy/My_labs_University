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
	movl	h3(%rip), %edx
	movl	k3(%rip), %eax
	addl	%edx, %eax
	testl	%eax, %eax
	js	.L2
	movl	h3(%rip), %edx
	movl	k3(%rip), %eax
	addl	%edx, %eax
	cmpl	$5, %eax
	jle	.L3
.L2:
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L4
.L3:
	movl	h3(%rip), %edx
	movl	k3(%rip), %eax
	addl	%edx, %eax
	movl	i3(%rip), %ecx
	cltd
	idivl	%ecx
	movl	%eax, m3(%rip)
	movl	h3(%rip), %edx
	movl	k3(%rip), %eax
	addl	%eax, %edx
	movl	i3(%rip), %eax
	addl	%edx, %eax
	movl	%eax, g3(%rip)
.L4:
	movl	g3(%rip), %edx
	movl	m3(%rip), %eax
	addl	%edx, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc