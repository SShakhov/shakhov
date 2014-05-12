	.data
scanf_format:
	.string	"%c"
printf_format:
	.string	"%s"
	.bss
input:
	.space	100
length:
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
	subl	$2, length

	pushl	%esi
	pushl	%edi

	movl	$input, %esi
	movl	%esi, %edi
	addl	length, %edi
	
invert:
	movb	(%esi), %al
	movb	(%edi), %bl
	movb	%al, (%edi)
	movb	%bl, (%esi)
	incl	%esi
	decl	%edi

	cmpl	%esi, %edi
	jg	invert

	popl	%edi
	popl	%esi

	pushl	$input
	pushl	$printf_format
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
