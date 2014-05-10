	.data
scanf_format:
	.string	"%lf%lf"
printf_format:
	.string	"%f\n"

	.bss
x:
	.space	8
y:
	.space	8
log:
	.space	8
int:
	.space	8
fract:
	.space	8

	.text
	.globl main

main:
//	Prolog
	pushl	%ebp
	movl	%esp, %ebp

	finit

	pushl	$y
	pushl	$x
	pushl	$scanf_format
	call	scanf

	fldl	y
	fldl	x
	fyl2x

//	Save integer part of ylog2(x)
	fstl	log
	frndint
	fstl	int
	fldl	log
	
//	Get the fraction
	fsubp

//	Save 2^(fraction of logarithm)
	f2xm1
	fld1
	faddp
	fstl	fract	

//	Get 2^(int part of logarithm)
	fldl	int
	fld1
	fscale		
	fldl	fract

	fmulp

	fstl	(%esp)

	pushl	$printf_format
	call	printf

//	Epilog
	movl	%ebp, %esp
	popl	%ebp
	ret
