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
	movl	-4(%rbp), %eax
	leal	4(%rax), %edi
	movl	-4(%rbp), %eax
	leal	3(%rax), %ecx
	movl	-4(%rbp), %eax
	leal	2(%rax), %edx
	movl	-4(%rbp), %eax
	leal	1(%rax), %esi
	movl	-4(%rbp), %eax
	movl	%edi, %r8d
	movl	%eax, %edi
	call	jump_compression
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
jump_compression:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -12(%rbp)
	movl	%ecx, -16(%rbp)
	movl	%r8d, -20(%rbp)
.L4:
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	.L5
	movl	-8(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	.L6
	movl	-12(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.L7
	movl	-16(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.L12
	movl	-20(%rbp), %eax
	addl	%eax, -16(%rbp)
	jmp	.L9
.L7:
	movl	-16(%rbp), %eax
	addl	%eax, -12(%rbp)
	jmp	.L9
.L6:
	movl	-12(%rbp), %eax
	addl	%eax, -8(%rbp)
	jmp	.L4
.L12:
	nop
.L10:
	jmp	.L4
.L5:
	movl	-8(%rbp), %eax
	addl	%eax, -4(%rbp)
.L9:
	movl	-4(%rbp), %edx
	movl	-8(%rbp), %eax
	addl	%eax, %edx
	movl	-12(%rbp), %eax
	addl	%eax, %edx
	movl	-16(%rbp), %eax
	addl	%eax, %edx
	movl	-20(%rbp), %eax
	addl	%edx, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc