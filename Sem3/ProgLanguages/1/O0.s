	.file	"task.c"
	.intel_syntax noprefix
	.text
	.globl	i
	.bss
	.align 4
	.type	i, @object
	.size	i, 4
i:
	.zero	4
	.globl	j
	.align 4
	.type	j, @object
	.size	j, 4
j:
	.zero	4
	.globl	k
	.align 4
	.type	k, @object
	.size	k, 4
k:
	.zero	4
	.globl	l
	.align 4
	.type	l, @object
	.size	l, 4
l:
	.zero	4
	.globl	m
	.align 4
	.type	m, @object
	.size	m, 4
m:
	.zero	4
	.globl	i2
	.align 4
	.type	i2, @object
	.size	i2, 4
i2:
	.zero	4
	.globl	j2
	.align 4
	.type	j2, @object
	.size	j2, 4
j2:
	.zero	4
	.globl	k2
	.align 4
	.type	k2, @object
	.size	k2, 4
k2:
	.zero	4
	.globl	g3
	.align 4
	.type	g3, @object
	.size	g3, 4
g3:
	.zero	4
	.globl	h3
	.align 4
	.type	h3, @object
	.size	h3, 4
h3:
	.zero	4
	.globl	i3
	.align 4
	.type	i3, @object
	.size	i3, 4
i3:
	.zero	4
	.globl	k3
	.align 4
	.type	k3, @object
	.size	k3, 4
k3:
	.zero	4
	.globl	m3
	.align 4
	.type	m3, @object
	.size	m3, 4
m3:
	.zero	4
	.globl	i4
	.align 4
	.type	i4, @object
	.size	i4, 4
i4:
	.zero	4
	.globl	j4
	.align 4
	.type	j4, @object
	.size	j4, 4
j4:
	.zero	4
	.globl	i5
	.align 4
	.type	i5, @object
	.size	i5, 4
i5:
	.zero	4
	.globl	j5
	.align 4
	.type	j5, @object
	.size	j5, 4
j5:
	.zero	4
	.globl	k5
	.align 4
	.type	k5, @object
	.size	k5, 4
k5:
	.zero	4
	.globl	flt_1
	.align 8
	.type	flt_1, @object
	.size	flt_1, 8
flt_1:
	.zero	8
	.globl	flt_2
	.align 8
	.type	flt_2, @object
	.size	flt_2, 8
flt_2:
	.zero	8
	.globl	flt_3
	.align 8
	.type	flt_3, @object
	.size	flt_3, 8
flt_3:
	.zero	8
	.globl	flt_4
	.align 8
	.type	flt_4, @object
	.size	flt_4, 8
flt_4:
	.zero	8
	.globl	flt_5
	.align 8
	.type	flt_5, @object
	.size	flt_5, 8
flt_5:
	.zero	8
	.globl	flt_6
	.align 8
	.type	flt_6, @object
	.size	flt_6, 8
flt_6:
	.zero	8
	.globl	ivector
	.align 8
	.type	ivector, @object
	.size	ivector, 12
ivector:
	.zero	12
	.globl	ivector2
	.type	ivector2, @object
	.size	ivector2, 3
ivector2:
	.zero	3
	.globl	ivector4
	.align 8
	.type	ivector4, @object
	.size	ivector4, 12
ivector4:
	.zero	12
	.globl	ivector5
	.align 32
	.type	ivector5, @object
	.size	ivector5, 400
ivector5:
	.zero	400
	.section	.rodata
	.align 8
.LC4:
	.string	"Common subexpression elimination"
	.align 8
.LC5:
	.string	"This line should not be printed"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	DWORD PTR [rbp-4], edi
	mov	QWORD PTR [rbp-16], rsi
	mov	DWORD PTR j4[rip], 2
	mov	edx, DWORD PTR i2[rip]
	mov	eax, DWORD PTR j4[rip]
	cmp	edx, eax
	jge	.L2
	mov	edx, DWORD PTR i4[rip]
	mov	eax, DWORD PTR j4[rip]
	cmp	edx, eax
	jge	.L2
	mov	DWORD PTR i2[rip], 2
.L2:
	mov	eax, DWORD PTR k5[rip]
	mov	DWORD PTR j4[rip], eax
	mov	edx, DWORD PTR i2[rip]
	mov	eax, DWORD PTR j4[rip]
	cmp	edx, eax
	jge	.L3
	mov	edx, DWORD PTR i4[rip]
	mov	eax, DWORD PTR j4[rip]
	cmp	edx, eax
	jge	.L3
	mov	DWORD PTR i5[rip], 3
.L3:
	mov	DWORD PTR i3[rip], 3
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR flt_1[rip], xmm0
	mov	DWORD PTR i2[rip], 5
	mov	eax, DWORD PTR i[rip]
	mov	DWORD PTR j2[rip], eax
	mov	eax, DWORD PTR i[rip]
	mov	DWORD PTR k2[rip], eax
	mov	eax, DWORD PTR i[rip]
	mov	DWORD PTR i4[rip], eax
	mov	DWORD PTR i5[rip], 0
	mov	eax, DWORD PTR i[rip]
	mov	edi, 0
	cdq
	idiv	edi
	mov	DWORD PTR i2[rip], eax
	movsd	xmm0, QWORD PTR flt_1[rip]
	pxor	xmm1, xmm1
	divsd	xmm0, xmm1
	movsd	QWORD PTR flt_2[rip], xmm0
	movsd	xmm0, QWORD PTR .LC2[rip]
	movsd	QWORD PTR flt_3[rip], xmm0
	movsd	xmm0, QWORD PTR .LC3[rip]
	movsd	QWORD PTR flt_4[rip], xmm0
	movsd	xmm1, QWORD PTR flt_6[rip]
	pxor	xmm0, xmm0
	mulsd	xmm0, xmm1
	movsd	QWORD PTR flt_5[rip], xmm0
	movsd	xmm1, QWORD PTR flt_2[rip]
	movsd	xmm0, QWORD PTR flt_3[rip]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR flt_6[rip], xmm0
	mov	DWORD PTR k3[rip], 1
	mov	DWORD PTR k3[rip], 1
	mov	eax, DWORD PTR j5[rip]
	sal	eax, 2
	mov	DWORD PTR k2[rip], eax
	mov	DWORD PTR i[rip], 0
	jmp	.L4
.L5:
	mov	eax, DWORD PTR i[rip]
	lea	edx, [rax+rax]
	mov	eax, DWORD PTR i[rip]
	cdqe
	mov	WORD PTR ivector4[rax+rax], dx
	mov	eax, DWORD PTR i[rip]
	add	eax, 1
	mov	DWORD PTR i[rip], eax
.L4:
	mov	eax, DWORD PTR i[rip]
	cmp	eax, 5
	jle	.L5
	mov	DWORD PTR j5[rip], 0
	mov	DWORD PTR k5[rip], 10000
.L6:
	mov	eax, DWORD PTR k5[rip]
	sub	eax, 1
	mov	DWORD PTR k5[rip], eax
	mov	eax, DWORD PTR j5[rip]
	add	eax, 1
	mov	DWORD PTR j5[rip], eax
	mov	edx, DWORD PTR k5[rip]
	mov	eax, edx
	add	eax, eax
	lea	ecx, [rax+rdx]
	mov	edx, DWORD PTR j5[rip]
	mov	eax, edx
	sal	eax, 2
	lea	esi, [rdx+rax]
	mov	eax, ecx
	cdq
	idiv	esi
	mov	DWORD PTR i5[rip], eax
	mov	eax, DWORD PTR k5[rip]
	test	eax, eax
	jg	.L6
	mov	DWORD PTR i[rip], 0
	jmp	.L7
.L8:
	mov	eax, DWORD PTR i[rip]
	add	eax, eax
	add	eax, 3
	cdqe
	mov	DWORD PTR ivector5[0+rax*4], 5
	mov	eax, DWORD PTR i[rip]
	add	eax, 1
	mov	DWORD PTR i[rip], eax
.L7:
	mov	eax, DWORD PTR i[rip]
	cmp	eax, 99
	jle	.L8
	mov	eax, DWORD PTR i[rip]
	cmp	eax, 9
	jg	.L9
	mov	edx, DWORD PTR i5[rip]
	mov	eax, DWORD PTR i2[rip]
	add	eax, edx
	mov	DWORD PTR j5[rip], eax
	jmp	.L10
.L9:
	mov	edx, DWORD PTR i5[rip]
	mov	eax, DWORD PTR i2[rip]
	add	eax, edx
	mov	DWORD PTR k5[rip], eax
.L10:
	mov	DWORD PTR ivector[rip], 1
	mov	eax, DWORD PTR i2[rip]
	cdqe
	mov	DWORD PTR ivector[0+rax*4], 2
	mov	eax, DWORD PTR i2[rip]
	cdqe
	mov	DWORD PTR ivector[0+rax*4], 2
	mov	DWORD PTR ivector[rip+8], 3
	mov	edx, DWORD PTR h3[rip]
	mov	eax, DWORD PTR k3[rip]
	add	eax, edx
	test	eax, eax
	js	.L11
	mov	edx, DWORD PTR h3[rip]
	mov	eax, DWORD PTR k3[rip]
	add	eax, edx
	cmp	eax, 5
	jle	.L12
.L11:
	mov	edi, OFFSET FLAT:.LC4
	call	puts
	jmp	.L13
.L12:
	mov	edx, DWORD PTR h3[rip]
	mov	eax, DWORD PTR k3[rip]
	add	eax, edx
	mov	ecx, DWORD PTR i3[rip]
	cdq
	idiv	ecx
	mov	DWORD PTR m3[rip], eax
	mov	edx, DWORD PTR h3[rip]
	mov	eax, DWORD PTR k3[rip]
	add	edx, eax
	mov	eax, DWORD PTR i3[rip]
	add	eax, edx
	mov	DWORD PTR g3[rip], eax
.L13:
	mov	DWORD PTR i4[rip], 0
	jmp	.L14
.L15:
	mov	eax, DWORD PTR j[rip]
	mov	esi, eax
	mov	eax, DWORD PTR k[rip]
	mov	edx, eax
	mov	ecx, DWORD PTR i4[rip]
	mov	eax, esi
	imul	eax, edx
	mov	edx, eax
	movsx	rax, ecx
	mov	BYTE PTR ivector2[rax], dl
	mov	eax, DWORD PTR i4[rip]
	add	eax, 1
	mov	DWORD PTR i4[rip], eax
.L14:
	mov	eax, DWORD PTR i4[rip]
	cmp	eax, 2
	jle	.L15
	mov	esi, OFFSET FLAT:.LC5
	mov	edi, 1
	call	dead_code
	call	unnecessary_loop
	mov	edi, 7
	call	loop_jamming
	mov	edi, 7
	call	loop_unrolling
	mov	r8d, 5
	mov	ecx, 4
	mov	edx, 3
	mov	esi, 2
	mov	edi, 1
	call	jump_compression
	nop
	leave
	ret
	.size	main, .-main
	.globl	dead_code
	.type	dead_code, @function
dead_code:
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR [rbp-20], edi
	mov	QWORD PTR [rbp-32], rsi
	mov	eax, DWORD PTR [rbp-20]
	mov	DWORD PTR [rbp-4], eax
	nop
	pop	rbp
	ret
	.size	dead_code, .-dead_code
	.globl	unnecessary_loop
	.type	unnecessary_loop, @function
unnecessary_loop:
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR [rbp-4], 0
	mov	DWORD PTR i[rip], 0
	jmp	.L18
.L19:
	mov	edx, DWORD PTR j5[rip]
	mov	eax, DWORD PTR [rbp-4]
	add	eax, edx
	mov	DWORD PTR k5[rip], eax
	mov	eax, DWORD PTR i[rip]
	add	eax, 1
	mov	DWORD PTR i[rip], eax
.L18:
	mov	eax, DWORD PTR i[rip]
	cmp	eax, 4
	jle	.L19
	nop
	nop
	pop	rbp
	ret
	.size	unnecessary_loop, .-unnecessary_loop
	.globl	loop_jamming
	.type	loop_jamming, @function
loop_jamming:
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR [rbp-4], edi
	mov	DWORD PTR i[rip], 0
	jmp	.L21
.L22:
	mov	edx, DWORD PTR j5[rip]
	mov	eax, DWORD PTR i[rip]
	imul	edx, eax
	mov	eax, DWORD PTR [rbp-4]
	add	eax, edx
	mov	DWORD PTR k5[rip], eax
	mov	eax, DWORD PTR i[rip]
	add	eax, 1
	mov	DWORD PTR i[rip], eax
.L21:
	mov	eax, DWORD PTR i[rip]
	cmp	eax, 4
	jle	.L22
	mov	DWORD PTR i[rip], 0
	jmp	.L23
.L24:
	mov	eax, DWORD PTR k5[rip]
	imul	eax, DWORD PTR [rbp-4]
	mov	edx, eax
	mov	eax, DWORD PTR i[rip]
	imul	eax, edx
	mov	DWORD PTR i5[rip], eax
	mov	eax, DWORD PTR i[rip]
	add	eax, 1
	mov	DWORD PTR i[rip], eax
.L23:
	mov	eax, DWORD PTR i[rip]
	cmp	eax, 4
	jle	.L24
	nop
	nop
	pop	rbp
	ret
	.size	loop_jamming, .-loop_jamming
	.globl	loop_unrolling
	.type	loop_unrolling, @function
loop_unrolling:
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR [rbp-4], edi
	mov	DWORD PTR i[rip], 0
	jmp	.L26
.L27:
	mov	eax, DWORD PTR i[rip]
	cdqe
	mov	WORD PTR ivector4[rax+rax], 0
	mov	eax, DWORD PTR i[rip]
	add	eax, 1
	mov	DWORD PTR i[rip], eax
.L26:
	mov	eax, DWORD PTR i[rip]
	cmp	eax, 5
	jle	.L27
	nop
	nop
	pop	rbp
	ret
	.size	loop_unrolling, .-loop_unrolling
	.globl	jump_compression
	.type	jump_compression, @function
jump_compression:
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR [rbp-4], edi
	mov	DWORD PTR [rbp-8], esi
	mov	DWORD PTR [rbp-12], edx
	mov	DWORD PTR [rbp-16], ecx
	mov	DWORD PTR [rbp-20], r8d
.L29:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-8]
	jge	.L30
	mov	eax, DWORD PTR [rbp-8]
	cmp	eax, DWORD PTR [rbp-12]
	jge	.L31
	mov	eax, DWORD PTR [rbp-12]
	cmp	eax, DWORD PTR [rbp-16]
	jge	.L32
	mov	eax, DWORD PTR [rbp-16]
	cmp	eax, DWORD PTR [rbp-20]
	jge	.L37
	mov	eax, DWORD PTR [rbp-20]
	add	DWORD PTR [rbp-16], eax
	jmp	.L34
.L32:
	mov	eax, DWORD PTR [rbp-16]
	add	DWORD PTR [rbp-12], eax
	jmp	.L34
.L31:
	mov	eax, DWORD PTR [rbp-12]
	add	DWORD PTR [rbp-8], eax
	jmp	.L29
.L37:
	nop
.L35:
	jmp	.L29
.L30:
	mov	eax, DWORD PTR [rbp-8]
	add	DWORD PTR [rbp-4], eax
.L34:
	mov	edx, DWORD PTR [rbp-4]
	mov	eax, DWORD PTR [rbp-8]
	add	edx, eax
	mov	eax, DWORD PTR [rbp-12]
	add	edx, eax
	mov	eax, DWORD PTR [rbp-16]
	add	edx, eax
	mov	eax, DWORD PTR [rbp-20]
	add	eax, edx
	pop	rbp
	ret
	.size	jump_compression, .-jump_compression
	.section	.rodata
	.align 8
.LC0:
	.long	1717986918
	.long	1075930726
	.align 8
.LC2:
	.long	858993459
	.long	1073951539
	.align 8
.LC3:
	.long	450359963
	.long	1072693248
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
