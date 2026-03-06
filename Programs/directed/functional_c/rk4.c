/*
This program will use fixed-point arithmetic and the fourth-order Runge-Kutta method
(RK4) to solve a first-order ODE and return a value from the solution. Not the most elegant
approach, but should demonstrate the capabilities of our processor if it works properly.
- Edgar G.

This is an initial value problem I used from LibreTexts:
y'(t) = t^2 + 1
y (1) = 4

The given solution is y(t) = (t^3)/3 + t + 8/3
For multiple values of t:

@ t = 2 : 7.333...
@ t = 3 : 14.666...
@ t = 4 : 28.000
@ t = 5 : 49.333...

GOAL: Can the CPU estimate some of these values using RK4 method?
VERDICT: Yes! Messing around with the value of the step and scale factor influences a balance
between the precision, accuracy, and speed of the computation.

NOTE: When reading the result, note that the three rightmost values in the output are the values
that come after the decimal (as set by the conversion function at the bottom).

*/

#include "tb.h"


//USER INPUT HERE: -------------------------------------------------------------------------------
//BASE 2 (faster):
#define SCALE 512 //scale factor for fixed-point arithmetic
#define H 0.015625 //step - NOTE: must be larger than 1/SCALE

// //BASE 10 (legacy)
// #define SCALE 1000 //scale for fixed_point
// #define H 0.01 //step - NOTE: must be larger than 1/SCALE


#define T_0 1 //initial condition
#define Y_0 4
#define T (T_0+H) //final time
//NOTE - Would recommended leaving this as a small value (t = t0 + H) to reduce runtime for
//regression testing

//Please do not mess with the following! --------------------------------------------------------
//Let's solve some constants now to save division and multiplication
//The compiler will handle this constant arithmetic
#define T_0_SCALE (T_0*SCALE)
#define Y_0_SCALE (Y_0*SCALE)
#define T_SCALE (T*SCALE)
#define H_SCALE (H*SCALE)
#define H_HALF (H/2)
#define H_HALF_SCALE (H_HALF*SCALE)

//-----------------------------------------------------------------------------------------------

int dy_dt(int y, int t); //func prototypes
int y_new(int y, int t);
int convert(int a);

//Main body
int main() 
{
    int y = Y_0_SCALE; //intial value provided

    //iterate until the desired time is reached
    for(int t = T_0_SCALE; t <= T_SCALE; t += H_SCALE)
    {
        y = y_new(y, t);
    }

    //return the estimated value of the solution
    return tb_return(convert(y));
}

//The ordinary differential equation
int dy_dt(int y, int t) 
{
    //appropiate scaling required when multiplying fixed points
    // 1*SCALE is just SCALE
    return (t*t)/SCALE + SCALE;
}

//RK4 to estimate the next value 
int y_new(int y, int t)
{
    //Simplification of constants done where possible:
    //ex. H_HALF_SCALE = (H*SCALE / 2)

    int k1 = dy_dt(y, t); //find all the terms needed
    int k2 = dy_dt(y + (k1*H_HALF_SCALE)/SCALE, t + H_HALF_SCALE);
    int k3 = dy_dt(y + (k2*H_HALF_SCALE)/SCALE, t + H_HALF_SCALE);
    int k4 = dy_dt(y + k3*H_SCALE, t + H_SCALE);

    //A bit of redundancy to not multiply by a decimal (no floats!)
    return y + (H_SCALE*(k1 + 2*k2 + 2*k3 + k4))/(6*SCALE);
}

/*
Using base 2 values for the step and scaling constants is more optimal for speed
as the compiler will generate single instruction shifts. However, I chose to convert the
final value to base 10 for readibility (this is faster than using base 10 values in the
math itself). This function will retrieve the final answer and convert it to base 10.
*/

int convert(int a)
{
    return ((a*1000)/SCALE);
}