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
plus:
	.space	8
minus:
	.space	8

	.text
	.globl main
main:
//	Prologue
	pushl	%ebp
	movl	%esp, %ebp

	pushl	$y
	pushl	$x
	pushl	$scanf_format
	call	scanf

	finit

	fldl	x
	fldl	y
	faddp
	fstpl	plus
	
	fldl	y
	fldl	x
	fsubp
	fstpl	minus

	fld1
	fldl	plus
	fldl	minus
	fmulp
	fyl2x
	fldlg2
	fmulp
	fstpl	(%esp)
	pushl	$printf_format
	call	printf
	

//	Epilogue
	movl	%ebp, %esp
	popl	%ebp
	ret
