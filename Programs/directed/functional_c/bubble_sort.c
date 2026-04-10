#include "tb.h"
#include "drysoup.h"

int main(){

    int test_array[] = {
        -18, -1, 97, 23, 32, -66,
        -13, 63, -37, 15, -4, -58
        };

    int N = sizeof(test_array)/sizeof(int);    

    for (int i = 0; i < N - 1; i++) {
        for (int j = 0; j < N - i - 1; j++) {
            if (test_array[j] > test_array[j + 1]) {
                int temp = test_array[j];
                test_array[j] = test_array[j + 1];
                test_array[j + 1] = temp;
            }
        }
    }

    return tb_return(
        test_array[0],
        pack_ptr((uint32_t*)test_array, N, false)
    );
}
