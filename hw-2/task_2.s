	.data
scanf_format:
	.string	"%s"
printf_format:
	.string	"%s\n"
printf_invalid:
	.string	"Nothing on input\n"

//////////For cmp/////////////
printf_format_0:
	.string "0"
printf_format_1:
	.string "1"
//////////////////////////////

///////////For scan///////////
there_str:
	.string	"There\n"
thereno_str:
	.string	"Not there\n"
//////////////////////////////

	.bss
input1:
	.space	100
input2:
	.space	100
output:
	.space	100
cmp_string:
	.space	100
str_length:
	.space	4

	.text
	.globl	main

//Result is: input1 printed from output, string comparing input1 and input2,
//there/not there indicating the presence of "a" letter, reversed input1 OR "Nothing on input"
main:
//	Prolog
	pushl	%ebp
	movl	%esp, %ebp

//	Scan
	pushl	$input1
	pushl	$scanf_format
	call	scanf

	pushl	$input1
	call	strlen

//print 0 and exit if nothing is on input
	cmpl	$0, %eax
	jne	valid_input
	pushl	$printf_invalid
	call	printf
//	Epilog
	movl	%ebp, %esp
	popl	%ebp
	ret

valid_input:

	movl	%eax, str_length

	pushl	$input2
	pushl	$scanf_format
	call	scanf

	call	mov

//	Print
	pushl	$output
	pushl	$printf_format
	call	printf

	call	cmp
	pushl	$cmp_string
	call	printf

	call	sca

	call	lodsto
	pushl	$output
	call	printf

//	Epilog
	movl	%ebp, %esp
	popl	%ebp
	ret


//moves the input1 to output
//////////move////////////////
mov:
	pushl	%esi
	pushl	%edi

	movl	$input1, %esi
	movl	$output, %edi
	movl	str_length, %ecx
	rep movsb

	popl	%edi
	popl	%esi

	ret
//////////////////////////////


//compares input1 and input2
////////////compare///////////
cmp:
	pushl	%esi
	pushl	%edi

	movl	$input1, %esi
	movl	$input2, %edi
	movl	str_length, %ecx
	movl	$cmp_string, %ebx

cmp_loop:
	cmpsb
	je equal
	movl	$48, (%ebx)
	jmp nequal
equal:
	movl	$49, (%ebx)
nequal:
	addl	$1, %ebx
	loop	cmp_loop

	movl	$10, (%ebx)

	popl	%edi
	popl	%esi

	ret
//////////////////////////////


//Checks if "a" letter is present in input1
//////////scan////////////////
sca:
	movb	$97, %al
	movl	$input1, %edi
	movl	str_length, %ecx
	addl	$1, %ecx
scan_loop:
	scasb
	je	yes
	loop	scan_loop

	push	$thereno_str
	call	printf
	jmp	no

yes:
	pushl	$there_str
	call	printf
no:

	ret
//////////////////////////////


//Uses lods/stos commands to take chars from input1 and put them into output in reverse order
//////////lod/sto/////////////
lodsto:
	movl	str_length, %eax
	movl	$input1, %esi
	addl	str_length, %esi
	subl	$1, %esi
	movl	$output, %edi
	movl	str_length, %ecx

lodsto_loop:
	call	invert_df
	lodsb
	pushl	%eax
	call	invert_df
	popl	%eax
	stosb
	loop	lodsto_loop

	movl	$10, (%edi)
	
	ret
//////////////////////////////


//////////////////////////////
invert_df:
	pushf
	popw	%ax
	xorw	$0x400, %ax
	pushw	%ax
	popf

	ret
//////////////////////////////
