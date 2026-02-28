#include "tb.h"

int fact(int n) {
    if (n <= 1)
        return 1;
    return n * fact(n - 1);
}

int main() {

    //n = 34 and onward result in 0
    //stack overflow at n = 128
    //they grow up so fast, our first proper stack overflow
    return tb_return( fact(300000) );

}