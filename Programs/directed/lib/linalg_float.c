#include "linalg_float.h"

//function to solve the linear system
//WARNING: will overwrite parts of both arrays
void solve(int n, float a[n][n], float b[n])
{
    gaussian_elim(n, a, b); //overwrites lower triangle w/ multipliers
    back_sub(n, a, b); //solve w/ substitution, overwrite b w/ solution
}

//subroutine for gaussian elimination w/partial pivoting
//this helps reduce rounding errors
void gaussian_elim(int n, float a[n][n], float b[n])
{
    for (int k = 0; k < n-1; k++)
    {
        //PARTIAL PIVOTING
        float temp_val = 0; //temporary value
        float max_val = 0; //maximum value for partial pivoting
        int max_in = 0; //index of maximum value

        //search for the row with the largest pivot absolute value
        for (int i = k; i < n; i++)
            if ((temp_val = a[i][k]) > max_val || temp_val < -max_val)
            {
                max_in = i; //update previous values
                max_val = temp_val;
            }

        //swap rows so that the pivot value has the largest value
        //apply to both A and b
        if (max_in > k)
            for (int j = k; j < n; j++)
            {
                temp_val = a[k][j];
                a[k][j] = a[max_in][j];
                a[max_in][j] = temp_val;

                temp_val = b[k];
                b[k] = b[max_in];
                b[max_in] = temp_val;
            }

        //GAUSSIAN ELIMINATION
        //
        for (int i = k+1; i < n; i++) //iterate through each row
        {
            a[i][k] = a[i][k]/a[k][k]; //pivot column in A

            for (int j = k+1; j < n; j++) //iterate through remaining columns
                a[i][j] -= a[i][k]*a[k][j];

            b[i] -= a[i][k]*b[k]; //row operation on b 
        }
    }
}

//subroutine for back substitution
void back_sub(int n, float a[n][n], float b[n])
{
    float temp_val = 0;

    b[n-1] /= a[n-1][n-1];
    for (int i = n-2; i >= 0; i--)
    {
        temp_val = 0; //reset value
        for(int j = i+1; j < n; j++)
            temp_val += a[i][j]*b[j]; //summation
        b[i] = (b[i] - temp_val)/a[i][i];
    }
}