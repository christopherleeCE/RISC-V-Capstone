#include "tb.h"

volatile int num = 3;
volatile int num1 = 13;
volatile int num2 = 23;
volatile int num3 = 33;
volatile int num4 = 43;
volatile int num5 = 53;
volatile int num6 = 63;
volatile int num7 = 73;

int main(){

    int x = 7 + num;
    x = 7 + num1;
    x = 7 + num2;
    x = 7 + num3;
    x = 7 + num4;
    x = 7 + num5;
    x = 7 + num6;
    x = 7 + num7;

    return tb_return(num * num2);

}
