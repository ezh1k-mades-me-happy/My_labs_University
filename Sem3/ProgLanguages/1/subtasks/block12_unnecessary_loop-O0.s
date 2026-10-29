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
	call	unnecessary_loop
	movl	k5(%rip), %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
unnecessary_loop:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$0, -4(%rbp)
	movl	$0, i(%rip)
	jmp	.L4
.L5:
	movl	j5(%rip), %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, k5(%rip)
	movl	i(%rip), %eax
	addl	$1, %eax
	movl	%eax, i(%rip)
.L4:
	movl	i(%rip), %eax
	cmpl	$4, %eax
	jle	.L5
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc