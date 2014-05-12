	.data
scanf_format:
	.string	"%d"
printf_format:
	.string	"%d\t%d\n"

	.bss
num_of_p:
	.space	4
num_of_n:
	.space	4
buffer:
	.space	20
save_eax:
	.space	4
save_ecx:
	.space	4

	.text

	.macro	amount
	movl	(%eax), %ebx
	cmpl	$0, %ebx
	jg	pos1
	addl	$1, num_of_n
	jmp	go_on1
pos1:
	addl	$1, num_of_p
go_on1:
	addl	$4, %eax
	movl	(%eax), %ebx
	cmpl	$0, %ebx
	jg	pos2
	addl	$1, num_of_n
	jmp	go_on2
pos2:
	addl	$1, num_of_p
go_on2:
	addl	$4, %eax
	movl	(%eax), %ebx
	cmpl	$0, %ebx
	jg	pos3
	addl	$1, num_of_n
	jmp	go_on3
pos3:
	addl	$1, num_of_p
go_on3:
	addl	$4, %eax
	movl	(%eax), %ebx
	cmpl	$0, %ebx
	jg	pos4
	addl	$1, num_of_n
	jmp	go_on4
pos4:
	addl	$1, num_of_p
go_on4:
	addl	$4, %eax
	movl	(%eax), %ebx
	cmpl	$0, %ebx
	jg	pos5
	addl	$1, num_of_n
	jmp	go_on5
pos5:
	addl	$1, num_of_p
go_on5:
	pushl	num_of_n
	pushl	num_of_p
	pushl	$printf_format
	call	printf
	.endm

	.globl	main
main:
//	Prologue
	pushl	%ebp
	movl	%esp, %ebp

	movl	$5, %ecx
	movl	$buffer, %eax
//!!!Forgot to save ecx from being changed by scanf. Fixed. Works perfectly now.
scan_loop:
	pushl	%eax
	pushl	$scanf_format
	movl	%eax, save_eax
	movl	%ecx, save_ecx
	call	scanf
	movl	save_eax, %eax
	movl	save_ecx, %ecx
	addl	$4, %eax
	loop	scan_loop

	movl	$buffer, %eax
	amount

//	Epilogue
	movl	%ebp, %esp
	popl	%ebp
	ret
