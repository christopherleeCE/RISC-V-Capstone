#include "tb.h"

int main() {

    int n = 10;   // change to test deeper iterations

    int a = 0;
    int b = 1;
    int temp;

    if (n == 0)
        return tb_return(0);

    for (int i = 2; i <= n; i++) {
        temp = a + b;
        a = b;
        b = temp;
    }

    return tb_return(b);
}