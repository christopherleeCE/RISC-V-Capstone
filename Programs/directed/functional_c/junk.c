#include "tb.h"
#include "drysoup.h"

//volatile int num = 3;

int main(){

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

    return tb_return(0, 0);

}