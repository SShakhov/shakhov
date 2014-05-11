	.data
scanf_format:
	.string	"%c"
printf_format:
	.string	"%s"
printf_nl:
	.string	"\n"
printf_rule1:
	.string	"5. All letters to lower case\n"
printf_rule2:
	.string	"1. All numbers in front in the same order\n"

	.bss
input:
	.space	200
output:
	.space	200
save_eax:
	.space	4
true_false:
	.space	4, 0
input_length:
	.space	4, 0
numbers:
	.space	200

	.text
	.globl	main

main:
//	Prolog
	pushl	%ebp
	movl	%esp, %ebp

	movl	$input, %eax
scan:
	pushl	%eax
	pushl	$scanf_format
	movl	%eax, save_eax
	call	scanf
	addl	$1, input_length

	movl	save_eax, %eax
	movl	(%eax), %ebx
	incl	%eax
	cmpl	$0, %ebx
	jne	scan

	pushl	$input
	pushl	$printf_format
	call	printf

	movl	$input, %eax
	movb	(%eax), %bl
	call	check_byte

	movl	input_length, %ecx
	movb	-3(%eax, %ecx, 1), %bl
	call	check_byte

	movl	true_false, %eax
	cmpl	$2, %eax
	je	true
	call	not_the_case
	jmp	main_escape
true:
	call	the_case

main_escape:

//	Epilog
	movl	%ebp, %esp
	popl	%ebp
	ret

check_byte:
//	Prolog
	pushl	%ebp
	movl	%esp, %ebp

//	122?
	cmpb	$122, %bl
	jle	condition2
	jmp	escape

//	x<=122, 97?
condition2:
	cmpb	$97, %bl
	jge	condition3

//	x<97, 91?	
	cmpb	$91, %bl
	jle	condition4
	jmp	escape

//	x<=91, 65?
condition4:
	cmpb	$65, %bl
	jge	condition3
	jmp	escape

//	(97<=x<=122)||(65<=x<=91)
condition3:
	addl	$1, true_false

escape:

//	Epilog
	movl	%ebp, %esp
	popl	%ebp
	ret

the_case:
//	Prolog
	pushl	%ebp
	movl	%esp, %ebp

	pushl	%esi
	pushl	%edi

	movl	$input, %esi
	movl	$output, %edi
	movl	input_length, %ecx
	decl	%ecx

case_loop:
	lodsb
	cmpb	$91, %al
	jle	condition5
	stosb
	jmp	the_case_escape
condition5:
	cmpb	$65, %al
	jge	replace
	stosb
	jmp	the_case_escape
replace:
	addb	$32, %al
	stosb
	
the_case_escape:
	loop	case_loop

	popl	%edi
	popl	%esi

	pushl	$printf_rule1
	call	printf

	pushl	$output
	pushl	$printf_format
	call	printf

//	Epilog
	movl	%ebp, %esp
	popl	%ebp
	ret

not_the_case:
//	Prolog
	pushl	%ebp
	movl	%esp, %ebp

	pushl	%esi
	pushl	%edi

	movl	$input, %esi
	movl	$output, %edi
	movl	input_length, %ecx
	movl	$numbers, %ebx
	decl	%ecx

not_case_loop:
	lodsb
	cmpb	$57, %al
	jle	condition6
	stosb
	jmp	not_the_case_escape
condition6:
	cmpb	$48, %al
	jge	place_first
	stosb
	jmp	not_the_case_escape
place_first:
	movb	%al, (%ebx)
	incl	%ebx
	
not_the_case_escape:
	loop	not_case_loop

	popl	%edi
	popl	%esi

	pushl	$printf_rule2
	call	printf

	pushl	$numbers
	pushl	$printf_format
	call	printf

	pushl	$output
	pushl	$printf_format
	call	printf

//	Epilog
	movl	%ebp, %esp
	popl	%ebp
	ret
