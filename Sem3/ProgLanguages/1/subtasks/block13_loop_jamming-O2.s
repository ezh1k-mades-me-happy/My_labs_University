loop_jamming:
.LFB1:
	.cfi_startproc
	endbr64
	movl	$5, i(%rip)
	movl	j5(%rip), %eax
	leal	(%rdi,%rax,4), %eax
	movl	%eax, k5(%rip)
	imull	%edi, %eax
	sall	$2, %eax
	movl	%eax, i5(%rip)
	ret
	.cfi_endproc
main:
.LFB0:
	.cfi_startproc
	endbr64
	movl	$7, %edi
	call	loop_jamming
	movl	i5(%rip), %eax
	ret
	.cfi_endproc