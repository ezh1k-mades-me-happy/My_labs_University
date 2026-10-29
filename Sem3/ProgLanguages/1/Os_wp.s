	.file	"task.c"
	.intel_syntax noprefix
	.text
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	ud2
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
