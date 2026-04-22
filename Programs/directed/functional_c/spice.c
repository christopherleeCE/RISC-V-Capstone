/*
This program will solve a linear circuit and find the voltage at all nodes. It 
is based off the stamping algorithm we learned in EEE419. This is known as modified
nodal analysis. This program also reuses the linear algebra functions implemented
previously.

- Edgar G.
*/

#include "base.h"
#include "drysoup.h"
#include "linalg_float.h"

//for holding components and parameters
enum comp_names {VS = 0, IS, RES};
struct component 
{
    int name, i, j;
    float val;
};

//prototypes
void stamp(int comp_count, struct component components[comp_count], int nodes, int size,
            float a[size][size], float b[size]);


int main()
{

    /*USER INPUT HERE ---------------------------------------------------------------
    This is where you list your components in the following format:
    {type of component, node i, node j, value of component}
    */

    struct component components[] =
    {
        //expected result:
        //[v1 = 13.000V, v2 = 13.966V, v3 = 17.925V, Is = 8.05e-5 A]
        {VS, 1, 0, 13},
        {RES, 1, 2, 12e3},
        {RES, 2, 0, 56e3},
        {RES, 2, 3, 12e3},
        {RES, 3, 0, 56e3},
        {IS, 0, 3, 0.65e-3}
    };

    //An example circuit from EEE419:
    //expected result [3, 1.5, 1.5, 3, -4.5, -4.5]

    // {VS, 1, 0, 3},
    // {RES, 1, 0, 1},
    // {RES, 1, 2, 1},
    // {RES, 2, 0, 1},
    // {RES, 2, 3, 1},
    // {RES, 3, 0, 1},
    // {RES, 3, 4, 1},
    // {RES, 4, 0, 1},
    // {VS, 4, 0, 3}


    //-------------------------------------------------------------------------------


    // find the total number of nodes and sources
    int nodes = 0;
    int sources = 0;

    //scan the entire list of components
    for(int entry = 0; entry < sizeof(components)/sizeof(components[0]); entry++)
    {
        if (components[entry].name == VS)
            sources++; //find the total voltage sources
        if (components[entry].i > nodes)
            nodes = components[entry].i; //determine the total number of nodes
        if (components[entry].j > nodes)
            nodes = components[entry].j;
    }

    int size = nodes + sources; //size of matrices is the sum of nodes and sources
    
    float a[size][size], b_x[size]; //admittance, current (later voltage) matrices
    for(int i = 0; i <= size-1; i ++) //assign zeroes, no garbage values here!
    {
        b_x[i] = 0;
        for(int j = 0; j <= size-1; j++)
            a[i][j] = 0;
    }

    //stamp the matrices
    stamp(sizeof(components)/sizeof(components[0]), components, nodes, size, a, b_x);
    solve(size, a, b_x); //solve the system

    return(tb_return(
        b_x[0],
        pack_ptr((uint32_t*)b_x, size, false))
    );
}


//this function will stamp the admittance and current matrices
void stamp(int comp_count, struct component components[], int nodes, int size,
            float a[size][size], float b[size])
{
    int m = nodes; //use to manage voltage sources
    for(int entry = 0; entry <= comp_count-1; entry++) //move through list
    {
        int i = components[entry].i-1; //offset for zero-based indexing
        int j = components[entry].j-1;

        /*
        Single line if-statements ensure we don't write any entries for
        the ground node. Please let me know if there is a more efficient
        approach to do this.
        */

        if (components[entry].name == VS) //pattern for voltage source
        {

            if (i >= 0 ) a[m][i] = 1 ;  
            if (i >= 0 ) a[i][m] = 1;
            if (j >= 0 ) a[m][j] = -1;
            if (j >= 0 ) a[j][m] = -1; 
            b[m] = components[entry].val;
            m++;
        }
        else if (components[entry].name == IS) //pattern for current source
        {
            if (i >= 0) b[i] -= components[entry].val;
            if (j >= 0) b[j] += components[entry].val;
        }
        else if (components[entry].name == RES) //pattern for resistor
        {
            float admittance = 1/components[entry].val;
            if (i >= 0) a[i][i] += admittance;
            if (j >= 0) a[j][j] += admittance;
            if (i >= 0 && j >= 0) a[i][j] -= admittance;
            if (i >= 0 && j >= 0) a[j][i] -= admittance;
        }
    }
}