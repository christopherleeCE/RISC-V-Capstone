#include "tb.h"
#include "memcpy.c"

int main(){

    int test_array[] = {
        -18, -1, 97, 23, 32, -66,
        -13, 63, -37, 15, -4, -58,
        85, 10, 67, -49, 7, -74, 59,
        -98, 43, -21, -15, -15, -71,
        -85, 54, -82, 47, 20, -27, -58,
        -66, 2, -23, -30, 84, -93, 47,
        -84, -92, -4, 0, 74, -42, -51,
        72, 64, -71, -91, 18, -61, -50,
        -56, -28, 90, 95, 89, -19, 20,
        16, -20, -17, -36, 100, 36, -45,
        -77, 73, -92, -55, -86, -77, -46,
        72, 45, 43, 49, -4, 71, -86, 13, -29,
        22, -20, 0, -56, 59, 40, -98, 63, 95,
        -84, -57, 47, 26, -18, 52, 28, 97};
    int N = sizeof(test_array)/sizeof(int);

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N - i; j++) {
            if (test_array[j] > test_array[j + 1]) {
                int temp = test_array[j];
                test_array[j] = test_array[j + 1];
                test_array[j + 1] = temp;
            }
        }
    }

    // #ifdef X86_BUILD
    //     for(int ii = 0; ii < N; ii++)
    //         printf("%d\n", test_array[ii]);
    // #endif

    return tb_return((int)test_array[0]);
}
