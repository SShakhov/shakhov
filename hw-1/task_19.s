	.data
scanf_format:
	.string	"%d"
printf_format:
	.string	"%d\n"

	.bss
input:
	.space	4

	.text
	.globl	main

main:
//	Prologue
	pushl	%ebp
	movl	%esp, %ebp

	pushl	$input
	pushl	$scanf_format
	call	scanf
	
	movl	input, %ecx
	xorl	%eax, %eax
loop_do_while:
	decl	%ecx
	cmpl	$0, %ecx
	jl	escape
	incl	%eax
	jmp	loop_do_while
escape:

	pushl	%eax
	pushl	$printf_format
	call	printf

//	Epilogue
	movl	%ebp, %esp
	popl	%ebp
	ret
