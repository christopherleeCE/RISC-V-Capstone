#include "tb.h"

int square(int x) {
    return x * x;
}

int accumulate(int n) {
    int sum = 0;
    for (int i = 0; i < n; i++)
        sum += square(i);
    return sum;
}

int main() {

    return tb_return(accumulate(5), accumulate(5));

}