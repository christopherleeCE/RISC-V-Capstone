#include <stdint.h>
#include "tb.h"

volatile int32_t pi_scaled_result;

// Computes pi scaled by SCALE (fixed-point style)
int32_t compute_pi(int iterations, int32_t SCALE) {
    int32_t sum = 0;

    for (int k = 0; k < iterations; k++) {
        int32_t denom = 2 * k + 1;

        // term = SCALE / denom
        int32_t term = SCALE / denom;   // forces div

        if (k % 2 == 0) {               // forces rem
            sum += term;
        } else {
            sum -= term;
        }
    }

    return 4 * sum;
}

/*
1mil,   bb40e194 : 3141591444 (5.5 seconds)
10mil,  bb40e4fc : 3141592316 (1 minute)
100mil, bb40e554 : 3141592404 (~9 minutes)
*/

int main() {

    int MILLION = 1000000;
    int scale = 1000000000;
    int interations_fpga = 100*MILLION;
    int interations_sim = 1000;


    return tb_return(compute_pi(interations_sim, scale));

}

// int main(){
//     return tb_return(0);
// }