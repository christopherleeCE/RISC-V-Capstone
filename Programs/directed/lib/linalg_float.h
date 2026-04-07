//declare functions
#ifndef LINALG_FLOAT_H

#define LINALG_FLOAT_H

void solve(int n, float a[n][n], float b[n]);
void gaussian_elim(int n, float a[n][n], float b[n]);
void back_sub(int n, float a[n][n], float b[n]);

#endif