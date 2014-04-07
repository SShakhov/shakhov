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
//	Prolog
	pushl	%ebp
	movl	%esp, %ebp

	pushl	$input
	pushl	$scanf_format
	call	scanf

//	Shift to the left x3 
	movl	input, %eax
	movl	%eax, %ebx
	shll	$3, %eax

//	Logical "and" for input number and shifted number 
	andl	%eax, %ebx

	pushl	%eax
	pushl	$printf_format
	call	printf

	pushl	%ebx
	pushl	$printf_format
	call	printf

//	Epilog
	movl	%ebp, %esp
	popl	%ebp
	ret
