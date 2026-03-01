#include "tb.h"

int main() {

    //needs bgeu to work properly, commented out for now to prevent error being thrown

    float pi = 3.14;
    float r = 13.7;

    float area = pi * r * r;
    float area_times_100 = area * 100;

    return tb_return(area_times_100);
    // return tb_return(0);
}