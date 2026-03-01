#include "tb.h"

int main() {

    int a = 1;
    a = a + 1;
    a = a + 1;
    a = a + 1;
    a = a + 1;

    //my name is retep, and i am evil
    #ifdef X86_BUILD
        a = a;
    #endif

    return tb_return(a);
}