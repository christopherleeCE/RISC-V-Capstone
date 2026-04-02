#include <stdint.h>
#include "tb.h"
#include "drysoup.h"

// Computes pi scaled by SCALE (fixed-point style)
uint64_t compute_pi(int iterations, uint64_t SCALE) {
    uint64_t sum = 0;

    for (int k = 0; k < iterations; k++) {
        uint64_t denom = 2 * k + 1;

        // term = SCALE / denom
        uint64_t term = SCALE / denom;   // forces div

        if (k % 2 == 0) {               // forces rem
            sum += term;
        } else {
            sum -= term;
        }
    }

    return 4 * sum;
}

//doesnt handle non negative values, trying to reduce instr_rom size
float my_pow(float x, int exp){
    float ret = 1;

    for(int ii = 0; ii < exp; ++ii){
        ret *= x;

    }return ret;
}

int64_t my_factorial(int x){

    int64_t ret = 1;

    for(int ii = 1; ii <= x; ++ii){

        ret *= ii;

    }return ret;
}

//angle, and itrations, more increase compuational time
float my_sin(float rads, int itr){

    float ret = 0.0f;
    int temp;

    for(int ii = 0; ii < itr; ++ii){

        temp = ii*2;
        ++temp;

        ret += (1 - 2*(ii%2))*(my_pow(rads, temp) / my_factorial(temp));
    }

    return ret;
}

float my_cos(float rads, int itr){
        
    float ret = 0.0f;
    int temp;

    for(int ii = 0; ii < itr; ++ii){

        temp = ii*2;

        ret += (1 - 2*(ii%2))*(my_pow(rads, temp) / my_factorial(temp));
    }

    return ret;
}

int main() {
    // SCALE = 1,000,000 for fixed-point precision
    uint64_t scale = 1000000000000; //havent seen an overflow with this
    uint64_t pi_interations = 1000;//1000; //use 100000 in deployment
    int trig_interations = 10; //above 6 or 7 (jajaja) will cause factorial overflow

    uint64_t scaled_pi;
    float float_pi;

    scaled_pi = compute_pi(pi_interations, scale);
    float_pi = (float)scaled_pi / (float)scale;

    float magnitude = 7;
    float angle = float_pi * 1.67;

    float cos_val = my_cos(angle, trig_interations);
    float sin_val = my_sin(angle, trig_interations);

    float x_vector = cos_val * magnitude;
    float y_vector = sin_val * magnitude;

    // #ifdef X86_BUILD
    //     //printf("float_pi: %f\n", float_pi);
    //     printf("[%f, %f, %f, %f]\n", cos_val, sin_val, x_vector, y_vector);
    //     //printf("%.2f units with an angle of %.2f radians\n", magnitude, angle);
    // #endif
    
    return tb_return(rf2i(x_vector));

}

// int main(){
//     return tb_return(0);
// }