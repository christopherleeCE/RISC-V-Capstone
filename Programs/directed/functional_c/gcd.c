#include "base.h"

int findGCD(int a, int b) {
    if (b == 0)
        return a;
    return findGCD(b, a % b);
}

int main() {
    int num1 = 27;
    int num2 = 81;

    int result = findGCD(num1 < 0 ? -num1 : num1, num2 < 0 ? -num2 : num2);

    return tb_return(result, result);
}