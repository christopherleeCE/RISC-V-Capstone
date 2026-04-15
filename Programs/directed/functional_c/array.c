#include "base.h"

int main() {
    int arr[6];
    int sum = 0;

    for (int i = 0; i < 6; i++) {
        arr[i] = i * 3;
    }

    for (int i = 0; i < 6; i++) {
        sum += arr[i];
    }

    return tb_return(sum, sum);
}