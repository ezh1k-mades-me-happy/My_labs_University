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
	cmpq	%rcx, %rdi
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
	jle	.L31
	leaq	(%rdi,%rsi,8), %rdx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L30:
	addq	(%rdi), %rax
	addq	$8, %rdi
	cmpq	%rdx, %rdi
	jne	.L30
	ret
	.p2align 4,,10
	.p2align 3
.L31:
	xorl	%eax, %eax
	ret
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
	jle	.L36
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L35:
	movq	(%rdi,%rax,8), %rdx
	addq	$1, %rax
	imulq	%rax, %rdx
	addq	%rdx, %rcx
	cmpq	%rsi, %rax
	jne	.L35
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L36:
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
	jle	.L38
	.p2align 4,,10
	.p2align 3
.L43:
	movsd	(%rcx), %xmm1
	movq	%rcx, %rax
	jmp	.L40
	.p2align 4,,10
	.p2align 3
.L42:
	movsd	%xmm0, (%rax)
	leaq	-8(%rdx), %rax
	cmpq	%rax, %rdi
	je	.L45
.L40:
	movsd	-8(%rax), %xmm0
	movq	%rax, %rdx
	comisd	%xmm1, %xmm0
	ja	.L42
.L41:
	addl	$1, %r8d
	movsd	%xmm1, (%rdx)
	addq	$8, %rcx
	cmpl	%r8d, %esi
	jne	.L43
.L38:
	ret
	.p2align 4,,10
	.p2align 3
.L45:
	movq	%rdi, %rdx
	jmp	.L41
	.cfi_endproc
.LFE61:
	.size	sort_doubles, .-sort_doubles
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
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
	subq	$88, %rsp
	.cfi_def_cfa_offset 144
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L49
	movl	%edi, %ebx
	movq	8(%rsi), %rdi
	movq	%rsi, %rbp
	testq	%rdi, %rdi
	je	.L71
	leaq	64(%rsp), %rsi
	movl	$10, %edx
	call	strtol@PLT
	movq	%rax, %r14
.L50:
	cmpl	$2, %ebx
	je	.L51
	movq	16(%rbp), %rdi
	testq	%rdi, %rdi
	je	.L51
	movl	$10, %edx
	leaq	64(%rsp), %rsi
	movq	%r14, %r15
	call	strtol@PLT
	movl	$8, %esi
	movq	%r14, %rdi
	movq	%rax, %r13
	movq	%rax, 40(%rsp)
	movl	%eax, 16(%rsp)
	call	calloc@PLT
	movl	$8, %esi
	movq	%r14, %rdi
	movq	%rax, %rbp
	movq	%rax, 8(%rsp)
	leaq	0(,%r14,8), %rax
	movq	%rax, (%rsp)
	call	calloc@PLT
	movq	%rax, %rbx
	movslq	%r13d, %rax
	salq	$3, %rax
	movq	%rax, %rdi
	movq	%rax, 48(%rsp)
	call	malloc@PLT
	movq	%r14, %rsi
	movq	%rbp, %rdi
	movq	%rax, 32(%rsp)
	call	fill
	movl	$12345, %edx
	movq	%rbp, %rdi
	call	shuffle_array
	testq	%r14, %r14
	movl	16(%rsp), %ecx
	jle	.L92
.L68:
	movq	8(%rsp), %rdi
	movq	(%rsp), %rdx
	xorl	%ebp, %ebp
	movq	%rdi, %rax
	addq	%rdi, %rdx
	.p2align 4,,10
	.p2align 3
.L53:
	addq	(%rax), %rbp
	addq	$8, %rax
	cmpq	%rdx, %rax
	jne	.L53
.L52:
	testl	%ecx, %ecx
	js	.L73
.L69:
	movl	40(%rsp), %eax
	subq	$1, %r15
	movq	%rbp, 16(%rsp)
	movq	$-1, %r13
	movl	%ecx, 60(%rsp)
	movq	%rax, 24(%rsp)
	movq	(%rsp), %rax
	leaq	(%rbx,%rax), %r12
	movq	%r15, %rax
	movq	%r14, %r15
	movq	%r12, %r14
	movq	%rax, %r12
	.p2align 4,,10
	.p2align 3
.L65:
	movq	(%rsp), %rdx
	movq	8(%rsp), %rsi
	movq	%rbx, %rdi
	movq	%rdx, %rcx
	call	__memcpy_chk@PLT
	call	clock@PLT
	movq	%r15, %rsi
	movq	%rbx, %rdi
	movq	%rax, %rbp
	call	sort_array
	call	clock@PLT
	movq	%rax, %rdx
	cmpq	$1, %r15
	jle	.L55
	movq	(%rbx), %rcx
	xorl	%eax, %eax
	jmp	.L57
	.p2align 4,,10
	.p2align 3
.L93:
	addq	$1, %rax
	cmpq	%rax, %r12
	je	.L91
.L57:
	movq	%rcx, %rsi
	movq	8(%rbx,%rax,8), %rcx
	cmpq	%rsi, %rcx
	jnb	.L93
.L76:
	movl	$2, %eax
.L48:
	movq	72(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L94
	addq	$88, %rsp
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
	.p2align 4,,10
	.p2align 3
.L91:
	.cfi_restore_state
	movq	%rbx, %rax
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L60:
	addq	(%rax), %rcx
	addq	$8, %rax
	cmpq	%r14, %rax
	jne	.L60
	movq	16(%rsp), %rax
	cmpq	%rax, %rcx
	jne	.L76
	xorl	%esi, %esi
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L63:
	movq	(%rbx,%rax,8), %rcx
	addq	$1, %rax
	imulq	%rax, %rcx
	addq	%rcx, %rsi
	cmpq	%r15, %rax
	jne	.L63
.L62:
	cmpl	$-1, %r13d
	je	.L64
	subq	%rbp, %rdx
	pxor	%xmm0, %xmm0
	movq	32(%rsp), %rax
	cvtsi2sdq	%rdx, %xmm0
	divsd	.LC0(%rip), %xmm0
	mulsd	.LC1(%rip), %xmm0
	movsd	%xmm0, (%rax,%r13,8)
.L64:
	movq	24(%rsp), %rax
	addq	$1, %r13
	cmpq	%rax, %r13
	jne	.L65
	movl	60(%rsp), %ecx
	movq	%rsi, %r9
	movq	%r15, %r14
.L54:
	movq	32(%rsp), %rdi
	movl	%ecx, %esi
	movl	%ecx, (%rsp)
	call	sort_doubles
	movl	(%rsp), %ecx
	movl	$2, %esi
	movl	%ecx, %eax
	cltd
	idivl	%esi
	cltq
	salq	$3, %rax
	leaq	(%rdi,%rax), %rdx
	testb	$1, 40(%rsp)
	jne	.L95
	movq	32(%rsp), %rdi
	movsd	-8(%rdi,%rax), %xmm0
	addsd	(%rdx), %xmm0
	mulsd	.LC2(%rip), %xmm0
.L67:
	movq	32(%rsp), %r15
	movq	48(%rsp), %rdi
	movq	%r9, %r8
	movq	%r14, %rdx
	leaq	.LC3(%rip), %rsi
	movl	$3, %eax
	movsd	-8(%r15,%rdi), %xmm2
	movsd	(%r15), %xmm1
	movl	$2, %edi
	call	__printf_chk@PLT
	movq	%r15, %rdi
	call	free@PLT
	movq	%rbx, %rdi
	call	free@PLT
	movq	8(%rsp), %rdi
	call	free@PLT
	xorl	%eax, %eax
	jmp	.L48
	.p2align 4,,10
	.p2align 3
.L55:
	je	.L91
	cmpq	$0, 16(%rsp)
	jne	.L76
	xorl	%esi, %esi
	jmp	.L62
.L49:
	movl	$8, %esi
	movl	$20000, %edi
	movl	$20000, %r15d
	call	calloc@PLT
	movl	$8, %esi
	movl	$20000, %edi
	movq	%rax, %r14
	movq	%rax, 8(%rsp)
	call	calloc@PLT
	movl	$120, %edi
	movq	%rax, %rbx
	call	malloc@PLT
	movq	%r14, %rdi
	movl	$20000, %esi
	movq	%rax, 32(%rsp)
	call	fill
	movq	%r14, %rdi
	movl	$12345, %edx
	movl	$20000, %r14d
	call	shuffle_array
	movq	$160000, (%rsp)
	movl	$15, %ecx
	movq	$15, 40(%rsp)
	movq	$120, 48(%rsp)
	jmp	.L68
.L71:
	movl	$20000, %r14d
	jmp	.L50
.L95:
	movsd	(%rdx), %xmm0
	jmp	.L67
.L51:
	movl	$8, %esi
	movq	%r14, %rdi
	movq	%r14, %r15
	call	calloc@PLT
	movl	$8, %esi
	movq	%r14, %rdi
	movq	%rax, %rbp
	movq	%rax, 8(%rsp)
	leaq	0(,%r14,8), %rax
	movq	%rax, (%rsp)
	call	calloc@PLT
	movl	$120, %edi
	movq	%rax, %rbx
	call	malloc@PLT
	movq	%rbp, %rdi
	movq	%r14, %rsi
	movq	%rax, 32(%rsp)
	call	fill
	movl	$12345, %edx
	movq	%rbp, %rdi
	call	shuffle_array
	testq	%r14, %r14
	jle	.L96
	movq	$15, 40(%rsp)
	movl	$15, %ecx
	movq	$120, 48(%rsp)
	jmp	.L68
.L92:
	xorl	%ebp, %ebp
	jmp	.L52
.L73:
	xorl	%r9d, %r9d
	jmp	.L54
.L96:
	movq	$15, 40(%rsp)
	xorl	%ebp, %ebp
	movl	$15, %ecx
	movq	$120, 48(%rsp)
	jmp	.L69
.L94:
	call	__stack_chk_fail@PLT
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
	.long	0
	.long	1093567616
	.align 8
.LC1:
	.long	0
	.long	1083129856
	.align 8
.LC2:
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
