#include "tb.h"

int main() {
    int n = 7, i = 0, t1 = 0, t2 = 1, nextTerm;

    while (i < n) {
        if (i <= 1) {
            nextTerm = i;
        } else {
            nextTerm = t1 + t2;
            t1 = t2;
            t2 = nextTerm;
        }
        i++;
    }

    return tb_return(nextTerm);
}