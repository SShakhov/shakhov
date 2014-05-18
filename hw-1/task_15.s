	.data
scanf_format:
	.string	"%d"
branch_1:
	.string	"In branch 1\n"
branch_2:
	.string	"In branch 2\n"
no_branch:
	.string	"No such branch\n"

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

	movl	input,	%eax
	cmpl	$1, %eax
	jne	not_branch_1
	pushl	$branch_1
	call	printf
	jmp	escape
not_branch_1:
	cmpl	$2, %eax
	jne	not_branch_2
	pushl	$branch_2
	call	printf
	jmp escape
not_branch_2:
	pushl	$no_branch
	call	printf
escape:

//	Epilogue
	movl	%ebp, %esp
	popl	%ebp
	ret
