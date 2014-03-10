#include <stdio.h>

int main()
{
	int a, b;
	char op;

	scanf("%d %d %c", &a, &b, &op);

	switch(op)
	{
		case '+':
			printf("%d\n", asm_sum(a, b));
			break;
		case '-':
			printf("%d\n", asm_sub(a, b));
			break;
		case '*':
			printf("%d\n", asm_mul(a, b));
			break;
		case '/':
			printf("%d\n", asm_div(a, b));
			break;
		case 'i':
			printf("%d\n", asm_inc(a));
			break;
		case 'd':
			printf("%d\n", asm_dec(a));
			break;
		default:
			break;
	}

	return 0;
}
