	.file	"task.c"
	.intel_syntax noprefix
	.text
	.globl	main
	.type	main, @function
main:
	mov	eax, DWORD PTR i[rip]
	mov	ecx, 0
	cdq
	idiv	ecx
	mov	DWORD PTR i2[rip], eax
	movsd	xmm0, QWORD PTR .LC0[rip]
	pxor	xmm1, xmm1
	divsd	xmm0, xmm1
	mulsd	xmm0, QWORD PTR .LC2[rip]
	movsd	QWORD PTR flt_6[rip], xmm0
	mov	eax, 10000
.L2:
	sub	eax, 1
	test	eax, eax
	jg	.L2
	mov	edx, 10000
	sub	edx, eax
	mov	DWORD PTR j5[rip], edx
	mov	eax, 100
.L3:
	sub	eax, 1
	jne	.L3
	mov	DWORD PTR i4[rip], 3
	lea	eax, [7+rdx*4]
	mov	DWORD PTR k5[rip], eax
	mov	DWORD PTR i[rip], 6
	ret
	.size	main, .-main
	.local	flt_6
	.comm	flt_6,8,8
	.local	k5
	.comm	k5,4,4
	.local	j5
	.comm	j5,4,4
	.local	i4
	.comm	i4,4,4
	.local	i2
	.comm	i2,4,4
	.local	i
	.comm	i,4,4
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	1717986918
	.long	1075930726
	.align 8
.LC2:
	.long	858993459
	.long	1073951539
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
