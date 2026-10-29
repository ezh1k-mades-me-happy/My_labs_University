	.file	"test2.c"
	.text
	.section	.text.random_1,"ax",@progbits
	.globl	random_1
	.type	random_1, @function
random_1:
	endbr64
	movabsq	$1484674407385880829, %rax
	imulq	%rax, %rdi
	leaq	1(%rdi), %rax
	ret
	.size	random_1, .-random_1
	.section	.text.generate_array,"ax",@progbits
	.globl	generate_array
	.type	generate_array, @function
generate_array:
	endbr64
	movl	$8, %esi
	jmp	calloc@PLT
	.size	generate_array, .-generate_array
	.section	.text.fill,"ax",@progbits
	.globl	fill
	.type	fill, @function
fill:
	endbr64
	movabsq	$6197707162560195435, %rax
	xorl	%edx, %edx
	movabsq	$1484674407385880829, %rcx
	imulq	%rsi, %rax
	addq	$42, %rax
.L4:
	cmpq	%rsi, %rdx
	jge	.L7
	imulq	%rcx, %rax
	incq	%rax
	movq	%rax, (%rdi,%rdx,8)
	incq	%rdx
	jmp	.L4
.L7:
	ret
	.size	fill, .-fill
	.section	.text.shuffle_array,"ax",@progbits
	.globl	shuffle_array
	.type	shuffle_array, @function
shuffle_array:
	endbr64
	movabsq	$1484674407385880829, %r9
	movq	%rdx, %rcx
	decq	%rsi
.L9:
	testq	%rsi, %rsi
	jle	.L11
	imulq	%r9, %rcx
	leaq	1(%rsi), %r8
	xorl	%edx, %edx
	movq	(%rdi,%rsi,8), %r10
	incq	%rcx
	movq	%rcx, %rax
	shrq	$33, %rax
	divq	%r8
	leaq	(%rdi,%rdx,8), %rax
	movq	(%rax), %rdx
	movq	%rdx, (%rdi,%rsi,8)
	decq	%rsi
	movq	%r10, (%rax)
	jmp	.L9
.L11:
	ret
	.size	shuffle_array, .-shuffle_array
	.section	.text.sort_array,"ax",@progbits
	.globl	sort_array
	.type	sort_array, @function
sort_array:
	endbr64
	xorl	%edx, %edx
.L13:
	cmpq	%rdx, %rsi
	jle	.L18
	movq	(%rdi,%rdx,8), %rcx
	movq	%rdx, %rax
.L14:
	testl	%eax, %eax
	je	.L15
	movq	-8(%rdi,%rax,8), %r8
	cmpq	%r8, %rcx
	jnb	.L15
	movq	%r8, (%rdi,%rax,8)
	decq	%rax
	jmp	.L14
.L15:
	cltq
	incq	%rdx
	movq	%rcx, (%rdi,%rax,8)
	jmp	.L13
.L18:
	ret
	.size	sort_array, .-sort_array
	.section	.text.is_sorted_arr,"ax",@progbits
	.globl	is_sorted_arr
	.type	is_sorted_arr, @function
is_sorted_arr:
	endbr64
	xorl	%eax, %eax
	decq	%rsi
.L20:
	cmpq	%rax, %rsi
	jle	.L24
	movq	(%rdi,%rax,8), %rdx
	cmpq	%rdx, 8(%rdi,%rax,8)
	jb	.L23
	incq	%rax
	jmp	.L20
.L24:
	movl	$1, %eax
	ret
.L23:
	xorl	%eax, %eax
	ret
	.size	is_sorted_arr, .-is_sorted_arr
	.section	.text.sum_arr,"ax",@progbits
	.globl	sum_arr
	.type	sum_arr, @function
sum_arr:
	endbr64
	xorl	%eax, %eax
	xorl	%edx, %edx
.L26:
	cmpq	%rsi, %rax
	jge	.L28
	addq	(%rdi,%rax,8), %rdx
	incq	%rax
	jmp	.L26
.L28:
	movq	%rdx, %rax
	ret
	.size	sum_arr, .-sum_arr
	.section	.text.checksum,"ax",@progbits
	.globl	checksum
	.type	checksum, @function
checksum:
	endbr64
	xorl	%eax, %eax
	xorl	%edx, %edx
.L30:
	cmpq	%rsi, %rax
	jge	.L32
	movq	(%rdi,%rax,8), %rcx
	incq	%rax
	imulq	%rax, %rcx
	addq	%rcx, %rdx
	jmp	.L30
.L32:
	movq	%rdx, %rax
	ret
	.size	checksum, .-checksum
	.section	.text.sort_doubles,"ax",@progbits
	.globl	sort_doubles
	.type	sort_doubles, @function
sort_doubles:
	endbr64
	movl	$1, %edx
.L34:
	cmpl	%edx, %esi
	jle	.L39
	movsd	(%rdi,%rdx,8), %xmm0
	movq	%rdx, %rax
.L35:
	movsd	-8(%rdi,%rax,8), %xmm1
	comisd	%xmm0, %xmm1
	jbe	.L40
	movsd	%xmm1, (%rdi,%rax,8)
	decq	%rax
	movslq	%eax, %rcx
	testl	%eax, %eax
	jne	.L35
	jmp	.L36
.L40:
	movslq	%eax, %rcx
.L36:
	movsd	%xmm0, (%rdi,%rcx,8)
	incq	%rdx
	jmp	.L34
.L39:
	ret
	.size	sort_doubles, .-sort_doubles
	.section	.rodata.main.str1.1,"aMS",@progbits,1
.LC3:
	.string	"n=%ld repeat=%d median_ms=%.3f min_ms=%.3f max_ms=%.3f checksum=0x%llx\n"
	.section	.text.startup.main,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	endbr64
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	subq	$72, %rsp
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L51
	movl	%edi, %r13d
	movq	8(%rsi), %rdi
	movq	%rsi, %rbp
	movl	$20000, %ebx
	testq	%rdi, %rdi
	je	.L43
	leaq	48(%rsp), %rsi
	movl	$10, %edx
	call	strtol@PLT
	movq	%rax, %rbx
.L43:
	movl	$15, %r12d
	cmpl	$2, %r13d
	je	.L42
	movq	16(%rbp), %rdi
	testq	%rdi, %rdi
	je	.L42
	leaq	48(%rsp), %rsi
	movl	$10, %edx
	call	strtol@PLT
	movq	%rax, %r12
	jmp	.L42
.L51:
	movl	$20000, %ebx
	movl	$15, %r12d
.L42:
	movq	%rbx, %rdi
	movl	%r12d, 32(%rsp)
	orq	$-1, %r13
	call	generate_array
	movq	%rbx, %rdi
	movq	%rax, 16(%rsp)
	call	generate_array
	movq	%rax, 8(%rsp)
	movslq	%r12d, %rax
	salq	$3, %rax
	movq	%rax, %rdi
	movq	%rax, 24(%rsp)
	call	malloc@PLT
	movq	16(%rsp), %rdi
	movq	%rbx, %rsi
	movq	%rax, %rbp
	call	fill
	movq	16(%rsp), %rdi
	movl	$12345, %edx
	call	shuffle_array
	movq	16(%rsp), %rdi
	movq	%rbx, %rsi
	xorl	%r8d, %r8d
	call	sum_arr
	movq	%rax, %r14
	leaq	0(,%rbx,8), %rax
	movq	%rax, 40(%rsp)
.L44:
	movl	32(%rsp), %eax
	movl	%r13d, 36(%rsp)
	cmpl	%eax, %r13d
	jge	.L61
	movq	8(%rsp), %rdi
	movq	16(%rsp), %rsi
	movq	40(%rsp), %rcx
	rep movsb
	call	clock@PLT
	movq	8(%rsp), %rdi
	movq	%rbx, %rsi
	movq	%rax, %r15
	call	sort_array
	call	clock@PLT
	movq	8(%rsp), %rdi
	movq	%rbx, %rsi
	movq	%rax, %r9
	call	is_sorted_arr
	testl	%eax, %eax
	je	.L56
	movq	%rbx, %rsi
	call	sum_arr
	cmpq	%r14, %rax
	jne	.L56
	call	checksum
	cmpl	$-1, 36(%rsp)
	movq	%rax, %r8
	je	.L46
	subq	%r15, %r9
	cvtsi2sdq	%r9, %xmm0
	divsd	.LC0(%rip), %xmm0
	mulsd	.LC1(%rip), %xmm0
	movsd	%xmm0, 0(%rbp,%r13,8)
.L46:
	incq	%r13
	jmp	.L44
.L61:
	movl	%eax, %esi
	movq	%rbp, %rdi
	call	sort_doubles
	movl	32(%rsp), %eax
	movl	$2, %ecx
	cltd
	idivl	%ecx
	cltq
	salq	$3, %rax
	andl	$1, %r12d
	leaq	0(%rbp,%rax), %rdx
	je	.L48
	movsd	(%rdx), %xmm0
	jmp	.L49
.L48:
	movsd	-8(%rbp,%rax), %xmm0
	addsd	(%rdx), %xmm0
	mulsd	.LC2(%rip), %xmm0
.L49:
	movq	24(%rsp), %rax
	movsd	0(%rbp), %xmm1
	movq	%rbx, %rdx
	movl	$2, %edi
	movl	32(%rsp), %ecx
	leaq	.LC3(%rip), %rsi
	movsd	-8(%rbp,%rax), %xmm2
	movb	$3, %al
	call	__printf_chk@PLT
	movq	%rbp, %rdi
	call	free@PLT
	movq	8(%rsp), %rdi
	call	free@PLT
	movq	16(%rsp), %rdi
	call	free@PLT
	xorl	%eax, %eax
	jmp	.L41
.L56:
	movl	$2, %eax
.L41:
	movq	56(%rsp), %rdx
	subq	%fs:40, %rdx
	je	.L50
	call	__stack_chk_fail@PLT
.L50:
	addq	$72, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.size	main, .-main
	.globl	c
	.section	.rodata.c,"a"
	.align 8
	.type	c, @object
	.size	c, 8
c:
	.quad	1
	.globl	a
	.section	.rodata.a,"a"
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
