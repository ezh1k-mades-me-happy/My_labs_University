jump_compression:
.LFB1:
	.cfi_startproc
	endbr64
	.p2align 4,,10
	.p2align 3
.L6:
	cmpl	%edi, %esi
	jle	.L3
	cmpl	%esi, %edx
	jle	.L4
	cmpl	%ecx, %edx
	jge	.L5
	cmpl	%r8d, %ecx
	jge	.L6
	addl	%r8d, %ecx
.L7:
	leal	(%rdi,%rsi), %eax
	addl	%edx, %eax
	addl	%ecx, %eax
	addl	%r8d, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L4:
	addl	%edx, %esi
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L3:
	addl	%esi, %edi
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L5:
	addl	%ecx, %edx
	jmp	.L7
	.cfi_endproc
main:
.LFB0:
	.cfi_startproc
	endbr64
	leal	3(%rdi), %ecx
	leal	2(%rdi), %edx
	leal	1(%rdi), %esi
	leal	4(%rdi), %r8d
	jmp	jump_compression
	.cfi_endproc