#include "base.h"

volatile int num = 3;

int main() {
    int result = num * 1000;

    return tb_return(result, result);
}