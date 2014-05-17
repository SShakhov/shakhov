	.data
printf_nl:
	.string	"\n"
printf_format:
	.string	"%x"
scanf_format:
	.string	"%s"

	.bss
input:
	.space	100
save_ecx:
	.space	4
save_eax:
	.space	4

	.text
	.globl	main

main:
//	Prologue
	pushl	%ebp
	movl	%esp, %ebp

//	Reads input as a string, then puts one byte at a time into eax
	pushl	$input
	pushl	$scanf_format
	call	scanf

        xorl    %eax, %eax
        movl    $input, %edx

scan:
        movb    (%edx), %bl
        cmpb    $0, %bl
        je      shift
        subb    $48, %bl
        orb     %bl, %al
        shll    %eax
	incl	%edx
        jmp     scan
       
shift: 
	shrl     %eax

	roll	$4, %eax
	movl	$8, %ecx

pre_print_loop:
	movl	%eax, %ebx
	andl	$0xF, %ebx
	cmpl	$0, %ebx
	roll	$4, %eax
	jne	print_loop
	loop	pre_print_loop

print_loop:
	pushl	%ebx
	pushl	$printf_format
	movl	%eax, save_eax
	movl	%ecx, save_ecx
	call	printf
	movl	save_eax, %eax
	movl	save_ecx, %ecx

	movl	%eax, %ebx
	andl	$0xF, %ebx
	roll	$4, %eax
	loop	print_loop

	pushl	$printf_nl
	call	printf

//	Epilogue
	movl	%ebp, %esp
	popl	%ebp
	ret
