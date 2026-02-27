#include "tb.h"

int main() {
    int values[4] = {3, 6, 9, 12};
    int *p = values;
    int sum = 0;

    for (int i = 0; i < 4; i++) {
        sum += *(p + i);
    }

    return tb_return(sum);
}