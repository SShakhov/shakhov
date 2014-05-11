#include <stdio.h>

int buff_int[5];
double	buff_real[5];

double* ext_sum_rl(double* buff);
int ext_sum_int(int* buff);

int main()
{
	int i;
	for(i = 0; i < 5; i++)
		scanf("%d", &buff_int[i]);
	for(i = 0; i < 5; i++)
		scanf("%lf", &buff_real[i]);

	double* p = ext_sum_rl(buff_real);
	printf("%d\t%f\n", ext_sum_int(buff_int), *p);

	return 0;
}
