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
	leaq	-8(,%rsi,8), %rsi
	shrq	$3, %rsi
	addq	$1, %rsi
	andl	$7, %esi
	je	.L6
	cmpq	$1, %rsi
	je	.L29
	cmpq	$2, %rsi
	je	.L30
	cmpq	$3, %rsi
	je	.L31
	cmpq	$4, %rsi
	je	.L32
	cmpq	$5, %rsi
	je	.L33
	cmpq	$6, %rsi
	jne	.L43
.L34:
	imulq	%rdx, %rax
	addq	$8, %rdi
	addq	$1, %rax
	movq	%rax, -8(%rdi)
.L33:
	imulq	%rdx, %rax
	addq	$8, %rdi
	addq	$1, %rax
	movq	%rax, -8(%rdi)
.L32:
	imulq	%rdx, %rax
	addq	$8, %rdi
	addq	$1, %rax
	movq	%rax, -8(%rdi)
.L31:
	imulq	%rdx, %rax
	addq	$8, %rdi
	addq	$1, %rax
	movq	%rax, -8(%rdi)
.L30:
	imulq	%rdx, %rax
	addq	$8, %rdi
	addq	$1, %rax
	movq	%rax, -8(%rdi)
.L29:
	imulq	%rdx, %rax
	addq	$8, %rdi
	addq	$1, %rax
	movq	%rax, -8(%rdi)
	cmpq	%rcx, %rdi
	je	.L44
.L6:
	imulq	%rdx, %rax
	addq	$64, %rdi
	addq	$1, %rax
	movq	%rax, -64(%rdi)
	imulq	%rdx, %rax
	addq	$1, %rax
	movq	%rax, -56(%rdi)
	imulq	%rdx, %rax
	addq	$1, %rax
	movq	%rax, -48(%rdi)
	imulq	%rdx, %rax
	addq	$1, %rax
	movq	%rax, -40(%rdi)
	imulq	%rdx, %rax
	addq	$1, %rax
	movq	%rax, -32(%rdi)
	imulq	%rdx, %rax
	addq	$1, %rax
	movq	%rax, -24(%rdi)
	imulq	%rdx, %rax
	addq	$1, %rax
	movq	%rax, -16(%rdi)
	imulq	%rdx, %rax
	addq	$1, %rax
	movq	%rax, -8(%rdi)
	cmpq	%rcx, %rdi
	jne	.L6
.L4:
	ret
	.p2align 4,,10
	.p2align 3
.L43:
	imulq	%rdx, %rax
	addq	$8, %rdi
	addq	$1, %rax
	movq	%rax, -8(%rdi)
	jmp	.L34
.L44:
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
	jle	.L45
	movabsq	$1484674407385880829, %r8
	leaq	-1(%rsi), %r9
	movq	%r9, %rax
	andl	$3, %eax
	je	.L47
	cmpq	$1, %rax
	je	.L58
	cmpq	$2, %rax
	je	.L59
	imulq	%r8, %rcx
	xorl	%edx, %edx
	movq	-8(%rdi,%rsi,8), %r10
	addq	$1, %rcx
	movq	%rcx, %rax
	shrq	$33, %rax
	divq	%rsi
	leaq	(%rdi,%rdx,8), %r11
	movq	(%r11), %rax
	movq	%rax, -8(%rdi,%rsi,8)
	movq	%r9, %rsi
	movq	%r10, (%r11)
.L59:
	imulq	%r8, %rcx
	xorl	%edx, %edx
	movq	-8(%rdi,%rsi,8), %r9
	addq	$1, %rcx
	movq	%rcx, %rax
	shrq	$33, %rax
	divq	%rsi
	leaq	(%rdi,%rdx,8), %r10
	movq	(%r10), %r11
	movq	%r11, -8(%rdi,%rsi,8)
	subq	$1, %rsi
	movq	%r9, (%r10)
.L58:
	imulq	%r8, %rcx
	xorl	%edx, %edx
	movq	-8(%rdi,%rsi,8), %r9
	addq	$1, %rcx
	movq	%rcx, %rax
	shrq	$33, %rax
	divq	%rsi
	leaq	(%rdi,%rdx,8), %r10
	movq	(%r10), %r11
	movq	%r11, -8(%rdi,%rsi,8)
	subq	$1, %rsi
	movq	%r9, (%r10)
	cmpq	$1, %rsi
	je	.L64
.L47:
	imulq	%r8, %rcx
	xorl	%edx, %edx
	movq	-8(%rdi,%rsi,8), %r9
	addq	$1, %rcx
	movq	%rcx, %rax
	imulq	%r8, %rcx
	shrq	$33, %rax
	divq	%rsi
	addq	$1, %rcx
	movq	%rcx, %rax
	imulq	%r8, %rcx
	shrq	$33, %rax
	addq	$1, %rcx
	leaq	(%rdi,%rdx,8), %r10
	xorl	%edx, %edx
	movq	(%r10), %r11
	movq	%r11, -8(%rdi,%rsi,8)
	movq	%r9, (%r10)
	leaq	-1(%rsi), %r9
	divq	%r9
	movq	-8(%rdi,%r9,8), %r10
	leaq	(%rdi,%rdx,8), %r11
	xorl	%edx, %edx
	movq	(%r11), %rax
	movq	%rax, -8(%rdi,%r9,8)
	movq	%rcx, %rax
	imulq	%r8, %rcx
	leaq	-2(%rsi), %r9
	shrq	$33, %rax
	movq	%r10, (%r11)
	movq	-8(%rdi,%r9,8), %r10
	divq	%r9
	addq	$1, %rcx
	leaq	(%rdi,%rdx,8), %r11
	xorl	%edx, %edx
	movq	(%r11), %rax
	movq	%rax, -8(%rdi,%r9,8)
	movq	%rcx, %rax
	leaq	-3(%rsi), %r9
	subq	$4, %rsi
	shrq	$33, %rax
	movq	%r10, (%r11)
	movq	-8(%rdi,%r9,8), %r10
	divq	%r9
	leaq	(%rdi,%rdx,8), %r11
	movq	(%r11), %rax
	movq	%rax, -8(%rdi,%r9,8)
	movq	%r10, (%r11)
	cmpq	$1, %rsi
	jne	.L47
.L45:
	ret
.L64:
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
	movq	%rdi, %r8
	movq	%rsi, %r9
	testq	%rsi, %rsi
	jle	.L65
	movq	(%rdi), %rcx
	xorl	%esi, %esi
.L68:
	movl	%esi, %eax
	movq	%r8, %rdx
	addl	$1, %esi
	movq	%rdi, %r10
	movq	%rcx, (%rdx)
	addq	$8, %rdi
	cmpl	%r9d, %esi
	je	.L65
.L123:
	salq	$3, %rax
	movq	%rdi, %rdx
	movq	(%rdi), %rcx
	subq	%rax, %r10
	movq	%rdi, %rax
	subq	%r10, %rdx
	subq	$8, %rdx
	shrq	$3, %rdx
	addq	$1, %rdx
	andl	$7, %edx
	je	.L71
	cmpq	$1, %rdx
	je	.L107
	cmpq	$2, %rdx
	je	.L108
	cmpq	$3, %rdx
	je	.L109
	cmpq	$4, %rdx
	je	.L110
	cmpq	$5, %rdx
	je	.L111
	cmpq	$6, %rdx
	je	.L112
	movq	-8(%rdi), %rax
	movq	%rdi, %rdx
	cmpq	%rax, %rcx
	jnb	.L120
	movq	%rax, (%rdi)
	leaq	-8(%rdi), %rax
.L112:
	movq	-8(%rax), %r11
	movq	%rax, %rdx
	cmpq	%r11, %rcx
	jnb	.L120
	movq	%r11, (%rax)
	subq	$8, %rax
.L111:
	movq	-8(%rax), %r11
	movq	%rax, %rdx
	cmpq	%r11, %rcx
	jnb	.L120
	movq	%r11, (%rax)
	subq	$8, %rax
.L110:
	movq	-8(%rax), %r11
	movq	%rax, %rdx
	cmpq	%r11, %rcx
	jnb	.L120
	movq	%r11, (%rax)
	subq	$8, %rax
.L109:
	movq	-8(%rax), %r11
	movq	%rax, %rdx
	cmpq	%r11, %rcx
	jnb	.L120
	movq	%r11, (%rax)
	subq	$8, %rax
.L108:
	movq	-8(%rax), %r11
	movq	%rax, %rdx
	cmpq	%r11, %rcx
	jnb	.L120
	movq	%r11, (%rax)
	subq	$8, %rax
.L107:
	movq	-8(%rax), %r11
	movq	%rax, %rdx
	cmpq	%r11, %rcx
	jnb	.L120
	movq	%r11, (%rax)
	subq	$8, %rax
	cmpq	%r10, %rax
	je	.L68
.L71:
	movq	-8(%rax), %r11
	movq	%rax, %rdx
	cmpq	%r11, %rcx
	jnb	.L120
.L69:
	leaq	-8(%rax), %rdx
	movq	%r11, (%rax)
	movq	-8(%rdx), %r11
	cmpq	%r11, %rcx
	jnb	.L120
	leaq	-16(%rax), %rdx
	movq	%r11, -8(%rax)
	movq	-8(%rdx), %r11
	cmpq	%r11, %rcx
	jnb	.L120
	leaq	-24(%rax), %rdx
	movq	%r11, -16(%rax)
	movq	-8(%rdx), %r11
	cmpq	%r11, %rcx
	jnb	.L120
	leaq	-32(%rax), %rdx
	movq	%r11, -24(%rax)
	movq	-8(%rdx), %r11
	cmpq	%r11, %rcx
	jnb	.L120
	leaq	-40(%rax), %rdx
	movq	%r11, -32(%rax)
	movq	-8(%rdx), %r11
	cmpq	%r11, %rcx
	jnb	.L120
	leaq	-48(%rax), %rdx
	movq	%r11, -40(%rax)
	movq	-8(%rdx), %r11
	cmpq	%r11, %rcx
	jnb	.L120
	leaq	-56(%rax), %rdx
	movq	%r11, -48(%rax)
	movq	-8(%rdx), %r11
	cmpq	%r11, %rcx
	jnb	.L120
	movq	%r11, -56(%rax)
	subq	$64, %rax
	cmpq	%r10, %rax
	je	.L68
	movq	-8(%rax), %r11
	movq	%rax, %rdx
	cmpq	%r11, %rcx
	jb	.L69
	.p2align 4,,10
	.p2align 3
.L120:
	movl	%esi, %eax
	addl	$1, %esi
	movq	%rdi, %r10
	movq	%rcx, (%rdx)
	addq	$8, %rdi
	cmpl	%r9d, %esi
	jne	.L123
.L65:
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
	movq	%rdi, %rdx
	cmpq	$1, %rsi
	jle	.L127
	movq	(%rdi), %rcx
	leaq	-1(%rsi), %rdi
	xorl	%r8d, %r8d
	movq	%rdi, %rsi
	andl	$7, %esi
	je	.L126
	cmpq	$1, %rsi
	je	.L151
	cmpq	$2, %rsi
	je	.L152
	cmpq	$3, %rsi
	je	.L153
	cmpq	$4, %rsi
	je	.L154
	cmpq	$5, %rsi
	je	.L155
	cmpq	$6, %rsi
	jne	.L167
.L156:
	movq	%rcx, %r9
	movq	8(%rdx,%r8,8), %rcx
	cmpq	%r9, %rcx
	jb	.L128
	addq	$1, %r8
.L155:
	movq	%rcx, %r10
	movq	8(%rdx,%r8,8), %rcx
	cmpq	%r10, %rcx
	jb	.L128
	addq	$1, %r8
.L154:
	movq	%rcx, %r11
	movq	8(%rdx,%r8,8), %rcx
	cmpq	%r11, %rcx
	jb	.L128
	addq	$1, %r8
.L153:
	movq	%rcx, %rsi
	movq	8(%rdx,%r8,8), %rcx
	cmpq	%rsi, %rcx
	jb	.L128
	addq	$1, %r8
.L152:
	movq	%rcx, %rax
	movq	8(%rdx,%r8,8), %rcx
	cmpq	%rax, %rcx
	jb	.L128
	addq	$1, %r8
.L151:
	movq	%rcx, %r9
	movq	8(%rdx,%r8,8), %rcx
	cmpq	%r9, %rcx
	jb	.L128
	addq	$1, %r8
	cmpq	%r8, %rdi
	je	.L127
.L126:
	movq	8(%rdx,%r8,8), %r10
	cmpq	%rcx, %r10
	jb	.L128
	movq	16(%rdx,%r8,8), %rcx
	cmpq	%r10, %rcx
	jb	.L128
	movq	24(%rdx,%r8,8), %r11
	cmpq	%rcx, %r11
	jb	.L128
	movq	32(%rdx,%r8,8), %rax
	cmpq	%r11, %rax
	jb	.L128
	movq	40(%rdx,%r8,8), %rsi
	cmpq	%rax, %rsi
	jb	.L128
	movq	48(%rdx,%r8,8), %r9
	cmpq	%rsi, %r9
	jb	.L128
	movq	56(%rdx,%r8,8), %r10
	cmpq	%r9, %r10
	jb	.L128
	movq	64(%rdx,%r8,8), %rcx
	cmpq	%r10, %rcx
	jb	.L128
	addq	$8, %r8
	cmpq	%r8, %rdi
	jne	.L126
.L127:
	movl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L128:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L167:
	movq	%rcx, %rax
	movq	8(%rdx), %rcx
	cmpq	%rax, %rcx
	jb	.L128
	movl	$1, %r8d
	jmp	.L156
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
	jle	.L171
	leaq	-8(,%rsi,8), %rdx
	leaq	(%rdi,%rsi,8), %rcx
	xorl	%eax, %eax
	shrq	$3, %rdx
	addq	$1, %rdx
	andl	$7, %edx
	je	.L170
	cmpq	$1, %rdx
	je	.L194
	cmpq	$2, %rdx
	je	.L195
	cmpq	$3, %rdx
	je	.L196
	cmpq	$4, %rdx
	je	.L197
	cmpq	$5, %rdx
	je	.L198
	cmpq	$6, %rdx
	jne	.L208
.L199:
	addq	(%rdi), %rax
	addq	$8, %rdi
.L198:
	addq	(%rdi), %rax
	addq	$8, %rdi
.L197:
	addq	(%rdi), %rax
	addq	$8, %rdi
.L196:
	addq	(%rdi), %rax
	addq	$8, %rdi
.L195:
	addq	(%rdi), %rax
	addq	$8, %rdi
.L194:
	addq	(%rdi), %rax
	addq	$8, %rdi
	cmpq	%rcx, %rdi
	je	.L209
.L170:
	addq	(%rdi), %rax
	addq	$64, %rdi
	addq	-56(%rdi), %rax
	addq	-48(%rdi), %rax
	addq	-40(%rdi), %rax
	addq	-32(%rdi), %rax
	addq	-24(%rdi), %rax
	addq	-16(%rdi), %rax
	addq	-8(%rdi), %rax
	cmpq	%rcx, %rdi
	jne	.L170
	ret
	.p2align 4,,10
	.p2align 3
.L208:
	movq	(%rdi), %rax
	addq	$8, %rdi
	jmp	.L199
.L209:
	ret
	.p2align 4,,10
	.p2align 3
.L171:
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
	movq	%rdi, %rcx
	movq	%rsi, %rdi
	testq	%rsi, %rsi
	jle	.L213
	movq	%rdi, %rdx
	xorl	%eax, %eax
	xorl	%esi, %esi
	andl	$7, %edx
	je	.L212
	cmpq	$1, %rdx
	je	.L236
	cmpq	$2, %rdx
	je	.L237
	cmpq	$3, %rdx
	je	.L238
	cmpq	$4, %rdx
	je	.L239
	cmpq	$5, %rdx
	je	.L240
	cmpq	$6, %rdx
	jne	.L250
.L241:
	movq	(%rcx,%rax,8), %r8
	addq	$1, %rax
	imulq	%rax, %r8
	addq	%r8, %rsi
.L240:
	movq	(%rcx,%rax,8), %r9
	addq	$1, %rax
	imulq	%rax, %r9
	addq	%r9, %rsi
.L239:
	movq	(%rcx,%rax,8), %r10
	addq	$1, %rax
	imulq	%rax, %r10
	addq	%r10, %rsi
.L238:
	movq	(%rcx,%rax,8), %r11
	addq	$1, %rax
	imulq	%rax, %r11
	addq	%r11, %rsi
.L237:
	movq	(%rcx,%rax,8), %rdx
	addq	$1, %rax
	imulq	%rax, %rdx
	addq	%rdx, %rsi
.L236:
	movq	(%rcx,%rax,8), %r8
	addq	$1, %rax
	imulq	%rax, %r8
	addq	%r8, %rsi
	cmpq	%rdi, %rax
	je	.L210
.L212:
	movq	(%rcx,%rax,8), %rdx
	leaq	1(%rax), %r9
	leaq	2(%rax), %r10
	leaq	3(%rax), %r11
	movq	(%rcx,%r10,8), %r8
	imulq	%r9, %rdx
	imulq	%r11, %r8
	addq	%rsi, %rdx
	movq	(%rcx,%r9,8), %rsi
	leaq	4(%rax), %r9
	imulq	%r10, %rsi
	leaq	5(%rax), %r10
	addq	%rsi, %rdx
	movq	(%rcx,%r11,8), %rsi
	leaq	6(%rax), %r11
	addq	%r8, %rdx
	movq	(%rcx,%r9,8), %r8
	imulq	%r9, %rsi
	leaq	7(%rax), %r9
	addq	$8, %rax
	imulq	%r10, %r8
	addq	%rsi, %rdx
	movq	(%rcx,%r10,8), %rsi
	addq	%r8, %rdx
	movq	(%rcx,%r11,8), %r8
	imulq	%r11, %rsi
	imulq	%r9, %r8
	addq	%rsi, %rdx
	movq	(%rcx,%r9,8), %rsi
	addq	%r8, %rdx
	imulq	%rax, %rsi
	addq	%rdx, %rsi
	cmpq	%rdi, %rax
	jne	.L212
.L210:
	movq	%rsi, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L250:
	movq	(%rcx), %rsi
	movl	$1, %eax
	jmp	.L241
	.p2align 4,,10
	.p2align 3
.L213:
	xorl	%esi, %esi
	movq	%rsi, %rax
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
	movl	%esi, %r8d
	leaq	8(%rdi), %rcx
	movl	$1, %esi
	cmpl	$1, %r8d
	jle	.L251
	.p2align 4,,10
	.p2align 3
.L256:
	movq	%rcx, %rdx
	movsd	(%rcx), %xmm0
	movq	%rcx, %rax
	subq	%rdi, %rdx
	subq	$8, %rdx
	shrq	$3, %rdx
	addq	$1, %rdx
	andl	$7, %edx
	je	.L253
	cmpq	$1, %rdx
	je	.L295
	cmpq	$2, %rdx
	je	.L296
	cmpq	$3, %rdx
	je	.L297
	cmpq	$4, %rdx
	je	.L298
	cmpq	$5, %rdx
	je	.L299
	cmpq	$6, %rdx
	je	.L300
	movsd	-8(%rcx), %xmm1
	movq	%rcx, %r9
	comisd	%xmm0, %xmm1
	jbe	.L254
	movsd	%xmm1, (%rcx)
	leaq	-8(%rcx), %rax
.L300:
	movsd	-8(%rax), %xmm2
	movq	%rax, %r9
	comisd	%xmm0, %xmm2
	jbe	.L254
	movsd	%xmm2, (%rax)
	subq	$8, %rax
.L299:
	movsd	-8(%rax), %xmm3
	movq	%rax, %r9
	comisd	%xmm0, %xmm3
	jbe	.L254
	movsd	%xmm3, (%rax)
	subq	$8, %rax
.L298:
	movsd	-8(%rax), %xmm4
	movq	%rax, %r9
	comisd	%xmm0, %xmm4
	jbe	.L254
	movsd	%xmm4, (%rax)
	subq	$8, %rax
.L297:
	movsd	-8(%rax), %xmm5
	movq	%rax, %r9
	comisd	%xmm0, %xmm5
	jbe	.L254
	movsd	%xmm5, (%rax)
	subq	$8, %rax
.L296:
	movsd	-8(%rax), %xmm6
	movq	%rax, %r9
	comisd	%xmm0, %xmm6
	jbe	.L254
	movsd	%xmm6, (%rax)
	subq	$8, %rax
.L295:
	movsd	-8(%rax), %xmm7
	movq	%rax, %r9
	comisd	%xmm0, %xmm7
	jbe	.L254
	movsd	%xmm7, (%rax)
	subq	$8, %rax
	cmpq	%rax, %rdi
	je	.L258
.L253:
	movsd	-8(%rax), %xmm8
	movq	%rax, %r9
	comisd	%xmm0, %xmm8
	jbe	.L254
	leaq	-8(%rax), %r9
	movsd	%xmm8, (%rax)
	movsd	-8(%r9), %xmm9
	comisd	%xmm0, %xmm9
	jbe	.L254
	leaq	-16(%rax), %r9
	movsd	%xmm9, -8(%rax)
	movsd	-8(%r9), %xmm10
	comisd	%xmm0, %xmm10
	jbe	.L254
	leaq	-24(%rax), %r9
	movsd	%xmm10, -16(%rax)
	movsd	-8(%r9), %xmm11
	comisd	%xmm0, %xmm11
	jbe	.L254
	leaq	-32(%rax), %r9
	movsd	%xmm11, -24(%rax)
	movsd	-8(%r9), %xmm12
	comisd	%xmm0, %xmm12
	jbe	.L254
	leaq	-40(%rax), %r9
	movsd	%xmm12, -32(%rax)
	movsd	-8(%r9), %xmm13
	comisd	%xmm0, %xmm13
	jbe	.L254
	leaq	-48(%rax), %r9
	movsd	%xmm13, -40(%rax)
	movsd	-8(%r9), %xmm14
	comisd	%xmm0, %xmm14
	jbe	.L254
	leaq	-56(%rax), %r9
	movsd	%xmm14, -48(%rax)
	movsd	-8(%r9), %xmm15
	comisd	%xmm0, %xmm15
	jbe	.L254
	movsd	%xmm15, -56(%rax)
	subq	$64, %rax
	cmpq	%rax, %rdi
	jne	.L253
.L258:
	movq	%rdi, %r9
.L254:
	addl	$1, %esi
	movsd	%xmm0, (%r9)
	addq	$8, %rcx
	cmpl	%esi, %r8d
	jne	.L256
.L251:
	ret
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
	jle	.L310
	movl	%edi, %ebx
	movq	8(%rsi), %rdi
	movq	%rsi, %rbp
	testq	%rdi, %rdi
	je	.L332
	leaq	64(%rsp), %rsi
	movl	$10, %edx
	call	strtol@PLT
	movq	%rax, %r15
.L311:
	cmpl	$2, %ebx
	je	.L312
	movq	16(%rbp), %rdi
	testq	%rdi, %rdi
	je	.L312
	movl	$10, %edx
	leaq	64(%rsp), %rsi
	movq	%r15, %rbp
	call	strtol@PLT
	movl	$8, %esi
	movq	%r15, %rdi
	movq	%rax, %r13
	movq	%rax, 48(%rsp)
	movl	%eax, 44(%rsp)
	call	calloc@PLT
	leaq	0(,%r15,8), %rdx
	movl	$8, %esi
	movq	%r15, %rdi
	movq	%rdx, (%rsp)
	movq	%rax, %r12
	movq	%rax, 8(%rsp)
	call	calloc@PLT
	movslq	%r13d, %rdi
	salq	$3, %rdi
	movq	%rax, %rbx
	movq	%rdi, 56(%rsp)
	call	malloc@PLT
	movq	%r15, %rsi
	movq	%r12, %rdi
	movq	%rax, 32(%rsp)
	call	fill
	movl	$12345, %edx
	movq	%r15, %rsi
	movq	%r12, %rdi
	call	shuffle_array
	testq	%r15, %r15
	jle	.L505
.L329:
	movq	(%rsp), %r8
	movq	8(%rsp), %rsi
	xorl	%edx, %edx
	leaq	-8(%r8), %r10
	movq	%rsi, %r11
	leaq	(%rsi,%r8), %r9
	shrq	$3, %r10
	addq	$1, %r10
	andl	$7, %r10d
	je	.L314
	cmpq	$1, %r10
	je	.L432
	cmpq	$2, %r10
	je	.L433
	cmpq	$3, %r10
	je	.L434
	cmpq	$4, %r10
	je	.L435
	cmpq	$5, %r10
	je	.L436
	cmpq	$6, %r10
	jne	.L506
.L437:
	addq	(%r11), %rdx
	addq	$8, %r11
.L436:
	addq	(%r11), %rdx
	addq	$8, %r11
.L435:
	addq	(%r11), %rdx
	addq	$8, %r11
.L434:
	addq	(%r11), %rdx
	addq	$8, %r11
.L433:
	addq	(%r11), %rdx
	addq	$8, %r11
.L432:
	addq	(%r11), %rdx
	addq	$8, %r11
	cmpq	%r9, %r11
	je	.L313
.L314:
	addq	(%r11), %rdx
	addq	$64, %r11
	addq	-56(%r11), %rdx
	addq	-48(%r11), %rdx
	addq	-40(%r11), %rdx
	addq	-32(%r11), %rdx
	addq	-24(%r11), %rdx
	addq	-16(%r11), %rdx
	addq	-8(%r11), %rdx
	cmpq	%r9, %r11
	jne	.L314
.L313:
	movl	44(%rsp), %r13d
	testl	%r13d, %r13d
	js	.L334
.L330:
	movl	48(%rsp), %eax
	movq	(%rsp), %r12
	movq	%rdx, 16(%rsp)
	movq	$-1, %rcx
	leaq	-1(%rbp), %r14
	movq	%rax, 24(%rsp)
	leaq	(%rbx,%r12), %rdi
	movq	%rbx, %r12
	movq	%rcx, %rbx
	movq	%rdi, %r13
	.p2align 4,,10
	.p2align 3
.L326:
	movq	(%rsp), %rcx
	movq	8(%rsp), %rsi
	movq	%r12, %rdi
	movq	%rcx, %rdx
	call	__memcpy_chk@PLT
	call	clock@PLT
	movq	%r15, %rsi
	movq	%r12, %rdi
	movq	%rax, %rbp
	call	sort_array
	call	clock@PLT
	movq	%rax, %r9
	cmpq	$1, %r15
	jle	.L316
	movq	%r14, %rsi
	movq	(%r12), %rdx
	xorl	%r10d, %r10d
	andl	$7, %esi
	je	.L318
	cmpq	$1, %rsi
	je	.L438
	cmpq	$2, %rsi
	je	.L439
	cmpq	$3, %rsi
	je	.L440
	cmpq	$4, %rsi
	je	.L441
	cmpq	$5, %rsi
	je	.L442
	cmpq	$6, %rsi
	je	.L443
	movq	%rdx, %r8
	movq	8(%r12), %rdx
	cmpq	%r8, %rdx
	jb	.L337
	movl	$1, %r10d
.L443:
	movq	%rdx, %r11
	movq	8(%r12,%r10,8), %rdx
	cmpq	%r11, %rdx
	jb	.L337
	addq	$1, %r10
.L442:
	movq	%rdx, %rax
	movq	8(%r12,%r10,8), %rdx
	cmpq	%rax, %rdx
	jb	.L337
	addq	$1, %r10
.L441:
	movq	%rdx, %rdi
	movq	8(%r12,%r10,8), %rdx
	cmpq	%rdi, %rdx
	jb	.L337
	addq	$1, %r10
.L440:
	movq	%rdx, %rcx
	movq	8(%r12,%r10,8), %rdx
	cmpq	%rcx, %rdx
	jb	.L337
	addq	$1, %r10
.L439:
	movq	%rdx, %rsi
	movq	8(%r12,%r10,8), %rdx
	cmpq	%rsi, %rdx
	jb	.L337
	addq	$1, %r10
.L438:
	movq	%rdx, %r8
	movq	8(%r12,%r10,8), %rdx
	cmpq	%r8, %rdx
	jb	.L337
	addq	$1, %r10
	cmpq	%r10, %r14
	je	.L504
.L318:
	movq	8(%r12,%r10,8), %r11
	cmpq	%rdx, %r11
	jb	.L337
	movq	16(%r12,%r10,8), %rdx
	cmpq	%r11, %rdx
	jb	.L337
	movq	24(%r12,%r10,8), %rax
	cmpq	%rdx, %rax
	jb	.L337
	movq	32(%r12,%r10,8), %rdi
	cmpq	%rax, %rdi
	jb	.L337
	movq	40(%r12,%r10,8), %rcx
	cmpq	%rdi, %rcx
	jb	.L337
	movq	48(%r12,%r10,8), %r8
	cmpq	%rcx, %r8
	jb	.L337
	movq	56(%r12,%r10,8), %rsi
	cmpq	%r8, %rsi
	jb	.L337
	movq	64(%r12,%r10,8), %rdx
	cmpq	%rsi, %rdx
	jb	.L337
	addq	$8, %r10
	cmpq	%r10, %r14
	jne	.L318
	.p2align 4,,10
	.p2align 3
.L504:
	movq	%r13, %r10
	movq	%r12, %rax
	xorl	%r11d, %r11d
	subq	%r12, %r10
	subq	$8, %r10
	shrq	$3, %r10
	addq	$1, %r10
	andl	$7, %r10d
	je	.L321
	cmpq	$1, %r10
	je	.L444
	cmpq	$2, %r10
	je	.L445
	cmpq	$3, %r10
	je	.L446
	cmpq	$4, %r10
	je	.L447
	cmpq	$5, %r10
	je	.L448
	cmpq	$6, %r10
	je	.L449
	movq	(%r12), %r11
	leaq	8(%r12), %rax
.L449:
	addq	(%rax), %r11
	addq	$8, %rax
.L448:
	addq	(%rax), %r11
	addq	$8, %rax
.L447:
	addq	(%rax), %r11
	addq	$8, %rax
.L446:
	addq	(%rax), %r11
	addq	$8, %rax
.L445:
	addq	(%rax), %r11
	addq	$8, %rax
.L444:
	addq	(%rax), %r11
	addq	$8, %rax
	movq	%r11, %rdi
	cmpq	%r13, %rax
	je	.L493
.L321:
	movq	8(%rax), %rdi
	addq	(%rax), %r11
	addq	$64, %rax
	addq	%r11, %rdi
	addq	-48(%rax), %rdi
	addq	-40(%rax), %rdi
	addq	-32(%rax), %rdi
	addq	-24(%rax), %rdi
	addq	-16(%rax), %rdi
	addq	-8(%rax), %rdi
	movq	%rdi, %r11
	cmpq	%r13, %rax
	jne	.L321
.L493:
	movq	16(%rsp), %rcx
	cmpq	%rcx, %rdi
	jne	.L337
	movq	%r15, %rsi
	xorl	%r8d, %r8d
	xorl	%r10d, %r10d
	andl	$7, %esi
	je	.L324
	cmpq	$1, %rsi
	je	.L450
	cmpq	$2, %rsi
	je	.L451
	cmpq	$3, %rsi
	je	.L452
	cmpq	$4, %rsi
	je	.L453
	cmpq	$5, %rsi
	je	.L454
	cmpq	$6, %rsi
	je	.L455
	movq	(%r12), %r8
	movl	$1, %r10d
.L455:
	movq	(%r12,%r10,8), %rdx
	addq	$1, %r10
	imulq	%r10, %rdx
	addq	%rdx, %r8
.L454:
	movq	(%r12,%r10,8), %r11
	addq	$1, %r10
	imulq	%r10, %r11
	addq	%r11, %r8
.L453:
	movq	(%r12,%r10,8), %rax
	addq	$1, %r10
	imulq	%r10, %rax
	addq	%rax, %r8
.L452:
	movq	(%r12,%r10,8), %rdi
	addq	$1, %r10
	imulq	%r10, %rdi
	addq	%rdi, %r8
.L451:
	movq	(%r12,%r10,8), %rcx
	addq	$1, %r10
	imulq	%r10, %rcx
	addq	%rcx, %r8
.L450:
	movq	(%r12,%r10,8), %rsi
	addq	$1, %r10
	imulq	%r10, %rsi
	addq	%rsi, %r8
	cmpq	%r15, %r10
	je	.L323
.L324:
	movq	(%r12,%r10,8), %r11
	leaq	1(%r10), %rdx
	leaq	2(%r10), %rax
	leaq	3(%r10), %rcx
	movq	(%r12,%rax,8), %rsi
	imulq	%rdx, %r11
	movq	(%r12,%rdx,8), %rdx
	imulq	%rcx, %rsi
	imulq	%rax, %rdx
	leaq	5(%r10), %rax
	addq	%r11, %r8
	leaq	4(%r10), %r11
	addq	%rdx, %r8
	movq	(%r12,%rcx,8), %rdx
	leaq	6(%r10), %rcx
	addq	%rsi, %r8
	movq	(%r12,%r11,8), %rsi
	imulq	%r11, %rdx
	leaq	7(%r10), %r11
	addq	$8, %r10
	imulq	%rax, %rsi
	addq	%rdx, %r8
	movq	(%r12,%rax,8), %rdx
	addq	%rsi, %r8
	movq	(%r12,%rcx,8), %rsi
	imulq	%rcx, %rdx
	imulq	%r11, %rsi
	addq	%rdx, %r8
	movq	(%r12,%r11,8), %rdx
	addq	%rsi, %r8
	imulq	%r10, %rdx
	addq	%rdx, %r8
	cmpq	%r15, %r10
	jne	.L324
.L323:
	cmpl	$-1, %ebx
	je	.L325
	subq	%rbp, %r9
	pxor	%xmm0, %xmm0
	movq	32(%rsp), %rbp
	cvtsi2sdq	%r9, %xmm0
	divsd	.LC0(%rip), %xmm0
	mulsd	.LC1(%rip), %xmm0
	movsd	%xmm0, 0(%rbp,%rbx,8)
.L325:
	movq	24(%rsp), %r9
	addq	$1, %rbx
	cmpq	%r9, %rbx
	jne	.L326
	movq	%r12, %rbx
.L315:
	movl	44(%rsp), %r14d
	movq	32(%rsp), %rdi
	movq	%r8, (%rsp)
	movl	$2, %r13d
	movl	%r14d, %esi
	call	sort_doubles
	movl	%r14d, %eax
	movq	(%rsp), %r8
	cltd
	idivl	%r13d
	cltq
	salq	$3, %rax
	testb	$1, 48(%rsp)
	leaq	(%rdi,%rax), %r12
	jne	.L507
	movq	32(%rsp), %r10
	movsd	-8(%r10,%rax), %xmm0
	addsd	(%r12), %xmm0
	mulsd	.LC2(%rip), %xmm0
.L328:
	movq	32(%rsp), %rbp
	movq	56(%rsp), %rcx
	movq	%r15, %rdx
	leaq	.LC3(%rip), %rsi
	movl	$2, %edi
	movl	$3, %eax
	movsd	-8(%rbp,%rcx), %xmm2
	movsd	0(%rbp), %xmm1
	movl	44(%rsp), %ecx
	call	__printf_chk@PLT
	movq	%rbp, %rdi
	call	free@PLT
	movq	%rbx, %rdi
	call	free@PLT
	movq	8(%rsp), %rdi
	call	free@PLT
	xorl	%eax, %eax
	jmp	.L309
	.p2align 4,,10
	.p2align 3
.L337:
	movl	$2, %eax
.L309:
	movq	72(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L508
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
.L316:
	.cfi_restore_state
	je	.L504
	cmpq	$0, 16(%rsp)
	jne	.L337
	xorl	%r8d, %r8d
	jmp	.L323
.L310:
	movl	$8, %esi
	movl	$20000, %edi
	movl	$20000, %r15d
	movl	$20000, %ebp
	call	calloc@PLT
	movl	$8, %esi
	movl	$20000, %edi
	movq	%rax, %r14
	movq	%rax, 8(%rsp)
	call	calloc@PLT
	movl	$120, %edi
	movq	%rax, %rbx
	call	malloc@PLT
	movl	$20000, %esi
	movq	%r14, %rdi
	movq	%rax, 32(%rsp)
	call	fill
	movl	$12345, %edx
	movl	$20000, %esi
	movq	%r14, %rdi
	call	shuffle_array
	movq	$160000, (%rsp)
	movq	$15, 48(%rsp)
	movl	$15, 44(%rsp)
	movq	$120, 56(%rsp)
	jmp	.L329
.L332:
	movl	$20000, %r15d
	jmp	.L311
.L507:
	movsd	(%r12), %xmm0
	jmp	.L328
.L506:
	movq	8(%rsp), %r11
	movq	(%r11), %rdx
	addq	$8, %r11
	jmp	.L437
.L312:
	movl	$8, %esi
	movq	%r15, %rdi
	movq	%r15, %rbp
	call	calloc@PLT
	leaq	0(,%r15,8), %rcx
	movl	$8, %esi
	movq	%r15, %rdi
	movq	%rcx, (%rsp)
	movq	%rax, %r14
	movq	%rax, 8(%rsp)
	call	calloc@PLT
	movl	$120, %edi
	movq	%rax, %rbx
	call	malloc@PLT
	movq	%r15, %rsi
	movq	%r14, %rdi
	movq	%rax, 32(%rsp)
	call	fill
	movl	$12345, %edx
	movq	%r15, %rsi
	movq	%r14, %rdi
	call	shuffle_array
	testq	%r15, %r15
	jle	.L509
	movq	$15, 48(%rsp)
	movl	$15, 44(%rsp)
	movq	$120, 56(%rsp)
	jmp	.L329
.L505:
	xorl	%edx, %edx
	jmp	.L313
.L334:
	xorl	%r8d, %r8d
	jmp	.L315
.L509:
	movq	$15, 48(%rsp)
	xorl	%edx, %edx
	movl	$15, 44(%rsp)
	movq	$120, 56(%rsp)
	jmp	.L330
.L508:
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
