	.data
printf_format:
	.string	"%d\n"
scanf_format:
	.string	"%c"

	.bss
input1:
	.space	100
input2:
	.space	100
len_buff:
	.space	4
length1:
	.space	4
length2:
	.space	4
save_eax:
	.space	4

	.text
	.globl main
main:
//	Prologue
	pushl	%ebp
	movl	%esp, %ebp

	movl    $input1, %eax
        call    scan_input

	movl	len_buff, %eax
	movl	%eax, length1

	movl    $input2, %eax
        call    scan_input

	movl	len_buff, %eax
	movl	%eax, length2

	pushl	%esi
	pushl	%edi

	movl	$input2, %esi

check_str:
	movl	$input1, %edi
	movl	length1, %ecx

comp:
	cmpsb
	jne	out
	loop	comp
	jmp	found
out:
	incl	%esi
	movl	%esi, %eax
	subl	$input2, %eax
	cmpl	length2, %eax
	jg	not_found
	loop	check_str

found:
	subl	$input2, %esi
//	subl	length1, %esi
	pushl	%esi
	pushl	$printf_format
	call	printf
	jmp	escape

not_found:
	pushl	$-1
	pushl	$printf_format
	call	printf

escape:
	popl	%edi
	popl	%esi


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
        addl    $1, len_buff

        movl    save_eax, %eax
        movl    (%eax), %ebx
        incl    %eax
        cmpl    $10, %ebx
        jne     scan

//      Epilogue
        movl    %ebp, %esp
        popl    %ebp
        ret

