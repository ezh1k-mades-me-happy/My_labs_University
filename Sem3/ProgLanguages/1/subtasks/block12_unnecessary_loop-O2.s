unnecessary_loop:
.LFB1:
	.cfi_startproc
	endbr64
	movl	$5, i(%rip)
	movl	j5(%rip), %eax
	movl	%eax, k5(%rip)
	ret
	.cfi_endproc
main:
.LFB0:
	.cfi_startproc
	endbr64
	call	unnecessary_loop
	movl	k5(%rip), %eax
	ret
	.cfi_endproc