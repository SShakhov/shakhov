.data

string:
	.string	"Hello %d\n"
int:
	.int	321

.text
.globl main

main:
	pushl	%ebp
	movl	%esp, %ebp

	pushl	int
	pushl	$string
	call	printf

	movl	%ebp, %esp
	popl	%ebp
	ret
