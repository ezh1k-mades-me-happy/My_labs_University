	.file	"test2.c"
	.text
	.type	parse_arg, @function
parse_arg:
.LFB62:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L4
	movq	%rsp, %rsi
	movl	$10, %edx
	call	strtol@PLT
.L1:
	movq	8(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L6
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L4:
	.cfi_restore_state
	movq	%rsi, %rax
	jmp	.L1
.L6:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE62:
	.size	parse_arg, .-parse_arg
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
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbp
	movq	%rsi, %rbx
	movabsq	$6197707162560195435, %rdi
	imulq	%rsi, %rdi
	addq	$42, %rdi
	movl	$0, %r12d
	jmp	.L11
.L12:
	call	random_1
	movq	%rax, %rdi
	movq	%rax, 0(%rbp,%r12,8)
	addq	$1, %r12
.L11:
	cmpq	%rbx, %r12
	jl	.L12
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbp
	movq	%rdx, %rdi
	leaq	-1(%rsi), %rbx
	jmp	.L15
.L16:
	call	random_1
	movq	%rax, %rdi
	shrq	$33, %rax
	leaq	1(%rbx), %rcx
	movl	$0, %edx
	divq	%rcx
	leaq	0(%rbp,%rbx,8), %rcx
	movq	(%rcx), %rsi
	leaq	0(%rbp,%rdx,8), %rax
	movq	(%rax), %rdx
	movq	%rdx, (%rcx)
	movq	%rsi, (%rax)
	subq	$1, %rbx
.L15:
	testq	%rbx, %rbx
	jg	.L16
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
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
	movl	$0, %r9d
	jmp	.L19
.L22:
	movq	%rcx, (%rdi,%rax)
	subl	$1, %edx
.L20:
	testl	%edx, %edx
	jle	.L21
	movslq	%edx, %rax
	salq	$3, %rax
	movq	-8(%rdi,%rax), %rcx
	cmpq	%rcx, %r8
	jb	.L22
.L21:
	movslq	%edx, %rdx
	movq	%r8, (%rdi,%rdx,8)
	addl	$1, %r9d
.L19:
	movslq	%r9d, %rax
	cmpq	%rsi, %rax
	jge	.L24
	movslq	%r9d, %rax
	movq	(%rdi,%rax,8), %r8
	movl	%r9d, %edx
	jmp	.L20
.L24:
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
	movl	$0, %eax
	jmp	.L26
.L31:
	addq	$1, %rax
.L26:
	leaq	-1(%rsi), %rdx
	cmpq	%rax, %rdx
	jle	.L30
	movq	(%rdi,%rax,8), %rcx
	cmpq	%rcx, 8(%rdi,%rax,8)
	jnb	.L31
	movl	$0, %eax
	ret
.L30:
	movl	$1, %eax
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
	movl	$0, %eax
	movl	$0, %edx
	jmp	.L33
.L34:
	addq	(%rdi,%rax,8), %rdx
	addq	$1, %rax
.L33:
	cmpq	%rsi, %rax
	jl	.L34
	movq	%rdx, %rax
	ret
	.cfi_endproc
.LFE59:
	.size	sum_arr, .-sum_arr
	.globl	checksum
	.type	checksum, @function
checksum:
.LFB60:
	.cfi_startproc
	endbr64
	movl	$0, %eax
	movl	$0, %ecx
	jmp	.L36
.L37:
	movq	(%rdi,%rax,8), %rdx
	addq	$1, %rax
	imulq	%rax, %rdx
	addq	%rdx, %rcx
.L36:
	cmpq	%rsi, %rax
	jl	.L37
	movq	%rcx, %rax
	ret
	.cfi_endproc
.LFE60:
	.size	checksum, .-checksum
	.globl	sort_doubles
	.type	sort_doubles, @function
sort_doubles:
.LFB61:
	.cfi_startproc
	endbr64
	movl	$1, %ecx
	jmp	.L39
.L42:
	movsd	%xmm0, (%rdi,%rax)
	subl	$1, %edx
.L40:
	testl	%edx, %edx
	jle	.L41
	movslq	%edx, %rax
	salq	$3, %rax
	movsd	-8(%rdi,%rax), %xmm0
	comisd	%xmm1, %xmm0
	ja	.L42
.L41:
	movslq	%edx, %rdx
	movsd	%xmm1, (%rdi,%rdx,8)
	addl	$1, %ecx
.L39:
	cmpl	%esi, %ecx
	jge	.L44
	movslq	%ecx, %rax
	movsd	(%rdi,%rax,8), %xmm1
	movl	%ecx, %edx
	jmp	.L40
.L44:
	ret
	.cfi_endproc
.LFE61:
	.size	sort_doubles, .-sort_doubles
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"n"
.LC1:
	.string	"repeat"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC5:
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
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movl	%edi, %ebx
	movq	%rsi, %r12
	cmpl	$1, %edi
	jle	.L54
	movq	8(%rsi), %rdi
.L46:
	leaq	.LC0(%rip), %rdx
	movl	$20000, %esi
	call	parse_arg
	movq	%rax, %rbp
	cmpl	$2, %ebx
	jle	.L55
	movq	16(%r12), %rdi
.L47:
	leaq	.LC1(%rip), %rdx
	movl	$15, %esi
	call	parse_arg
	movq	%rax, %r15
	movq	%rax, 48(%rsp)
	movl	%eax, %r14d
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
	movq	%rax, 40(%rsp)
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
	movq	%rax, %r15
	leaq	0(,%rbp,8), %rax
	movq	%rax, 24(%rsp)
	movl	$-1, %r12d
	movq	$0, 32(%rsp)
	jmp	.L48
.L54:
	movl	$0, %edi
	jmp	.L46
.L55:
	movl	$0, %edi
	jmp	.L47
.L50:
	addl	$1, %r12d
.L48:
	cmpl	%r14d, %r12d
	jge	.L59
	movq	24(%rsp), %rdx
	movq	%r13, %rsi
	movq	%rbx, %rdi
	call	memcpy@PLT
	call	clock@PLT
	movq	%rax, 8(%rsp)
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	sort_array
	call	clock@PLT
	movq	%rax, 16(%rsp)
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	is_sorted_arr
	testl	%eax, %eax
	je	.L56
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	sum_arr
	cmpq	%r15, %rax
	jne	.L57
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	checksum
	movq	%rax, 32(%rsp)
	testl	%r12d, %r12d
	js	.L50
	movq	16(%rsp), %rcx
	movq	8(%rsp), %rax
	subq	%rax, %rcx
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rcx, %xmm0
	divsd	.LC2(%rip), %xmm0
	movslq	%r12d, %rax
	mulsd	.LC3(%rip), %xmm0
	movq	40(%rsp), %rdx
	movsd	%xmm0, (%rdx,%rax,8)
	jmp	.L50
.L59:
	movl	%r14d, %esi
	movq	40(%rsp), %r15
	movq	%r15, %rdi
	call	sort_doubles
	testb	$1, 48(%rsp)
	je	.L52
	movl	$2, %ecx
	movl	%r14d, %eax
	cltd
	idivl	%ecx
	cltq
	movsd	(%r15,%rax,8), %xmm0
.L53:
	movq	32(%rsp), %r8
	movq	40(%rsp), %r15
	movq	56(%rsp), %rcx
	movsd	-8(%r15,%rcx), %xmm2
	movsd	(%r15), %xmm1
	movl	%r14d, %ecx
	movq	%rbp, %rdx
	leaq	.LC5(%rip), %rsi
	movl	$2, %edi
	movl	$3, %eax
	call	__printf_chk@PLT
	movq	%r15, %rdi
	call	free@PLT
	movq	%rbx, %rdi
	call	free@PLT
	movq	%r13, %rdi
	call	free@PLT
	movl	$0, %eax
.L45:
	addq	$72, %rsp
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
.L52:
	.cfi_restore_state
	movl	$2, %ecx
	movl	%r14d, %eax
	cltd
	idivl	%ecx
	cltq
	movq	40(%rsp), %rcx
	movsd	(%rcx,%rax,8), %xmm0
	addsd	-8(%rcx,%rax,8), %xmm0
	mulsd	.LC4(%rip), %xmm0
	jmp	.L53
.L56:
	movl	$2, %eax
	jmp	.L45
.L57:
	movl	$2, %eax
	jmp	.L45
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
.LC2:
	.long	0
	.long	1093567616
	.align 8
.LC3:
	.long	0
	.long	1083129856
	.align 8
.LC4:
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
