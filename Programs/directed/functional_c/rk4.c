/*
This program will use fixed-point arithmetic and the fourth-order Runge-Kutta method
(RK4) to solve a first-order ODE and return a value from Not the most elegant approach, but should demonstrate the capabilities of our 
processor if it works properly. - Edgar G.

This is an initial value problem I used from LibreTexts:
y'(t) = t^2 + 1
y (1) = 4

The given solution is y(t) = t^3 + t + 8/3

Because the CPU outputs one
@ t = 3 : 14.667
@ t = 5 : 49.333
@ t = 10 : 346
@ t = 20 : 2,689.333

NOTE: When reading the result, note that the rightmost values (number depends on scale)
are the values after the decimal.

VERDICT: It works!! Please be warned, even at t = 3, it takes quite a while to run (about
8 minutes). Only choose larger values of t if you have the time to wait!

*/

#include "tb.h"
#define SCALE 1000

/*
The scale was determined through trial and error. This value has decent precision: going higher seems
to trigger overflow, and going lower seems to lose precision. This scale seems to produce the highest
accuracy results for this problem.
*/

#define H 0.01 //define some constants for the ODE
#define T_0 1 
#define Y_0 4
#define T 1.01 //adjust the time value to retrieve the associated value from the solution.
//Note: for regression testing, leave as a small value to reduce total runtime

int dy_dt(int y, int t); //func prototypes
int y_new(int y, int t);

//Main body
int main() 
{
    int y = Y_0*SCALE; //intial value provided

    //iterate until the desired time is reached
    for(int t = T_0*SCALE; t <= T*SCALE; t += H*SCALE)
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
    return (t*t)/SCALE + 1*SCALE;
}

//RK4 to estimate the next value 
int y_new(int y, int t)
{
    int k1 = dy_dt(y, t); //find all the 
    int k2 = dy_dt(y + (k1*((H*SCALE)/2))/SCALE, t + ((H*SCALE)/2));
    int k3 = dy_dt(y + (k2*((H*SCALE)/2))/SCALE, t + ((H*SCALE)/2));
    int k4 = dy_dt(y + (k3*(H*SCALE))/SCALE, t + (H*SCALE));

    return y + (((k1 + 2*k2 + 2*k3 + k4)/6)*(H*SCALE))/SCALE;
}