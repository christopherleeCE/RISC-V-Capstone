#include <stdint.h>
#include "tb.h"

// volatile int32_t pi_scaled_result;

// // Computes pi scaled by SCALE (fixed-point style)
// int32_t compute_pi(int iterations, int32_t SCALE) {
//     int32_t sum = 0;

//     for (int k = 0; k < iterations; k++) {
//         int32_t denom = 2 * k + 1;

//         // term = SCALE / denom
//         int32_t term = SCALE / denom;   // forces div

//         if (k % 2 == 0) {               // forces rem
//             sum += term;
//         } else {
//             sum -= term;
//         }
//     }

//     return 4 * sum;
// }

// int main() {
//     // SCALE = 1,000,000 for fixed-point precision
//     return tb_return(compute_pi(1000, 1000000));

// }

int main(){
    return tb_return(0);
}