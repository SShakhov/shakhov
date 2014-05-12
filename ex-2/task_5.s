	.data
scanf_format:
	.string	"%c"
scanf_index:
	.string	"%d"
printf_format:
	.string	"%s"
	.bss
input:
	.space	100, 0
length:
	.space	4
buffer:
	.space	4
index:
	.space	4
del:
	.space	4
save_eax:
	.space	4

	.text
	.globl main
main:
//	Prologue
	pushl	%ebp
	movl	%esp, %ebp

	movl	$input, %eax
	call	scan_input

	pushl	$index
	pushl	$scanf_index
	call	scanf

	pushl	$del
	pushl	$scanf_index
	call	scanf
	
	pushl	%esi
	pushl	%edi

	movl	$input, %esi
	addl	index, %esi
	addl	del, %esi
	movl	$buffer, %edi

//eax at the end of the string
	movl	$input, %eax
	addl	length, %eax

	movl	%eax, %ecx
	subl	%esi, %ecx

	rep movsb

//Shift bytes to the left
	movl	$buffer, %esi
	movl	$input, %edi
	addl	index, %edi
	movl	%eax, %ecx
	subl	%edi, %ecx

	rep movsb

	movl	$0, (%edi)

	popl	%edi
	popl	%esi

	pushl	$input
	call	printf


//	Epilogue
	movl	%ebp, %esp
	popl	%ebp
	ret

scan_input:
//      Prologue
        pushl   %ebp
        movl    %esp, %ebp

scan:
        pushl   %eax
        pushl   $scanf_format
        movl    %eax, save_eax
        call    scanf
        addl    $1, length

        movl    save_eax, %eax
        movl    (%eax), %ebx
        incl    %eax
        cmpl    $10, %ebx
        jne     scan

//      Epilogue
        movl    %ebp, %esp
        popl    %ebp
        ret

