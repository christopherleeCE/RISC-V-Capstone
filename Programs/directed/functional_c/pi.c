#include <stdint.h>
#include "base.h"

// Computes pi scaled by SCALE (fixed-point style)
int compute_pi(int iterations, int SCALE) {
    int sum = 0;

    for (int k = 0; k < iterations; k++) {
        int denom = 2 * k + 1;

        // term = SCALE / denom
        int term = SCALE / denom;   // forces div

        if (k % 2 == 0) {               // forces rem
            sum += term;
        } else {
            sum -= term;
        }
    }

    return 4 * sum;
}

/*
100mil  :   0x40490FD9 (9 minutes) precision lost in float
10mil   :   0x40490FD9 (50 seconds)
1mil    :   0x40490fD6 (5.5 seconds)
*/

int main() {

    int MILLION = 1000000;
    int scale = 1000000000; //largest scale without overflow
    int interations_fpga = 10*MILLION;
    int interations_sim = 100;

    // :)
    return tb_return(*(int*)&(float){(float)(uint32_t)compute_pi(interations_sim,scale)/(float)scale}, *(int*)&(float){(float)(uint32_t)compute_pi(interations_sim,scale)/(float)scale});
}