main:
.LFB23:
	.cfi_startproc
	endbr64
	movl	k3(%rip), %ecx
	addl	h3(%rip), %ecx
	cmpl	$5, %ecx
	ja	.L9
	movl	i3(%rip), %esi
	movl	%ecx, %eax
	cltd
	idivl	%esi
	addl	%esi, %ecx
	movl	%ecx, g3(%rip)
	movl	%eax, m3(%rip)
	addl	%ecx, %eax
	ret
.L9:
	pushq	%rax
	.cfi_def_cfa_offset 16
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	movl	g3(%rip), %ecx
	movl	m3(%rip), %eax
	popq	%rdx
	.cfi_def_cfa_offset 8
	addl	%ecx, %eax
	ret
	.cfi_endproc