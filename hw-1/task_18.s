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
loop_while:
	incl	%eax
	decl	%ecx
	cmpl	$0, %ecx
	jg	loop_while

	pushl	%eax
	pushl	$printf_format
	call	printf

//	Epilogue
	movl	%ebp, %esp
	popl	%ebp
	ret
