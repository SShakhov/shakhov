//input string of < 10 chars
	.data
input_str:
	.space	10
scanf_format:
	.string	"%s"
printf_format:
	.string	"%d\n"
out_int:
	.space	4

	.text
	.globl main

main:
//	Prolog. It is useful to save current ESP in EBP to
	pushl	%ebp
	movl	%esp, %ebp

	pushl	$input_str
	pushl	$scanf_format
	call	scanf

	pushl	$input_str
	call	strlen

	pushl	%eax
	pushl	$printf_format
	call	printf

//Epilog
	movl	%ebp, %esp
	popl	%ebp
	ret
