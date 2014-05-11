	.data
printf_format:
	.string "%.12g\n"
//Number of digits to sum
	.set	N, 5
	.bss
real_sum:
	.space	8
	
	.text
	.globl	ext_sum_rl
	.globl	ext_sum_int

ext_sum_rl:
//	Prolog
	pushl	%ebp
	movl	%esp, %ebp

	finit

	movl	8(%ebp), %eax
	movl	$(N-1), %ecx
	fldl	(%eax)
sum_loop_rl:
	addl	$8, %eax
	fldl	(%eax)
	faddp
	loop	sum_loop_rl

	fstl	real_sum
	movl	$real_sum, %eax

//	Epilog
	movl	%ebp, %esp
	popl	%ebp
	ret

ext_sum_int:
//	Prolog
	pushl	%ebp
	movl	%esp, %ebp

	movl	8(%ebp), %eax
	movl	(%eax), %ebx
	movl	$4, %ecx

sum_loop_int:
	addl	$4, %eax
	addl	(%eax), %ebx
	loop	sum_loop_int

	movl	%ebx, %eax
	

//	Epilog
	movl	%ebp, %esp
	popl	%ebp
	ret
