	.file	"test2.c"
	.text
	.globl	a
	.section	.rodata
	.align 8
	.type	a, @object
	.size	a, 8
a:
	.quad	1484674407385880829
	.globl	c
	.align 8
	.type	c, @object
	.size	c, 8
c:
	.quad	1
	.text
	.globl	random_1
	.type	random_1, @function
random_1:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movabsq	$1484674407385880829, %rax
	imulq	-8(%rbp), %rax
	movl	$1, %edx
	addq	%rdx, %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	random_1, .-random_1
	.globl	generate_array
	.type	generate_array, @function
generate_array:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	$8, %esi
	movq	%rax, %rdi
	call	calloc@PLT
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	generate_array, .-generate_array
	.globl	fill
	.type	fill, @function
fill:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-32(%rbp), %rax
	movabsq	$1484674407385880829, %rdx
	imulq	%rdx, %rax
	imulq	$1234567, %rax, %rax
	addq	$42, %rax
	movq	%rax, -16(%rbp)
	movq	$0, -8(%rbp)
	jmp	.L6
.L7:
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	random_1
	movq	%rax, -16(%rbp)
	movq	-8(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movq	-16(%rbp), %rax
	movq	%rax, (%rdx)
	addq	$1, -8(%rbp)
.L6:
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jl	.L7
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	fill, .-fill
	.globl	shuffle_array
	.type	shuffle_array, @function
shuffle_array:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$56, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-48(%rbp), %rax
	subq	$1, %rax
	movq	%rax, -24(%rbp)
	jmp	.L9
.L10:
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	random_1
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	shrq	$33, %rax
	movq	-24(%rbp), %rdx
	addq	$1, %rdx
	movq	%rdx, %rcx
	movl	$0, %edx
	divq	%rcx
	movq	%rdx, %rax
	movq	%rax, -16(%rbp)
	movq	-24(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	movq	-16(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	-24(%rbp), %rdx
	leaq	0(,%rdx,8), %rcx
	movq	-40(%rbp), %rdx
	addq	%rcx, %rdx
	movq	(%rax), %rax
	movq	%rax, (%rdx)
	movq	-16(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	%rax, (%rdx)
	subq	$1, -24(%rbp)
.L9:
	cmpq	$0, -24(%rbp)
	jg	.L10
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	shuffle_array, .-shuffle_array
	.globl	sort_array
	.type	sort_array, @function
sort_array:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$0, -16(%rbp)
	jmp	.L12
.L16:
	movl	-16(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-16(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	jmp	.L13
.L15:
	movl	-12(%rbp), %eax
	cltq
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	-12(%rbp), %edx
	movslq	%edx, %rdx
	leaq	0(,%rdx,8), %rcx
	movq	-24(%rbp), %rdx
	addq	%rcx, %rdx
	movq	(%rax), %rax
	movq	%rax, (%rdx)
	subl	$1, -12(%rbp)
.L13:
	cmpl	$0, -12(%rbp)
	jle	.L14
	movl	-12(%rbp), %eax
	cltq
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	cmpq	%rax, -8(%rbp)
	jb	.L15
.L14:
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	%rax, (%rdx)
	addl	$1, -16(%rbp)
.L12:
	movl	-16(%rbp), %eax
	cltq
	cmpq	%rax, -32(%rbp)
	jg	.L16
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	sort_array, .-sort_array
	.globl	is_sorted_arr
	.type	is_sorted_arr, @function
is_sorted_arr:
.LFB11:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	$0, -8(%rbp)
	jmp	.L18
.L21:
	movq	-8(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rdx
	addq	$1, %rdx
	leaq	0(,%rdx,8), %rcx
	movq	-24(%rbp), %rdx
	addq	%rcx, %rdx
	movq	(%rdx), %rdx
	cmpq	%rax, %rdx
	jnb	.L19
	movl	$0, %eax
	jmp	.L20
.L19:
	addq	$1, -8(%rbp)
.L18:
	movq	-32(%rbp), %rax
	subq	$1, %rax
	cmpq	%rax, -8(%rbp)
	jl	.L21
	movl	$1, %eax
.L20:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	is_sorted_arr, .-is_sorted_arr
	.globl	sum_arr
	.type	sum_arr, @function
sum_arr:
.LFB12:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	$0, -16(%rbp)
	movq	$0, -8(%rbp)
	jmp	.L23
.L24:
	movq	-8(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	addq	%rax, -16(%rbp)
	addq	$1, -8(%rbp)
.L23:
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jl	.L24
	movq	-16(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	sum_arr, .-sum_arr
	.globl	checksum
	.type	checksum, @function
checksum:
.LFB13:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	$0, -16(%rbp)
	movq	$0, -8(%rbp)
	jmp	.L27
.L28:
	movq	-8(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	-8(%rbp), %rdx
	addq	$1, %rdx
	imulq	%rdx, %rax
	addq	%rax, -16(%rbp)
	addq	$1, -8(%rbp)
.L27:
	movq	-8(%rbp), %rax
	cmpq	-32(%rbp), %rax
	jl	.L28
	movq	-16(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	checksum, .-checksum
	.globl	sort_doubles
	.type	sort_doubles, @function
sort_doubles:
.LFB14:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	$1, -16(%rbp)
	jmp	.L31
.L35:
	movl	-16(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm0
	movsd	%xmm0, -8(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.L32
.L34:
	movl	-12(%rbp), %eax
	cltq
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movsd	(%rdx), %xmm0
	movsd	%xmm0, (%rax)
	subl	$1, -12(%rbp)
.L32:
	cmpl	$0, -12(%rbp)
	jle	.L33
	movl	-12(%rbp), %eax
	cltq
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm0
	comisd	-8(%rbp), %xmm0
	ja	.L34
.L33:
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movsd	-8(%rbp), %xmm0
	movsd	%xmm0, (%rax)
	addl	$1, -16(%rbp)
.L31:
	movl	-16(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L35
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	sort_doubles, .-sort_doubles
	.type	parse_arg, @function
parse_arg:
.LFB15:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpq	$0, -40(%rbp)
	jne	.L37
	movq	-48(%rbp), %rax
	jmp	.L39
.L37:
	leaq	-24(%rbp), %rcx
	movq	-40(%rbp), %rax
	movl	$10, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strtol@PLT
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
.L39:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L40
	call	__stack_chk_fail@PLT
.L40:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	parse_arg, .-parse_arg
	.section	.rodata
.LC0:
	.string	"n"
.LC1:
	.string	"repeat"
	.align 8
.LC5:
	.string	"n=%ld repeat=%d median_ms=%.3f min_ms=%.3f max_ms=%.3f checksum=0x%llx\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB16:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movl	%edi, -100(%rbp)
	movq	%rsi, -112(%rbp)
	cmpl	$1, -100(%rbp)
	jle	.L42
	movq	-112(%rbp), %rax
	movq	8(%rax), %rax
	jmp	.L43
.L42:
	movl	$0, %eax
.L43:
	leaq	.LC0(%rip), %rdx
	movl	$20000, %esi
	movq	%rax, %rdi
	call	parse_arg
	movq	%rax, -72(%rbp)
	cmpl	$2, -100(%rbp)
	jle	.L44
	movq	-112(%rbp), %rax
	movq	16(%rax), %rax
	jmp	.L45
.L44:
	movl	$0, %eax
.L45:
	leaq	.LC1(%rip), %rdx
	movl	$15, %esi
	movq	%rax, %rdi
	call	parse_arg
	movl	%eax, -84(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	generate_array
	movq	%rax, -64(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	generate_array
	movq	%rax, -56(%rbp)
	movl	-84(%rbp), %eax
	cltq
	salq	$3, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -48(%rbp)
	movq	-72(%rbp), %rdx
	movq	-64(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fill
	movq	-72(%rbp), %rcx
	movq	-64(%rbp), %rax
	movl	$12345, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	shuffle_array
	movq	-72(%rbp), %rdx
	movq	-64(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	sum_arr
	movq	%rax, -40(%rbp)
	movq	-72(%rbp), %rax
	salq	$3, %rax
	movq	%rax, -32(%rbp)
	movq	$0, -80(%rbp)
	movl	$-1, -88(%rbp)
	jmp	.L46
.L51:
	movq	-32(%rbp), %rdx
	movq	-64(%rbp), %rcx
	movq	-56(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	call	clock@PLT
	movq	%rax, -16(%rbp)
	movq	-72(%rbp), %rdx
	movq	-56(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	sort_array
	call	clock@PLT
	movq	%rax, -8(%rbp)
	movq	-72(%rbp), %rdx
	movq	-56(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	is_sorted_arr
	testl	%eax, %eax
	je	.L47
	movq	-72(%rbp), %rdx
	movq	-56(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	sum_arr
	cmpq	%rax, -40(%rbp)
	je	.L48
.L47:
	movl	$2, %eax
	jmp	.L49
.L48:
	movq	-72(%rbp), %rdx
	movq	-56(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	checksum
	movq	%rax, -80(%rbp)
	cmpl	$0, -88(%rbp)
	js	.L50
	movq	-8(%rbp), %rax
	subq	-16(%rbp), %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC2(%rip), %xmm2
	movapd	%xmm0, %xmm1
	divsd	%xmm2, %xmm1
	movl	-88(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movsd	.LC3(%rip), %xmm0
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, (%rax)
.L50:
	addl	$1, -88(%rbp)
.L46:
	movl	-88(%rbp), %eax
	cmpl	-84(%rbp), %eax
	jl	.L51
	movl	-84(%rbp), %edx
	movq	-48(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	sort_doubles
	movl	-84(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L52
	movl	-84(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm0
	jmp	.L53
.L52:
	movl	-84(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	cltq
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm1
	movl	-84(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm0
	addsd	%xmm1, %xmm0
	movsd	.LC4(%rip), %xmm1
	divsd	%xmm1, %xmm0
.L53:
	movsd	%xmm0, -24(%rbp)
	movl	-84(%rbp), %eax
	cltq
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movsd	(%rax), %xmm1
	movq	-48(%rbp), %rax
	movsd	(%rax), %xmm0
	movq	-80(%rbp), %rcx
	movq	-24(%rbp), %rsi
	movl	-84(%rbp), %edx
	movq	-72(%rbp), %rax
	movapd	%xmm1, %xmm2
	movapd	%xmm0, %xmm1
	movq	%rsi, %xmm0
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$3, %eax
	call	printf@PLT
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movl	$0, %eax
.L49:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	main, .-main
	.section	.rodata
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
	.long	1073741824
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
