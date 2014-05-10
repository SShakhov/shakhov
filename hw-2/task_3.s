	.data
scanf_format:
	.string	"%lf%lf%lf%lf%lf"
//Output is rounded to 12 significant digits
printf_format:
	.string "%.12g\n"
//Number of digits to sum
	.set	N, 5
	
	.bss
//Space for 5 doubles
buffer:
	.space	40

	.text
	.globl main

main:
//	Prolog
	pushl	%ebp
	movl	%esp, %ebp

	finit

	movl	$buffer, %eax
	movl	$N, %ecx
push_buff:
	pushl	%eax
	addl	$8, %eax
	loop	push_buff

	pushl	$scanf_format
	call	scanf

	movl	$buffer, %eax
	movl	$(N-1), %ecx
	fldl	(%eax)
sum_loop:
	addl	$8, %eax
	fldl	(%eax)
	faddp
	loop	sum_loop

	fstpl	(%esp)
	wait
	pushl	$printf_format
	call	printf

//	Epilog
	movl	%ebp, %esp
	popl	%ebp
