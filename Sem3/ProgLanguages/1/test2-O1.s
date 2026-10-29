	.file	"test2.c"
	.text
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
	.globl	generate_array
	.type	generate_array, @function
generate_array:
.LFB54:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$8, %esi
	call	calloc@PLT
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE54:
	.size	generate_array, .-generate_array
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
	movq	%rdi, %rdx
	leaq	(%rdi,%rsi,8), %rsi
	movabsq	$1484674407385880829, %rcx
.L6:
	imulq	%rcx, %rax
	addq	$1, %rax
	movq	%rax, (%rdx)
	addq	$8, %rdx
	cmpq	%rsi, %rdx
	jne	.L6
.L4:
	ret
	.cfi_endproc
.LFE55:
	.size	fill, .-fill
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
.L10:
	imulq	%r9, %rcx
	addq	$1, %rcx
	movq	-8(%rdi,%rsi,8), %r8
	movq	%rcx, %rax
	shrq	$33, %rax
	movl	$0, %edx
	divq	%rsi
	leaq	(%rdi,%rdx,8), %rax
	movq	(%rax), %rdx
	movq	%rdx, -8(%rdi,%rsi,8)
	movq	%r8, (%rax)
	subq	$1, %rsi
	cmpq	$1, %rsi
	jne	.L10
.L8:
	ret
	.cfi_endproc
.LFE56:
	.size	shuffle_array, .-shuffle_array
	.globl	sort_array
	.type	sort_array, @function
sort_array:
.LFB57:
	.cfi_startproc
	endbr64
	testq	%rsi, %rsi
	jle	.L12
	movq	%rdi, %r10
	movl	$0, %r9d
	jmp	.L17
.L15:
	movslq	%edx, %rdx
	movq	%r8, (%rdi,%rdx,8)
	addl	$1, %r9d
	addq	$8, %r10
	cmpl	%esi, %r9d
	je	.L12
.L17:
	movq	(%r10), %r8
	movq	%r10, %rax
	movl	%r9d, %edx
	testl	%r9d, %r9d
	jle	.L15
.L14:
	movq	-8(%rax), %rcx
	cmpq	%rcx, %r8
	jnb	.L15
	movq	%rcx, (%rax)
	subq	$8, %rax
	subl	$1, %edx
	jne	.L14
	jmp	.L15
.L12:
	ret
	.cfi_endproc
.LFE57:
	.size	sort_array, .-sort_array
	.globl	is_sorted_arr
	.type	is_sorted_arr, @function
is_sorted_arr:
.LFB58:
	.cfi_startproc
	endbr64
	cmpq	$1, %rsi
	jle	.L24
	subq	$1, %rsi
	movl	$0, %eax
.L23:
	movq	(%rdi,%rax,8), %rdx
	cmpq	%rdx, 8(%rdi,%rax,8)
	jb	.L25
	addq	$1, %rax
	cmpq	%rsi, %rax
	jne	.L23
	movl	$1, %eax
	ret
.L24:
	movl	$1, %eax
	ret
.L25:
	movl	$0, %eax
	ret
	.cfi_endproc
.LFE58:
	.size	is_sorted_arr, .-is_sorted_arr
	.globl	sum_arr
	.type	sum_arr, @function
sum_arr:
.LFB59:
	.cfi_startproc
	endbr64
	testq	%rsi, %rsi
	jle	.L30
	movq	%rdi, %rax
	leaq	(%rdi,%rsi,8), %rcx
	movl	$0, %edx
.L29:
	addq	(%rax), %rdx
	addq	$8, %rax
	cmpq	%rcx, %rax
	jne	.L29
.L27:
	movq	%rdx, %rax
	ret
.L30:
	movl	$0, %edx
	jmp	.L27
	.cfi_endproc
.LFE59:
	.size	sum_arr, .-sum_arr
	.globl	checksum
	.type	checksum, @function
checksum:
.LFB60:
	.cfi_startproc
	endbr64
	testq	%rsi, %rsi
	jle	.L35
	movl	$0, %eax
	movl	$0, %ecx
.L34:
	movq	(%rdi,%rax,8), %rdx
	addq	$1, %rax
	imulq	%rax, %rdx
	addq	%rdx, %rcx
	cmpq	%rsi, %rax
	jne	.L34
.L32:
	movq	%rcx, %rax
	ret
.L35:
	movl	$0, %ecx
	jmp	.L32
	.cfi_endproc
.LFE60:
	.size	checksum, .-checksum
	.globl	sort_doubles
	.type	sort_doubles, @function
sort_doubles:
.LFB61:
	.cfi_startproc
	endbr64
	cmpl	$1, %esi
	jle	.L37
	leaq	8(%rdi), %r8
	movl	$1, %ecx
	jmp	.L43
.L41:
	movslq	%edx, %rdx
	movsd	%xmm1, (%rdi,%rdx,8)
	addl	$1, %ecx
	addq	$8, %r8
	cmpl	%ecx, %esi
	je	.L48
.L43:
	movsd	(%r8), %xmm1
	movq	%r8, %rax
	movl	%ecx, %edx
	testl	%ecx, %ecx
	jle	.L49
.L39:
	movsd	-8(%rax), %xmm0
	comisd	%xmm1, %xmm0
	jbe	.L41
	movsd	%xmm0, (%rax)
	subq	$8, %rax
	subl	$1, %edx
	jne	.L39
	jmp	.L41
.L48:
	ret
.L49:
	movslq	%ecx, %rax
	movsd	%xmm1, (%rdi,%rax,8)
	addl	$1, %ecx
	addq	$8, %r8
	jmp	.L43
.L37:
	ret
	.cfi_endproc
.LFE61:
	.size	sort_doubles, .-sort_doubles
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
	.string	"n=%ld repeat=%d median_ms=%.3f min_ms=%.3f max_ms=%.3f checksum=0x%llx\n"
	.text
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
	jle	.L51
	movl	%edi, %ebx
	movq	%rsi, %r12
	movq	8(%rsi), %rdi
	testq	%rdi, %rdi
	je	.L62
	leaq	64(%rsp), %rsi
	movl	$10, %edx
	call	strtol@PLT
	movq	%rax, %rbp
.L52:
	cmpl	$2, %ebx
	jle	.L53
	movq	16(%r12), %rdi
	testq	%rdi, %rdi
	je	.L53
	leaq	64(%rsp), %rsi
	movl	$10, %edx
	call	strtol@PLT
	movq	%rax, %r15
	movq	%rax, 40(%rsp)
	movl	%eax, 52(%rsp)
	movq	%rbp, %rdi
	call	generate_array
	movq	%rax, %r13
	movq	%rbp, %rdi
	call	generate_array
	movq	%rax, %rbx
	movslq	%r15d, %rax
	salq	$3, %rax
	movq	%rax, 56(%rsp)
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, 32(%rsp)
	movq	%rbp, %rsi
	movq	%r13, %rdi
	call	fill
	movl	$12345, %edx
	movq	%rbp, %rsi
	movq	%r13, %rdi
	call	shuffle_array
	movq	%rbp, %rsi
	movq	%r13, %rdi
	call	sum_arr
	movq	%rax, %r14
	leaq	0(,%rbp,8), %rax
	movq	%rax, 16(%rsp)
	testl	%r15d, %r15d
	js	.L63
.L60:
	movl	40(%rsp), %r15d
	movq	$-1, %r12
	jmp	.L57
.L62:
	movl	$20000, %ebp
	jmp	.L52
.L56:
	addq	$1, %r12
	cmpq	%r15, %r12
	je	.L54
.L57:
	movq	16(%rsp), %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	memcpy@PLT
	call	clock@PLT
	movq	%rax, (%rsp)
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	sort_array
	call	clock@PLT
	movq	%rax, 8(%rsp)
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	is_sorted_arr
	testl	%eax, %eax
	je	.L64
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	sum_arr
	cmpq	%r14, %rax
	jne	.L65
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	checksum
	movq	%rax, 24(%rsp)
	testl	%r12d, %r12d
	js	.L56
	movq	8(%rsp), %rcx
	movq	(%rsp), %rax
	subq	%rax, %rcx
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rcx, %xmm0
	divsd	.LC0(%rip), %xmm0
	mulsd	.LC1(%rip), %xmm0
	movq	32(%rsp), %rax
	movsd	%xmm0, (%rax,%r12,8)
	jmp	.L56
.L63:
	movq	$0, 24(%rsp)
.L54:
	movl	52(%rsp), %r15d
	movl	%r15d, %esi
	movq	32(%rsp), %r14
	movq	%r14, %rdi
	call	sort_doubles
	testb	$1, 40(%rsp)
	je	.L58
	movl	$2, %ecx
	movl	%r15d, %eax
	cltd
	idivl	%ecx
	cltq
	movsd	(%r14,%rax,8), %xmm0
.L59:
	movq	24(%rsp), %r8
	movq	32(%rsp), %r14
	movq	56(%rsp), %rdx
	movsd	-8(%r14,%rdx), %xmm2
	movsd	(%r14), %xmm1
	movl	52(%rsp), %ecx
	movq	%rbp, %rdx
	leaq	.LC3(%rip), %rsi
	movl	$2, %edi
	movl	$3, %eax
	call	__printf_chk@PLT
	movq	%r14, %rdi
	call	free@PLT
	movq	%rbx, %rdi
	call	free@PLT
	movq	%r13, %rdi
	call	free@PLT
	movl	$0, %eax
.L50:
	movq	72(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L68
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
.L58:
	.cfi_restore_state
	movl	$2, %ecx
	movl	52(%rsp), %eax
	cltd
	idivl	%ecx
	cltq
	movq	32(%rsp), %rdx
	movsd	-8(%rdx,%rax,8), %xmm0
	addsd	(%rdx,%rax,8), %xmm0
	mulsd	.LC2(%rip), %xmm0
	jmp	.L59
.L64:
	movl	$2, %eax
	jmp	.L50
.L65:
	movl	$2, %eax
	jmp	.L50
.L51:
	movl	$20000, %ebp
.L53:
	movq	%rbp, %rdi
	call	generate_array
	movq	%rax, %r13
	movq	%rbp, %rdi
	call	generate_array
	movq	%rax, %rbx
	movl	$120, %edi
	call	malloc@PLT
	movq	%rax, 32(%rsp)
	movq	%rbp, %rsi
	movq	%r13, %rdi
	call	fill
	movl	$12345, %edx
	movq	%rbp, %rsi
	movq	%r13, %rdi
	call	shuffle_array
	movq	%rbp, %rsi
	movq	%r13, %rdi
	call	sum_arr
	movq	%rax, %r14
	leaq	0(,%rbp,8), %rax
	movq	%rax, 16(%rsp)
	movq	$15, 40(%rsp)
	movl	$15, 52(%rsp)
	movq	$120, 56(%rsp)
	jmp	.L60
.L68:
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
