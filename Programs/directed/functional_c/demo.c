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

//doesnt handle non negative values, trying to reduce instr_rom size
// float my_pow(float x, int exp){
//     float ret = 1;

//     for(int ii = 0; ii < exp; ++ii){
//         ret *= x;

//     }return ret;
// }

// int my_factorial(int x){

//     int ret = 1;

//     for(int ii = 1; ii <= x; ++ii){

//         ret *= ii;

//     }return ret;
// }

//angle, and itrations, more increase compuational time
// float my_sin(float rads, int itr){

//     float ret = 0.0f;
//     int temp;

//     for(int ii = 0; ii < itr; ++ii){

//         temp = ii*2;
//         ++temp;

//         ret += (1 - 2*(ii%2))*(my_pow(rads, temp) / my_factorial(temp));
//     }

//     return ret;
// }

// float my_cos(float rads, int itr){
        
//     float ret = 0.0f;
//     int temp;

//     for(int ii = 0; ii < itr; ++ii){

//         temp = ii*2;

//         ret += (1 - 2*(ii%2))*(my_pow(rads, temp) / my_factorial(temp));
//     }

//     return ret;
// }

int main() {
    // SCALE = 1,000,000 for fixed-point precision
    int scale = 1000000;
    int pi_interations = 1000; //1000 takes ~20 seconds to calculate pi
    int trig_interations = 5; //above 6 or 7 (jajaja) will cause factorial overflow

    int scaled_pi;
    float float_pi;

    scaled_pi = compute_pi(pi_interations, scale);
    float_pi = (float)scaled_pi / (float)scale;

    float magnitude = 7;
    float angle = float_pi * .3;

    return tb_return(angle);

    // float sin_val = my_sin(angle, 5);
    // // float cos_val = my_cos(angle, 5);

    // float y_vector = sin_val * magnitude;
    // // float y_vector = cos_val * magnitude;

    // //printf("%.2f units with an angle of %.2f radians\n", magnitude, angle);
    // //printf("in cartesian cordinates, <%.2f, %.2f>\n", x_vector, y_vector);

    // return tb_return(y_vector);

}

// int main(){
//     return tb_return(0);
// }