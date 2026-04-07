/* 

FLOATING-POINT VERSION - 

This program will solve a linear system of equations using Gaussian elimination
and back substituion. Partial pivoting is used to reduce rounding errors. Not as
fast as a dedicated linalg library, but mainly to test processor functionality.

-Edgar G.

*/

//libraries
#include "tb.h"
#include "drysoup.h"
#include "linalg_float.h"

#define SCALE 1000000
#define N 3 //width and height of matrices

int main()
{
    float a_matrix[N][N] = 
    {{1, -1, 1},
     {2, 3, -1},
     {3, -2, -9}};

    float b_matrix[N] =
    {8, -2, 9};

    solve(N, a_matrix, b_matrix);

    #ifdef x86_BUILD
    printf("Solutions:\n");
    for(int i = 0; i <= N-1; i++)
        printf("%f ", b_matrix[i]);
    printf("\n");
    #endif

    //return
    return(tb_return(pack_ptr(b_matrix, sizeof(b_matrix)/sizeof(b_matrix[0]), false)));
}

