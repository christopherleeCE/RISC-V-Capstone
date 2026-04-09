#include "tb.h"
#include "drysoup.h"

//volatile int num = 3;

int main(){

    // int arr[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 13};
    // int test_array[] = {
    //     -18, -1, 97, 23, 32, -66
    //     , -13, 63, -37, 15, -4, -58
    //     , 85, 10, 67, -49, 7, -74, 59
    //     , -98, 43, -21, -15, -15, -71
    //     , -85, 54, -82, 47, 20, -27, -58
    //     , -66, 2, -23, -30, 84, -93, 47
    //     , -84, -92, -4, 0, 74, -42, -51
    //     , 72, 64, -71, -91, 18, -61, -50
    //     , -56, -28, 90, 95, 89, -19, 20
    //     , 16, -20, -17, -36, 100, 36, -45
    //     , -77, 73, -92, -55, -86, -77, -46
    //     , 72, 45, 43, 49, -4, 71, -86, 13, -29
    //     , 22, -20, 0, -56, 59, 40, -98, 63, 95
    //     , -84, -57, 47, 26, -18, 52, 28, 97
    //     };
    // arr[7] = num * 1000;
    //int* empty = malloc(4);
    int* ret0 = calloc(0, 1);
    int* ret1 = calloc(1, 1);
    int* ret2 = calloc(2, 1);
    int* ret3 = calloc(3, 1);
    int* ret4 = calloc(4, 1);
    int* ret5 = calloc(5, 1);
    int* ret6 = calloc(6, 1);
    int* ret7 = calloc(7, 1);
    int* ret8 = calloc(8, 1);
    int* ret9 = calloc(9, 1);

    free(ret1);
    free(ret3);
    free(ret4);
    free(ret5);
    free(ret6);
    free(ret7);
    free(ret8);
    free(ret9);
    free(ret2);
    free(ret0);

    return tb_return(0);

}