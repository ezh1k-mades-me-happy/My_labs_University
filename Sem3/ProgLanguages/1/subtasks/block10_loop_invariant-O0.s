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
	movl	$0, i4(%rip)
	jmp	.L2
.L3:
	movl	j(%rip), %eax
	movl	%eax, %esi
	movl	k(%rip), %eax
	movl	%eax, %edx
	movl	i4(%rip), %ecx
	movl	%esi, %eax
	imull	%edx, %eax
	movl	%eax, %edx
	movslq	%ecx, %rax
	leaq	ivector2(%rip), %rcx
	movb	%dl, (%rax,%rcx)
	movl	i4(%rip), %eax
	addl	$1, %eax
	movl	%eax, i4(%rip)
.L2:
	movl	i4(%rip), %eax
	cmpl	$2, %eax
	jle	.L3
	movzbl	ivector2(%rip), %eax
	movzbl	%al, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc