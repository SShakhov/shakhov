//Program takes as an input a hex number that corresponds
//to the desired state of %flags. It then sets flags and prints 
//the state of CF, ZF, SF, OF as 4 digits
	.data
printf_1:
	.string	"1"
printf_0:
	.string	"0"
printf_nl:
	.string	"\n"
scanf_format:
	.string	"%x"

	.bss
input:
	.space	2

	.text

	.macro	outf
	jc	carry
	pushl	$printf_0
	call	print
	jmp	go_on1
carry:
	pushl	$printf_1
	call	print
go_on1:
	jz	zero
	pushl	$printf_0
	call	print
	jmp	go_on2
zero:
	pushl	$printf_1
	call	print
go_on2:
	js	sign
	pushl	$printf_0
	call	print
	jmp	go_on3
sign:
	pushl	$printf_1
	call	print
go_on3:
	jo	overflow
	pushl	$printf_0
	call	print
	jmp	go_on4
overflow:
	pushl	$printf_1
	call	print
go_on4:
	pushl	$printf_nl
	call	print
	.endm

	.globl main
main:
//	Prolog
	pushal
	movl	%esp, %ebp

	pushl	$input
	pushl	$scanf_format
	call	scanf	

	pushf
	popl	%eax
	movw	input, %ax
	pushl	%eax
	popf

	outf

//	Epilog
	movl	%ebp, %esp
	popal
	ret

//	Using interruption since printf changes flags and registers
print:
//	Prolog
	pushal
	movl	%esp, %ebp

	movl	$4, %eax
	movl	$1, %ebx
	movl	36(%ebp), %ecx
	movl	$1, %edx
	int	$0x80

//	Epilog
	movl	%ebp, %esp
	popal
	ret
