	.data
printf_format:
	.string	"%d\n"
scanf_format:
	.string	"%d%d"

	.bss
a:
	.space	4
b:
	.space	4

	.text
	.globl	main

main:
//	Prologue
	pushl	%ebp
	movl	%esp, %ebp

	pushl	$b
	pushl	$a
	pushl	$scanf_format
	call	scanf

	pushl	b
	pushl	a
	call	asm_sum
	pushl	%eax
	pushl	$printf_format
	call	printf
	addl	$16, %esp
	
	pushl	b
	pushl	a
	call	asm_sub
	pushl	%eax
	pushl	$printf_format
	call	printf
	addl	$16, %esp

	pushl	b
	pushl	a
	call	asm_mul
	pushl	%eax
	pushl	$printf_format
	call	printf
	addl	$16, %esp

	pushl	b
	pushl	a
	call	asm_div
	pushl	%eax
	pushl	$printf_format
	call	printf
	addl	$16, %esp

//	Epilogue
	movl	%ebp, %esp
	popl	%ebp
	ret

asm_sum:
	pushl	%ebp
	movl	%esp, %ebp

	pushl	%ebx
	movl	8(%ebp), %eax
	movl	12(%ebp), %ebx
	addl	%ebx, %eax

	popl	%ebx

	movl	%ebp, %esp
	popl	%ebp
	ret

asm_sub:
	pushl	%ebp
	movl	%esp, %ebp

	pushl	%ebx
	movl	8(%ebp), %eax
	movl	12(%ebp), %ebx
	subl	%ebx, %eax

	popl	%ebx

	movl	%ebp, %esp
	popl	%ebp
	ret

asm_mul:
	pushl	%ebp
	movl	%esp, %ebp

	pushl	%ebx
	movl	8(%ebp), %eax
	movl	12(%ebp), %ebx
	imull	%ebx

	popl	%ebx
  
	movl	%ebp, %esp
	popl	%ebp
	ret

asm_div:
	pushl	%ebp
	movl	%esp, %ebp
  
	pushl	%ebx
	movl	8(%ebp), %eax
	movl	8(%ebp), %edx
	sarl	$31, %edx
	movl	12(%ebp), %ebx
	idivl	%ebx
  
	popl	%ebx
	
	movl	%ebp, %esp
	popl	%ebp
	ret
