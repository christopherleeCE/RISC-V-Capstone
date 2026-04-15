#include "base.h"

int main() {
    int x = 0;

    for (int i = 0; i < 20; i++) {
        if (i & 1)
            x += 3;
        else
            x -= 2;
    }

    return tb_return(x, x);
}