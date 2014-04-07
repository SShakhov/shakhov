	.data
scanf_format:
	.string	"%s"
printf_format:
	.string	"%s\n"
printf_format_0:
	.string "0"
printf_format_1:
	.string "1"

	.bss
input1:
	.space	11
input2:
	.space	11
output:
	.space	11
cmp_string:
	.space	11

	.text
	.globl	main

main:
//	Prolog
	pushl	%ebp
	movl	%esp, %ebp

//	Scan
	pushl	$input1
	pushl	$scanf_format
	call	scanf

	pushl	$input2
	pushl	$scanf_format
	call	scanf

	call	mov

//	Print
	pushl	$output
	pushl	$printf_format
	call	printf

	call cmp
	pushl	$cmp_string
	call	printf

//	Epilog
	movl	%ebp, %esp
	popl	%ebp
	ret

mov:
//	Prolog
	pushl	%ebp
	movl	%esp, %ebp

	pushl	%esi
	pushl	%edi

	movl	$input1, %esi
	movl	$output, %edi
	movl	$10, %ecx
	rep movsb

	popl	%edi
	popl	%esi

//	Epilog
	movl	%ebp, %esp
	popl	%ebp
	ret

cmp:
//	Prolog
	pushl	%ebp
	movl	%esp, %ebp

	pushl	%esi
	pushl	%edi

	movl	$input1, %esi
	movl	$input2, %edi
	movl	$10, %ecx
	movl	$cmp_string, %ebx

compare:
	cmpsb
	je equal
	movl	$48, (%ebx)
	jmp nequal
equal:
	movl	$49, (%ebx)
nequal:
	addl	$1, %ebx
	loop compare

	movl	$10, (%ebx)

	popl	%edi
	popl	%esi

//	Epilog
	movl	%ebp, %esp
	popl	%ebp
	ret
