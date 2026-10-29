	.file	"task.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	dead_code
	.type	dead_code, @function
dead_code:
	ret
	.size	dead_code, .-dead_code
	.p2align 4
	.globl	unnecessary_loop
	.type	unnecessary_loop, @function
unnecessary_loop:
	mov	DWORD PTR i[rip], 5
	mov	eax, DWORD PTR j5[rip]
	mov	DWORD PTR k5[rip], eax
	ret
	.size	unnecessary_loop, .-unnecessary_loop
	.p2align 4
	.globl	loop_jamming
	.type	loop_jamming, @function
loop_jamming:
	mov	DWORD PTR i[rip], 5
	mov	eax, DWORD PTR j5[rip]
	lea	eax, [rdi+rax*4]
	mov	DWORD PTR k5[rip], eax
	imul	eax, edi
	sal	eax, 2
	mov	DWORD PTR i5[rip], eax
	ret
	.size	loop_jamming, .-loop_jamming
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC6:
	.string	"Common subexpression elimination"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
	sub	rsp, 8
	pxor	xmm1, xmm1
	mov	eax, DWORD PTR k5[rip]
	xor	ecx, ecx
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	xmm2, QWORD PTR .LC2[rip]
	mov	DWORD PTR i3[rip], 3
	mov	DWORD PTR j4[rip], eax
	mov	eax, DWORD PTR i[rip]
	movsd	QWORD PTR flt_1[rip], xmm0
	divsd	xmm0, xmm1
	mov	esi, DWORD PTR j5[rip]
	mov	rdi, QWORD PTR .LC3[rip]
	mov	DWORD PTR j2[rip], eax
	cdq
	mov	DWORD PTR i4[rip], eax
	mulsd	xmm1, QWORD PTR flt_6[rip]
	idiv	ecx
	mov	QWORD PTR flt_4[rip], rdi
	mov	DWORD PTR k3[rip], 1
	mov	DWORD PTR ivector4[rip+8], 655368
	mov	DWORD PTR j5[rip], 10000
	mov	DWORD PTR i5[rip], 0
	movsd	QWORD PTR flt_3[rip], xmm2
	movsd	QWORD PTR flt_5[rip], xmm1
	lea	edx, [0+rsi*4]
	mov	ecx, OFFSET FLAT:ivector5+812
	mov	DWORD PTR k2[rip], edx
	mov	rdx, QWORD PTR .LC4[rip]
	mov	QWORD PTR ivector4[rip], rdx
	mov	edx, OFFSET FLAT:ivector5+12
	mov	DWORD PTR i2[rip], eax
	movsd	QWORD PTR flt_2[rip], xmm0
	mulsd	xmm0, xmm2
	movsd	QWORD PTR flt_6[rip], xmm0
.L6:
	mov	DWORD PTR [rdx], 5
	add	rdx, 16
	mov	DWORD PTR [rdx-8], 5
	cmp	rcx, rdx
	jne	.L6
	mov	ecx, DWORD PTR h3[rip]
	mov	DWORD PTR k5[rip], eax
	cdqe
	mov	DWORD PTR ivector[rip], 1
	mov	DWORD PTR i[rip], 100
	lea	edx, [rcx+1]
	mov	DWORD PTR ivector[0+rax*4], 2
	mov	DWORD PTR ivector[rip+8], 3
	cmp	edx, 5
	ja	.L12
	movsx	rax, edx
	sar	edx, 31
	add	ecx, 4
	mov	esi, 10000
	imul	rax, rax, 1431655766
	mov	DWORD PTR g3[rip], ecx
	shr	rax, 32
	sub	eax, edx
	mov	DWORD PTR m3[rip], eax
.L8:
	movzx	eax, BYTE PTR j[rip]
	mul	BYTE PTR k[rip]
	mov	edi, 7
	mov	DWORD PTR i4[rip], 3
	mov	DWORD PTR k5[rip], esi
	mov	DWORD PTR i[rip], 5
	mov	edx, eax
	movzx	ecx, al
	mov	BYTE PTR ivector2[rip+2], al
	sal	edx, 8
	add	edx, ecx
	mov	WORD PTR ivector2[rip], dx
	call	loop_jamming
	mov	QWORD PTR ivector4[rip], 0
	mov	DWORD PTR ivector4[rip+8], 0
	mov	DWORD PTR i[rip], 6
	add	rsp, 8
	ret
.L12:
	mov	edi, OFFSET FLAT:.LC6
	call	puts
	mov	esi, DWORD PTR j5[rip]
	jmp	.L8
	.size	main, .-main
	.text
	.p2align 4
	.globl	loop_unrolling
	.type	loop_unrolling, @function
loop_unrolling:
	mov	QWORD PTR ivector4[rip], 0
	mov	DWORD PTR ivector4[rip+8], 0
	mov	DWORD PTR i[rip], 6
	ret
	.size	loop_unrolling, .-loop_unrolling
	.p2align 4
	.globl	jump_compression
	.type	jump_compression, @function
jump_compression:
	cmp	esi, edi
	jle	.L15
	cmp	edx, ecx
	jge	.L16
	cmp	ecx, r8d
	jl	.L17
.L19:
	cmp	edx, esi
	jle	.L30
	cmp	edi, esi
	jge	.L15
.L21:
	jmp	.L21
	.p2align 4,,10
	.p2align 3
.L30:
	add	esi, edx
	cmp	edi, esi
	jl	.L19
.L15:
	add	edi, esi
	lea	eax, [rdi+rsi]
	add	eax, edx
	add	eax, ecx
	add	eax, r8d
	ret
	.p2align 4,,10
	.p2align 3
.L31:
	add	esi, edx
	cmp	edi, esi
	jge	.L15
.L16:
	cmp	edx, esi
	jle	.L31
	add	edx, ecx
	lea	eax, [rdi+rsi]
	add	eax, edx
	add	eax, ecx
	add	eax, r8d
	ret
	.p2align 4,,10
	.p2align 3
.L23:
	add	esi, edx
	cmp	edi, esi
	jge	.L15
.L17:
	cmp	edx, esi
	jle	.L23
	lea	eax, [rdi+rsi]
	add	ecx, r8d
	add	eax, edx
	add	eax, ecx
	add	eax, r8d
	ret
	.size	jump_compression, .-jump_compression
	.globl	ivector5
	.bss
	.align 32
	.type	ivector5, @object
	.size	ivector5, 400
ivector5:
	.zero	400
	.globl	ivector4
	.align 8
	.type	ivector4, @object
	.size	ivector4, 12
ivector4:
	.zero	12
	.globl	ivector2
	.type	ivector2, @object
	.size	ivector2, 3
ivector2:
	.zero	3
	.globl	ivector
	.align 8
	.type	ivector, @object
	.size	ivector, 12
ivector:
	.zero	12
	.globl	flt_6
	.align 8
	.type	flt_6, @object
	.size	flt_6, 8
flt_6:
	.zero	8
	.globl	flt_5
	.align 8
	.type	flt_5, @object
	.size	flt_5, 8
flt_5:
	.zero	8
	.globl	flt_4
	.align 8
	.type	flt_4, @object
	.size	flt_4, 8
flt_4:
	.zero	8
	.globl	flt_3
	.align 8
	.type	flt_3, @object
	.size	flt_3, 8
flt_3:
	.zero	8
	.globl	flt_2
	.align 8
	.type	flt_2, @object
	.size	flt_2, 8
flt_2:
	.zero	8
	.globl	flt_1
	.align 8
	.type	flt_1, @object
	.size	flt_1, 8
flt_1:
	.zero	8
	.globl	k5
	.align 4
	.type	k5, @object
	.size	k5, 4
k5:
	.zero	4
	.globl	j5
	.align 4
	.type	j5, @object
	.size	j5, 4
j5:
	.zero	4
	.globl	i5
	.align 4
	.type	i5, @object
	.size	i5, 4
i5:
	.zero	4
	.globl	j4
	.align 4
	.type	j4, @object
	.size	j4, 4
j4:
	.zero	4
	.globl	i4
	.align 4
	.type	i4, @object
	.size	i4, 4
i4:
	.zero	4
	.globl	m3
	.align 4
	.type	m3, @object
	.size	m3, 4
m3:
	.zero	4
	.globl	k3
	.align 4
	.type	k3, @object
	.size	k3, 4
k3:
	.zero	4
	.globl	i3
	.align 4
	.type	i3, @object
	.size	i3, 4
i3:
	.zero	4
	.globl	h3
	.align 4
	.type	h3, @object
	.size	h3, 4
h3:
	.zero	4
	.globl	g3
	.align 4
	.type	g3, @object
	.size	g3, 4
g3:
	.zero	4
	.globl	k2
	.align 4
	.type	k2, @object
	.size	k2, 4
k2:
	.zero	4
	.globl	j2
	.align 4
	.type	j2, @object
	.size	j2, 4
j2:
	.zero	4
	.globl	i2
	.align 4
	.type	i2, @object
	.size	i2, 4
i2:
	.zero	4
	.globl	m
	.align 4
	.type	m, @object
	.size	m, 4
m:
	.zero	4
	.globl	l
	.align 4
	.type	l, @object
	.size	l, 4
l:
	.zero	4
	.globl	k
	.align 4
	.type	k, @object
	.size	k, 4
k:
	.zero	4
	.globl	j
	.align 4
	.type	j, @object
	.size	j, 4
j:
	.zero	4
	.globl	i
	.align 4
	.type	i, @object
	.size	i, 4
i:
	.zero	4
	.section	.rodata.cst8,"aM",@progbits,8
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
	.align 8
.LC4:
	.value	0
	.value	2
	.value	4
	.value	6
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
