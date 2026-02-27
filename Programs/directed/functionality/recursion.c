#include "tb.h"

int fact(int n) {
    if (n <= 1)
        return 1;
    return n * fact(n - 1);
}

int main() {

    return tb_return( fact(5) );

}