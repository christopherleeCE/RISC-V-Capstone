#include "tb.h"

int main(){

    int arr[] = {1, 2, 3, 4, 5, 6, 7, 8};

    arr[1] = arr[1] + 10;
    arr[3] = arr[3] + 10;
    arr[5] = arr[5] + 10;
    arr[7] = arr[7] + 10;

    int x = 0;
    for(int ii = 0; ii < 1000; ii++){
        x = x * 3;
    }

    return tb_return((int)arr);

}
