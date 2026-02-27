#include "tb.h"

int main() {
    int sum = 0;

    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 4; j++) {
            sum += i + j;
        }
    }

    return tb_return(sum);
}