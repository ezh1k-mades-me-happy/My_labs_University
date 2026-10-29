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
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
	mov	DWORD PTR i3[rip], 3
	mov	eax, DWORD PTR k5[rip]
	mov	DWORD PTR i5[rip], 0
	mov	DWORD PTR j4[rip], eax
	mov	rax, QWORD PTR .LC0[rip]
	mov	QWORD PTR flt_1[rip], rax
	mov	eax, DWORD PTR i[rip]
	mov	DWORD PTR j2[rip], eax
	mov	DWORD PTR i4[rip], eax
	ud2
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
	jle	.L8
	cmp	edx, ecx
	jge	.L9
	cmp	ecx, r8d
	jl	.L10
.L12:
	cmp	edx, esi
	jle	.L23
	cmp	edi, esi
	jge	.L8
.L14:
	jmp	.L14
	.p2align 4,,10
	.p2align 3
.L23:
	add	esi, edx
	cmp	edi, esi
	jl	.L12
.L8:
	add	edi, esi
	lea	eax, [rdi+rsi]
	add	eax, edx
	add	eax, ecx
	add	eax, r8d
	ret
	.p2align 4,,10
	.p2align 3
.L24:
	add	esi, edx
	cmp	edi, esi
	jge	.L8
.L9:
	cmp	edx, esi
	jle	.L24
	add	edx, ecx
	lea	eax, [rdi+rsi]
	add	eax, edx
	add	eax, ecx
	add	eax, r8d
	ret
	.p2align 4,,10
	.p2align 3
.L16:
	add	esi, edx
	cmp	edi, esi
	jge	.L8
.L10:
	cmp	edx, esi
	jle	.L16
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
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
