	.data
scanf_format:
	.string	"%c"
scanf_index:
	.string	"%d"
printf_format:
	.string	"%s"

	.bss
input1:
	.space	100, 0
input2:
	.space	200, 0
index:
	.space	4
buffer:
	.space	100, 0
save_eax:
	.space	4
len_buff:
	.space	4, 0
length1:
	.space	4
length2:
	.space	4

	.text
	.globl main
main:
//	Prologue
	pushl	%ebp
	movl	%esp, %ebp

	movl	$input1, %eax
	call	scan_input
	movl	len_buff, %eax
	decl	%eax
	movl	%eax, length1

	movl	$input2, %eax
	call	scan_input
	movl	len_buff, %eax
	decl	%eax
	movl	%eax, length2

	pushl	$index
	pushl	$scanf_index
	call	scanf
	
	pushl	%esi
	pushl	%edi

//Save bytes after index
	movl	$input2, %esi
	addl	index, %esi
	movl	$buffer, %edi
	movl	length2, %ecx
	subl	index, %ecx

	rep	movsb

//Put str1 into str2
	movl	$input1, %esi
	movl	$input2, %edi
	addl	index, %edi
	movl	length1, %ecx
	
	rep movsb

//Put saved bytes back
	movl	$buffer, %esi
	movl	length2, %ecx
	subl	index, %ecx

	rep movsb

	popl	%edi
	popl	%esi

//Print the result
	pushl	$input2
	pushl	$printf_format
	call	printf

//	Epilogue
	movl	%ebp, %esp
	popl	%ebp
	ret

scan_input:
//	Prologue
	pushl	%ebp
	movl	%esp, %ebp

scan:
	pushl	%eax
	pushl	$scanf_format
	movl	%eax, save_eax
	call	scanf
	addl	$1, len_buff

	movl	save_eax, %eax
	movl	(%eax), %ebx
	incl	%eax
	cmpl	$10, %ebx
	jne	scan

//	Epilogue
	movl	%ebp, %esp
	popl	%ebp
	ret
