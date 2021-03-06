	.data
printf_nl:
	.string	"\n"
printf_format:
	.string	"%d"
scanf_format:
	.string	"%d"

	.bss
input:
	.space	4
save_ecx:
	.space	4
save_eax:
	.space	

	.text
	.globl	main

main:
//	Prologue
	pushl	%ebp
	movl	%esp, %ebp

	pushl	$input
	pushl	$scanf_format
	call	scanf

	movl	input, %eax
	roll	$1, %eax
	movl	$32, %ecx


print_loop:
	movl	%eax, %ebx
	andl	$0x1, %ebx
	pushl	%ebx
	pushl	$printf_format
	movl	%eax, save_eax
	movl	%ecx, save_ecx
	call	printf
	movl	save_eax, %eax
	movl	save_ecx, %ecx


	roll	%eax
	loop	print_loop


	pushl	$printf_nl
	call	printf



//	Epilogue
	movl	%ebp, %esp
	popl	%ebp
	ret
