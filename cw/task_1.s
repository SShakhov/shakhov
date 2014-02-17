.data

msg_string_1:
	.string	"call_1\n"
msg_string_2:
	.string	"call_2\n"

	.text
my_printf:
//	Prolog
	pushl	%ebp
	movl	%esp, %ebp

	pushl	$msg_string_1
	call	printf

	pushl	$msg_string_2
	call	printf

//	Epilogue
	movl	%ebp, %esp
	pop	%ebp
	ret

	.globl	main

main:
//	Prolog
	pushl	%ebp
	movl	%esp, %ebp

	call	my_printf

//	Epilogue
	movl	%ebp, %esp
	pop	%ebp
	ret

