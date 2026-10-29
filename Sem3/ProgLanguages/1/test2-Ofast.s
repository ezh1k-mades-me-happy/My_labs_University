	.file	"test2.c"
	.text
	.p2align 4
	.globl	random_1
	.type	random_1, @function
random_1:
.LFB53:
	.cfi_startproc
	endbr64
	movabsq	$1484674407385880829, %rax
	imulq	%rax, %rdi
	leaq	1(%rdi), %rax
	ret
	.cfi_endproc
.LFE53:
	.size	random_1, .-random_1
	.p2align 4
	.globl	generate_array
	.type	generate_array, @function
generate_array:
.LFB54:
	.cfi_startproc
	endbr64
	movl	$8, %esi
	jmp	calloc@PLT
	.cfi_endproc
.LFE54:
	.size	generate_array, .-generate_array
	.p2align 4
	.globl	fill
	.type	fill, @function
fill:
.LFB55:
	.cfi_startproc
	endbr64
	movabsq	$6197707162560195435, %rax
	imulq	%rsi, %rax
	addq	$42, %rax
	testq	%rsi, %rsi
	jle	.L4
	movabsq	$1484674407385880829, %rdx
	leaq	(%rdi,%rsi,8), %rcx
	.p2align 4,,10
	.p2align 3
.L6:
	imulq	%rdx, %rax
	addq	$8, %rdi
	addq	$1, %rax
	movq	%rax, -8(%rdi)
	cmpq	%rdi, %rcx
	jne	.L6
.L4:
	ret
	.cfi_endproc
.LFE55:
	.size	fill, .-fill
	.p2align 4
	.globl	shuffle_array
	.type	shuffle_array, @function
shuffle_array:
.LFB56:
	.cfi_startproc
	endbr64
	movq	%rdx, %rcx
	cmpq	$1, %rsi
	jle	.L8
	movabsq	$1484674407385880829, %r9
	.p2align 4,,10
	.p2align 3
.L10:
	imulq	%r9, %rcx
	xorl	%edx, %edx
	movq	-8(%rdi,%rsi,8), %r8
	addq	$1, %rcx
	movq	%rcx, %rax
	shrq	$33, %rax
	divq	%rsi
	leaq	(%rdi,%rdx,8), %rax
	movq	(%rax), %rdx
	movq	%rdx, -8(%rdi,%rsi,8)
	subq	$1, %rsi
	movq	%r8, (%rax)
	cmpq	$1, %rsi
	jne	.L10
.L8:
	ret
	.cfi_endproc
.LFE56:
	.size	shuffle_array, .-shuffle_array
	.p2align 4
	.globl	sort_array
	.type	sort_array, @function
sort_array:
.LFB57:
	.cfi_startproc
	endbr64
	movq	%rdi, %r11
	testq	%rsi, %rsi
	jle	.L12
	movq	%rdi, %r9
	movq	(%rdi), %rdi
	xorl	%r10d, %r10d
	.p2align 4,,10
	.p2align 3
.L15:
	movl	%r10d, %eax
	movq	%r11, %r8
	addl	$1, %r10d
	movq	%r9, %rcx
	movq	%rdi, (%r8)
	addq	$8, %r9
	cmpl	%esi, %r10d
	je	.L12
.L20:
	salq	$3, %rax
	movq	(%r9), %rdi
	subq	%rax, %rcx
	movq	%r9, %rax
	jmp	.L18
	.p2align 4,,10
	.p2align 3
.L16:
	movq	%rdx, (%rax)
	subq	$8, %rax
	cmpq	%rcx, %rax
	je	.L15
.L18:
	movq	-8(%rax), %rdx
	movq	%rax, %r8
	cmpq	%rdx, %rdi
	jb	.L16
	movl	%r10d, %eax
	addl	$1, %r10d
	movq	%r9, %rcx
	movq	%rdi, (%r8)
	addq	$8, %r9
	cmpl	%esi, %r10d
	jne	.L20
.L12:
	ret
	.cfi_endproc
.LFE57:
	.size	sort_array, .-sort_array
	.p2align 4
	.globl	is_sorted_arr
	.type	is_sorted_arr, @function
is_sorted_arr:
.LFB58:
	.cfi_startproc
	endbr64
	cmpq	$1, %rsi
	jle	.L24
	movq	(%rdi), %rdx
	subq	$1, %rsi
	xorl	%eax, %eax
	jmp	.L23
	.p2align 4,,10
	.p2align 3
.L27:
	addq	$1, %rax
	cmpq	%rax, %rsi
	je	.L24
.L23:
	movq	%rdx, %rcx
	movq	8(%rdi,%rax,8), %rdx
	cmpq	%rcx, %rdx
	jnb	.L27
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L24:
	movl	$1, %eax
	ret
	.cfi_endproc
.LFE58:
	.size	is_sorted_arr, .-is_sorted_arr
	.p2align 4
	.globl	sum_arr
	.type	sum_arr, @function
sum_arr:
.LFB59:
	.cfi_startproc
	endbr64
	testq	%rsi, %rsi
	jle	.L34
	cmpq	$1, %rsi
	je	.L35
	movq	%rsi, %rdx
	movq	%rdi, %rax
	pxor	%xmm0, %xmm0
	shrq	%rdx
	salq	$4, %rdx
	addq	%rdi, %rdx
	.p2align 4,,10
	.p2align 3
.L31:
	movdqu	(%rax), %xmm2
	addq	$16, %rax
	paddq	%xmm2, %xmm0
	cmpq	%rax, %rdx
	jne	.L31
	movdqa	%xmm0, %xmm1
	movq	%rsi, %rdx
	psrldq	$8, %xmm1
	andq	$-2, %rdx
	andl	$1, %esi
	paddq	%xmm1, %xmm0
	movq	%xmm0, %rax
	je	.L37
.L30:
	addq	(%rdi,%rdx,8), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L37:
	ret
	.p2align 4,,10
	.p2align 3
.L34:
	xorl	%eax, %eax
	ret
.L35:
	xorl	%edx, %edx
	xorl	%eax, %eax
	jmp	.L30
	.cfi_endproc
.LFE59:
	.size	sum_arr, .-sum_arr
	.p2align 4
	.globl	checksum
	.type	checksum, @function
checksum:
.LFB60:
	.cfi_startproc
	endbr64
	testq	%rsi, %rsi
	jle	.L41
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L40:
	movq	(%rdi,%rax,8), %rdx
	addq	$1, %rax
	imulq	%rax, %rdx
	addq	%rdx, %rcx
	cmpq	%rsi, %rax
	jne	.L40
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L41:
	xorl	%ecx, %ecx
	movq	%rcx, %rax
	ret
	.cfi_endproc
.LFE60:
	.size	checksum, .-checksum
	.p2align 4
	.globl	sort_doubles
	.type	sort_doubles, @function
sort_doubles:
.LFB61:
	.cfi_startproc
	endbr64
	leaq	8(%rdi), %rcx
	movl	$1, %r8d
	cmpl	$1, %esi
	jle	.L43
	.p2align 4,,10
	.p2align 3
.L48:
	movsd	(%rcx), %xmm1
	movq	%rcx, %rax
	jmp	.L45
	.p2align 4,,10
	.p2align 3
.L47:
	movsd	%xmm0, (%rax)
	leaq	-8(%rdx), %rax
	cmpq	%rax, %rdi
	je	.L50
.L45:
	movsd	-8(%rax), %xmm0
	movq	%rax, %rdx
	comisd	%xmm1, %xmm0
	ja	.L47
.L46:
	addl	$1, %r8d
	movsd	%xmm1, (%rdx)
	addq	$8, %rcx
	cmpl	%r8d, %esi
	jne	.L48
.L43:
	ret
	.p2align 4,,10
	.p2align 3
.L50:
	movq	%rdi, %rdx
	jmp	.L46
	.cfi_endproc
.LFE61:
	.size	sort_doubles, .-sort_doubles
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC2:
	.string	"n=%ld repeat=%d median_ms=%.3f min_ms=%.3f max_ms=%.3f checksum=0x%llx\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB63:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
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
	subq	$104, %rsp
	.cfi_def_cfa_offset 160
	movq	%fs:40, %rax
	movq	%rax, 88(%rsp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L54
	movl	%edi, %r12d
	movq	8(%rsi), %rdi
	movq	%rsi, %rbx
	testq	%rdi, %rdi
	je	.L88
	leaq	80(%rsp), %rsi
	movl	$10, %edx
	call	strtol@PLT
	movq	%rax, %rbp
.L55:
	cmpl	$2, %r12d
	je	.L90
	movq	16(%rbx), %rdi
	testq	%rdi, %rdi
	je	.L90
	leaq	80(%rsp), %rsi
	movl	$10, %edx
	call	strtol@PLT
	movq	%rax, %r12
.L56:
	movl	$8, %esi
	movq	%rbp, %rdi
	movl	%r12d, 60(%rsp)
	leaq	-1(%rbp), %r13
	movq	%rbp, 8(%rsp)
	call	calloc@PLT
	movl	$8, %esi
	movq	%rbp, %rdi
	movq	%rax, %r15
	leaq	0(,%rbp,8), %rax
	movq	%rax, (%rsp)
	call	calloc@PLT
	movq	%rax, %rbx
	movslq	%r12d, %rax
	salq	$3, %rax
	movq	%rax, %rdi
	movq	%rax, 64(%rsp)
	call	malloc@PLT
	movq	8(%rsp), %rcx
	movq	%rax, 16(%rsp)
	movabsq	$6197707162560195435, %rax
	imulq	%rbp, %rax
	addq	$42, %rax
	testq	%rbp, %rbp
	jle	.L91
.L86:
	movq	(%rsp), %rdi
	movq	%r15, %r10
	movq	%r15, %rdx
	movabsq	$1484674407385880829, %rsi
	addq	%r15, %rdi
	.p2align 4,,10
	.p2align 3
.L58:
	imulq	%rsi, %rax
	addq	$8, %rdx
	addq	$1, %rax
	movq	%rax, -8(%rdx)
	cmpq	%rdx, %rdi
	jne	.L58
	testq	%r13, %r13
	je	.L92
	movq	%rcx, %rsi
	movl	$12345, %edi
	movabsq	$1484674407385880829, %r9
	.p2align 4,,10
	.p2align 3
.L60:
	imulq	%r9, %rdi
	xorl	%edx, %edx
	movq	-8(%r15,%rsi,8), %r8
	addq	$1, %rdi
	movq	%rdi, %rax
	shrq	$33, %rax
	divq	%rsi
	leaq	(%r15,%rdx,8), %rax
	movq	(%rax), %rdx
	movq	%rdx, -8(%r15,%rsi,8)
	subq	$1, %rsi
	movq	%r8, (%rax)
	cmpq	$1, %rsi
	jne	.L60
	movq	%rcx, %rax
	pxor	%xmm0, %xmm0
	shrq	%rax
	salq	$4, %rax
	addq	%r15, %rax
.L63:
	movdqu	(%r10), %xmm4
	addq	$16, %r10
	paddq	%xmm4, %xmm0
	cmpq	%r10, %rax
	jne	.L63
	movdqa	%xmm0, %xmm1
	psrldq	$8, %xmm1
	paddq	%xmm1, %xmm0
	movq	%xmm0, %rax
	testb	$1, %cl
	je	.L57
	movq	%rcx, %rdx
	andq	$-2, %rdx
.L59:
	addq	(%r15,%rdx,8), %rax
.L57:
	movl	60(%rsp), %edx
	testl	%edx, %edx
	js	.L93
	movl	%r12d, %edi
	movq	%rcx, %r14
	movq	%rcx, 40(%rsp)
	movq	$-1, %r9
	movq	%rdi, 24(%rsp)
	movq	%rcx, %rdi
	shrq	%r14
	andq	$-2, %rdi
	movq	%r12, 72(%rsp)
	salq	$4, %r14
	movq	%rdi, 48(%rsp)
	addq	%rbx, %r14
	movq	%rax, 32(%rsp)
	movq	%r15, 8(%rsp)
	movq	%rbx, %r15
	movq	%r9, %rbx
	.p2align 4,,10
	.p2align 3
.L83:
	movq	(%rsp), %rcx
	movq	8(%rsp), %rsi
	movq	%r15, %rdi
	movq	%rcx, %rdx
	call	__memcpy_chk@PLT
	call	clock@PLT
	movq	%rax, %r12
	testq	%rbp, %rbp
	jle	.L66
	movq	(%r15), %rsi
	movl	%ebp, %r11d
	movq	%r15, %r9
	xorl	%r10d, %r10d
	.p2align 4,,10
	.p2align 3
.L67:
	movl	%r10d, %eax
	movq	%r15, %rdi
	addl	$1, %r10d
	movq	%r9, %rcx
	movq	%rsi, (%rdi)
	addq	$8, %r9
	cmpl	%r11d, %r10d
	je	.L71
.L113:
	salq	$3, %rax
	movq	(%r9), %rsi
	subq	%rax, %rcx
	movq	%r9, %rax
	jmp	.L68
	.p2align 4,,10
	.p2align 3
.L70:
	movq	%rdx, (%rax)
	subq	$8, %rax
	cmpq	%rcx, %rax
	je	.L67
.L68:
	movq	-8(%rax), %rdx
	movq	%rax, %rdi
	cmpq	%rdx, %rsi
	jb	.L70
	movl	%r10d, %eax
	addl	$1, %r10d
	movq	%r9, %rcx
	movq	%rsi, (%rdi)
	addq	$8, %r9
	cmpl	%r11d, %r10d
	jne	.L113
.L71:
	call	clock@PLT
	movq	%rax, %rcx
	testq	%r13, %r13
	jle	.L94
	movq	(%r15), %rdx
	xorl	%eax, %eax
	jmp	.L77
	.p2align 4,,10
	.p2align 3
.L75:
	addq	$1, %rax
	cmpq	%r13, %rax
	jge	.L114
.L77:
	movq	%rdx, %rsi
	movq	8(%r15,%rax,8), %rdx
	cmpq	%rsi, %rdx
	jnb	.L75
.L72:
	movl	$2, %eax
.L53:
	movq	88(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L115
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
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
.L114:
	.cfi_restore_state
	movq	%r15, %rax
	pxor	%xmm0, %xmm0
	.p2align 4,,10
	.p2align 3
.L78:
	movdqu	(%rax), %xmm3
	addq	$16, %rax
	paddq	%xmm3, %xmm0
	cmpq	%r14, %rax
	jne	.L78
	movdqa	%xmm0, %xmm1
	psrldq	$8, %xmm1
	paddq	%xmm1, %xmm0
	movq	%xmm0, %rax
	testb	$1, 40(%rsp)
	je	.L81
	movq	48(%rsp), %rdx
.L74:
	addq	(%r15,%rdx,8), %rax
.L81:
	cmpq	%rax, 32(%rsp)
	jne	.L72
	xorl	%r10d, %r10d
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L80:
	movq	(%r15,%rax,8), %rdx
	addq	$1, %rax
	imulq	%rax, %rdx
	addq	%rdx, %r10
	cmpq	%rax, %rbp
	jne	.L80
.L73:
	cmpl	$-1, %ebx
	je	.L82
	subq	%r12, %rcx
	pxor	%xmm0, %xmm0
	movq	16(%rsp), %rax
	cvtsi2sdq	%rcx, %xmm0
	mulsd	.LC0(%rip), %xmm0
	movsd	%xmm0, (%rax,%rbx,8)
.L82:
	addq	$1, %rbx
	cmpq	%rbx, 24(%rsp)
	jne	.L83
	movq	%r15, %rbx
	movq	72(%rsp), %r12
	movq	8(%rsp), %r15
.L65:
	movl	60(%rsp), %esi
	movq	16(%rsp), %rdi
	call	sort_doubles
	movl	%esi, %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	cltq
	salq	$3, %rax
	andb	$1, %r12b
	leaq	(%rdi,%rax), %rdx
	jne	.L116
	movq	16(%rsp), %rdi
	movsd	-8(%rdi,%rax), %xmm0
	addsd	(%rdx), %xmm0
	mulsd	.LC1(%rip), %xmm0
.L85:
	movq	16(%rsp), %r14
	movq	64(%rsp), %rdi
	movq	%r10, %r8
	movq	%rbp, %rdx
	movl	60(%rsp), %ecx
	leaq	.LC2(%rip), %rsi
	movl	$3, %eax
	movsd	-8(%r14,%rdi), %xmm2
	movsd	(%r14), %xmm1
	movl	$2, %edi
	call	__printf_chk@PLT
	movq	%r14, %rdi
	call	free@PLT
	movq	%rbx, %rdi
	call	free@PLT
	movq	%r15, %rdi
	call	free@PLT
	xorl	%eax, %eax
	jmp	.L53
.L66:
	call	clock@PLT
	cmpq	$0, 32(%rsp)
	movq	%rax, %rcx
	jne	.L72
	xorl	%r10d, %r10d
	jmp	.L73
.L94:
	xorl	%eax, %eax
	xorl	%edx, %edx
	jmp	.L74
.L54:
	movl	$8, %esi
	movl	$20000, %edi
	movl	$20000, %ebp
	movl	$19999, %r13d
	call	calloc@PLT
	movl	$8, %esi
	movl	$20000, %edi
	movl	$15, %r12d
	movq	%rax, %r15
	call	calloc@PLT
	movl	$120, %edi
	movq	%rax, %rbx
	call	malloc@PLT
	movq	$160000, (%rsp)
	movl	$20000, %ecx
	movq	%rax, 16(%rsp)
	movabsq	$-7976924124278159478, %rax
	movl	$15, 60(%rsp)
	movq	$120, 64(%rsp)
	jmp	.L86
.L90:
	movl	$15, %r12d
	jmp	.L56
.L116:
	movsd	(%rdx), %xmm0
	jmp	.L85
.L88:
	movl	$20000, %ebp
	jmp	.L55
.L91:
	xorl	%eax, %eax
	jmp	.L57
.L93:
	xorl	%r10d, %r10d
	jmp	.L65
.L115:
	call	__stack_chk_fail@PLT
.L92:
	xorl	%edx, %edx
	xorl	%eax, %eax
	jmp	.L59
	.cfi_endproc
.LFE63:
	.size	main, .-main
	.globl	c
	.section	.rodata
	.align 8
	.type	c, @object
	.size	c, 8
c:
	.quad	1
	.globl	a
	.align 8
	.type	a, @object
	.size	a, 8
a:
	.quad	1484674407385880829
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	-755914244
	.long	1062232653
	.align 8
.LC1:
	.long	0
	.long	1071644672
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
