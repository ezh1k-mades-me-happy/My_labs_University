main:
.LFB0:
	.cfi_startproc
	endbr64
	movzbl	j(%rip), %eax
	mulb	k(%rip)
	movl	$3, i4(%rip)
	movl	%eax, %edx
	movzbl	%al, %esi
	movzbl	%al, %ecx
	movb	%al, 2+ivector2(%rip)
	sall	$8, %edx
	movl	%ecx, %eax
	addl	%esi, %edx
	movw	%dx, ivector2(%rip)
	ret
	.cfi_endproc