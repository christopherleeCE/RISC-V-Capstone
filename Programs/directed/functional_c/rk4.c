/*
This program will use fixed-point arithmetic and the fourth-order Runge-Kutta method
(RK4) to solve a first-order ODE and return a value from Not the most elegant approach, but should demonstrate the capabilities of our 
processor if it works properly. - Edgar G.

This is an initial value problem I used from LibreTexts:
y'(t) = t^2 + 1
y (1) = 4

The given solution is y(t) = (t^3)/3 + t + 8/3

@ t = 2 : 7.333...
@ t = 3 : 14.666...
@ t = 4 : 28.000
@ t = 5 : 49.333...

NOTE: When reading the result, note that the rightmost values (number depends on scale)
are the values after the decimal.

GOAL: The CPU should estimate similar values of the solution at these values for t.

VERDICT: It works!! Please be warned, it takes quite a while to run (about 8 minutes @ t = 3).
There is room for optimization. Only choose larger values of t if you have the time to wait!

*/

#include "tb.h"

//USER INPUT HERE: -------------------------------------------------------------------------------
#define SCALE 1000 //scale for fixed_point

#define H 0.01 //step - NOTE: must be larger than 1/SCALE
#define T_0 1 //initial condition
#define Y_0 4
#define T 3 //final time

//Please do not mess with the following! --------------------------------------------------------
//Let's solve some constants now to save division and multiplication
//The compiler will handle this constant arithmetic
#define T_0_SCALE (T_0*SCALE)
#define Y_0_SCALE (Y_0*SCALE)
#define T_SCALE (T*SCALE)
#define H_SCALE (H * SCALE)
#define H_HALF (H/2)
#define H_HALF_SCALE (H_HALF*SCALE)

//-----------------------------------------------------------------------------------------------

int dy_dt(int y, int t); //func prototypes
int y_new(int y, int t);

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
    return tb_return(y);
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
    /*
    Simplification of constants done where possible:
    ex. H_HALF_SCALE = (H*SCALE / 2)
    However, the multiplication then integer division by scale is still used in 
    certain areas to avoid using floating point (no decimals in equation)
    */

    int k1 = dy_dt(y, t); //find all the terms needed
    int k2 = dy_dt(y + (k1*H_HALF_SCALE)/SCALE, t + H_HALF_SCALE);
    int k3 = dy_dt(y + (k2*H_HALF_SCALE)/SCALE, t + H_HALF_SCALE);
    int k4 = dy_dt(y + k3*H_SCALE, t + H_SCALE);

    return y + (H_SCALE*(k1 + 2*k2 + 2*k3 + k4))/(6*SCALE);
}