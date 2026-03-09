#include "tb.h"

volatile int num = 2;

int main() {
    int result = num * 100;

    return tb_return(result);
}