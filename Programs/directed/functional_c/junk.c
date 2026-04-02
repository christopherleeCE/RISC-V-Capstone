#include "tb.h"
#include "drysoup.h"

int main(){

    int arr[100] = {13};
    arr[7] = 2;

    return tb_return(arr[0]);
    //return tb_return(pack_ptr((uint32_t)arr, sizeof(arr)/sizeof(arr[0]), false));
}