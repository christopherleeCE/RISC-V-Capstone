#include "tb.h"
#include "drysoup.h"

int main(){

    char str[] = "HELLO WORLD";

    return tb_return(str[0]);
    //return tb_return(pack_ptr((uint32_t)str, sizeof(str)/sizeof(str[0]), true));
}