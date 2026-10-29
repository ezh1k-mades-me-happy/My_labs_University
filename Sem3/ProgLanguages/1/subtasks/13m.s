	.file	"block13_loop_jamming.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d"
.LC1:
	.string	"%d\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	leaq	.LC0(%rip), %rbx
	movq	%rbx, %rdi
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	leaq	12(%rsp), %rsi
	call	scanf@PLT
	leaq	16(%rsp), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	scanf@PLT
	leaq	20(%rsp), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	scanf@PLT
	movl	16(%rsp), %eax
	movl	12(%rsp), %edx
	leaq	.LC1(%rip), %rdi
	imull	$99, %eax, %esi
	imull	%edx, %eax
	addl	%edx, %esi
	imull	$99, %eax, %eax
	addl	%eax, %esi
	xorl	%eax, %eax
	call	printf@PLT
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L5
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L5:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.text
	.p2align 4
	.globl	loop_jamming
	.type	loop_jamming, @function
loop_jamming:
.LFB1:
	.cfi_startproc
	endbr64
	movl	%edi, %eax
	imull	%esi, %eax
	imull	$99, %eax, %edx
	imull	$99, %esi, %eax
	addl	%edi, %eax
	addl	%edx, %eax
	ret
	.cfi_endproc
.LFE1:
	.size	loop_jamming, .-loop_jamming
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
