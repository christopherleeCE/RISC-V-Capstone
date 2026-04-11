#include "tb.h"
#include "drysoup.h"

#define N 3

int main() {

    int A[N][N] = {
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9}
    };

    int B[N][N] = {
        {9, 8, 7},
        {6, 5, 4},
        {3, 2, 1}
    };

    int C[N][N] = {0};

    // Matrix multiplication: C = A * B
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            for (int k = 0; k < N; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }

    return tb_return(
        C[0][0],
        pack_ptr((uint32_t*)C, 9, false)
    );
}