#include "base.h"

volatile int num = 1;

int main() {
    int result = num * 10;

    return tb_return(result, result);
}