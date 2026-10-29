	.file	"block13_loop_jamming.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB1:
	.section	.text.startup,"ax",@progbits
.LHOTB1:
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	xorl	%ecx, %ecx
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$1624, %rsp
	.cfi_def_cfa_offset 1680
	movq	%fs:40, %rax
	movq	%rax, 1608(%rsp)
	xorl	%eax, %eax
	leaq	400(%rsp), %r12
	movq	%rsp, %rbp
	leaq	4400(%rsp), %rdi
	movq	%r12, %rax
	leaq	800(%rsp), %rbx
	.p2align 4,,10
	.p2align 3
.L2:
	movl	(%rax), %edx
	movl	(%rbx,%rcx), %esi
	addq	$4, %rax
	imull	%edx, %esi
	addl	$5, %edx
	movl	%edx, -4(%rax)
	movl	%esi, 0(%rbp,%rcx)
	addq	$4, %rcx
	cmpq	%rax, %rdi
	je	.L7
	jmp	.L2
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	main.cold, @function
main.cold:
.LFSB0:
.L7:
	.cfi_def_cfa_offset 1680
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	xorl	%r13d, %r13d
	leaq	.LC0(%rip), %r14
	leaq	1200(%rsp), %r15
.L3:
	movl	0(%rbp,%r13), %esi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	printf@PLT
	movl	(%r12,%r13), %esi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	printf@PLT
	movl	(%rbx,%r13), %esi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	printf@PLT
	movl	(%r15,%r13), %esi
	movq	%r14, %rdi
	xorl	%eax, %eax
	addq	$4, %r13
	call	printf@PLT
	cmpq	$4000, %r13
	jne	.L3
	movq	1608(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L10
	addq	$1624, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L10:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE0:
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE1:
	.section	.text.startup
.LHOTE1:
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
