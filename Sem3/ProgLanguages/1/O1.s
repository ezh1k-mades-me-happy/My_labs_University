	.file	"task.c"
	.intel_syntax noprefix
	.text
	.globl	dead_code
	.type	dead_code, @function
dead_code:
	ret
	.size	dead_code, .-dead_code
	.globl	unnecessary_loop
	.type	unnecessary_loop, @function
unnecessary_loop:
	mov	eax, DWORD PTR j5[rip]
	mov	DWORD PTR k5[rip], eax
	mov	DWORD PTR i[rip], 5
	ret
	.size	unnecessary_loop, .-unnecessary_loop
	.globl	loop_jamming
	.type	loop_jamming, @function
loop_jamming:
	mov	eax, DWORD PTR j5[rip]
	lea	eax, [rdi+rax*4]
	mov	DWORD PTR k5[rip], eax
	imul	eax, edi
	sal	eax, 2
	mov	DWORD PTR i5[rip], eax
	mov	DWORD PTR i[rip], 5
	ret
	.size	loop_jamming, .-loop_jamming
	.globl	loop_unrolling
	.type	loop_unrolling, @function
loop_unrolling:
	mov	WORD PTR ivector4[rip], 0
	mov	WORD PTR ivector4[rip+2], 0
	mov	WORD PTR ivector4[rip+4], 0
	mov	WORD PTR ivector4[rip+6], 0
	mov	WORD PTR ivector4[rip+8], 0
	mov	WORD PTR ivector4[rip+10], 0
	mov	DWORD PTR i[rip], 6
	ret
	.size	loop_unrolling, .-loop_unrolling
	.globl	jump_compression
	.type	jump_compression, @function
jump_compression:
	cmp	esi, edi
	jg	.L6
.L7:
	add	edi, esi
.L11:
	lea	eax, [rdi+rsi]
	add	eax, edx
	add	eax, ecx
	add	eax, r8d
	ret
.L9:
	add	edx, ecx
	jmp	.L11
.L8:
	add	esi, edx
.L10:
	cmp	esi, edi
	jle	.L7
.L6:
	cmp	edx, esi
	jle	.L8
	cmp	edx, ecx
	jge	.L9
	cmp	ecx, r8d
	jge	.L10
	add	ecx, r8d
	jmp	.L11
	.size	jump_compression, .-jump_compression
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC4:
	.string	"Common subexpression elimination"
	.text
	.globl	main
	.type	main, @function
main:
	sub	rsp, 8
	mov	eax, DWORD PTR k5[rip]
	mov	DWORD PTR j4[rip], eax
	mov	DWORD PTR i3[rip], 3
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR flt_1[rip], xmm0
	mov	eax, DWORD PTR i[rip]
	mov	DWORD PTR j2[rip], eax
	mov	DWORD PTR i4[rip], eax
	mov	ecx, 0
	cdq
	idiv	ecx
	mov	esi, eax
	mov	DWORD PTR i2[rip], eax
	pxor	xmm1, xmm1
	divsd	xmm0, xmm1
	movsd	QWORD PTR flt_2[rip], xmm0
	movsd	xmm2, QWORD PTR .LC2[rip]
	movsd	QWORD PTR flt_3[rip], xmm2
	mov	rax, QWORD PTR .LC3[rip]
	mov	QWORD PTR flt_4[rip], rax
	mulsd	xmm1, QWORD PTR flt_6[rip]
	movsd	QWORD PTR flt_5[rip], xmm1
	mulsd	xmm0, xmm2
	movsd	QWORD PTR flt_6[rip], xmm0
	mov	DWORD PTR k3[rip], 1
	mov	eax, DWORD PTR j5[rip]
	sal	eax, 2
	mov	DWORD PTR k2[rip], eax
	mov	WORD PTR ivector4[rip], 0
	mov	WORD PTR ivector4[rip+2], 2
	mov	WORD PTR ivector4[rip+4], 4
	mov	WORD PTR ivector4[rip+6], 6
	mov	WORD PTR ivector4[rip+8], 8
	mov	WORD PTR ivector4[rip+10], 10
	mov	edx, 10000
.L14:
	sub	edx, 1
	test	edx, edx
	jg	.L14
	mov	ecx, 10000
	sub	ecx, edx
	lea	eax, [rdx+rdx*2]
	lea	edi, [rcx+rcx*4]
	cdq
	idiv	edi
	mov	DWORD PTR j5[rip], ecx
	mov	DWORD PTR i5[rip], eax
	mov	edx, OFFSET FLAT:ivector5+12
	mov	ecx, OFFSET FLAT:ivector5+812
.L15:
	mov	DWORD PTR [rdx], 5
	add	rdx, 8
	cmp	rdx, rcx
	jne	.L15
	mov	DWORD PTR i[rip], 100
	add	eax, esi
	mov	DWORD PTR k5[rip], eax
	mov	DWORD PTR ivector[rip], 1
	movsx	rax, esi
	mov	DWORD PTR ivector[0+rax*4], 2
	mov	DWORD PTR ivector[rip+8], 3
	mov	ecx, DWORD PTR h3[rip]
	lea	edx, [rcx+1]
	cmp	edx, 5
	ja	.L21
	movsx	rax, edx
	imul	rax, rax, 1431655766
	shr	rax, 32
	sar	edx, 31
	sub	eax, edx
	mov	DWORD PTR m3[rip], eax
	add	ecx, 4
	mov	DWORD PTR g3[rip], ecx
.L17:
	movzx	eax, BYTE PTR j[rip]
	mul	BYTE PTR k[rip]
	mov	BYTE PTR ivector2[rip], al
	mov	BYTE PTR ivector2[rip+1], al
	mov	BYTE PTR ivector2[rip+2], al
	mov	DWORD PTR i4[rip], 3
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
	add	rsp, 8
	ret
.L21:
	mov	edi, OFFSET FLAT:.LC4
	call	puts
	jmp	.L17
	.size	main, .-main
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
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
