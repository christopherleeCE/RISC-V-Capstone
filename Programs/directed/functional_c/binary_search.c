/*
A classic algorithm for finding the location of a value inside a sorted
array. Can be implemented with a recursive or iterative approach. Both
approaches are valid. - Edgar G.

*/

#include "tb.h"

int binary_search(int a[], int n, int val);

int main(){
    //a sorted array and a value to search for
    int array[] = {-73, -65, -45, -28, -13, 2, 31, 47, 59, 63, 81, 103, 125, 230};
    int target = 81;

    //call the binary search
    int index = binary_search(array, sizeof(array)/sizeof(array[0]), target);

    return(tb_return(index)); //return the index

}

int binary_search(int a[], int n, int val)
{
    int lo = 0; //initialize the high and low limits
    int hi = n-1;
    
    //Iterative approach - loop until the value is found
    while (hi >= lo)
    {
        int mid = lo + (hi-lo)/2;
        if(a[mid] == val)
            return mid; //return index if midpoint matches

        else if (a[mid] > val)
            hi = mid-1; //shift focus to lower half

        else
            lo = mid-1; //shift focus to upper half
    }

    return -1; //if the value is not found, return -1
}