	.text
	.globl	asm_sum
	.globl	asm_sub
	.globl	asm_mul
	.globl	asm_div
	.globl	asm_inc
	.globl	asm_dec
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

asm_inc:
	pushl	%ebp
	movl	%esp, %ebp

	movl	8(%ebp), %eax
	incl	%eax

	movl	%ebp, %esp
	popl	%ebp
	ret

asm_dec:
	pushl	%ebp
	movl	%esp, %ebp

	movl	8(%ebp), %eax
	decl	%eax

	movl	%ebp, %esp
	popl	%ebp
	ret
