	.file	"lect-2.c"
	.text
	.p2align 4
	.globl	mx
	.type	mx, @function
mx:
.LFB23:
	.cfi_startproc
	endbr64
	cmpl	%esi, %edi
	movl	%esi, %eax
	cmovge	%edi, %eax
	ret
	.cfi_endproc
.LFE23:
	.size	mx, .-mx
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	xorl	%esi, %esi
	xorl	%ebx, %ebx
	movl	$9572, %edi
	xorl	%eax, %eax
	call	__isoc99_scanf@PLT
	movl	%ebx, %esi
	movl	$9572, %edi
	xorl	%eax, %eax
	call	__isoc99_scanf@PLT
	movl	%ebx, %edx
	movl	$9572, %esi
	xorl	%eax, %eax
	movl	$2, %edi
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	__printf_chk@PLT
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
