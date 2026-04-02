/*
The DSA code is from this Portfolio Courses video on merge sort, with modifications
for use with our CPU:
https://youtu.be/LeWuki7AQLo?si=1c2gT5H4RX5Ki1ly

Big thanks to them as well as other web resources for their help with understanding
these concepts!

This program implements the merge sort algorithm to order an array of numbers.
It should then return the range of values within the array. Merge sort is pretty
neat since it has a time complexity of O(nlog(n)) regardless of best, worst, or
average case scenario, so pretty consistent.

-Edgar G.

UPDATE - ONLY RETURNS FIRST VALUES OF ARRAY - some strange behavior? It seems like
the algorithm itself works! We have no issues retrieving the first few values from
the sorted array (like first 3). However, trying to retrieve the larger values
(test_array[length-1]) seems to return garbage values. This issue is not present 
when the program is compiled and executed on my PC. Maybe something to do with the
way memory is mapped for our CPU, just a guess, but strange...

*/

#include "tb.h"
#include "drysoup.h"

//function prototypes
void merge_sort(int a[], int length);
void merge_sort_recursion(int a[], int l, int r);
void merge_sorted_arrays(int a[], int l, int m, int r);
int range(int a[], int length);


int main()
{
    //------------------------------USER INPUT -------------------------------------------
    //Implement your array in here
    int test_array[] = {-9, 25, 31, -16, 37, 9, -81, 15, -95, 73};

    //------------------------------------------------------------------------------------

    int length = sizeof(test_array)/sizeof(test_array[0]); //find array length

    merge_sort(test_array, length); //call the merge sort function

    // #ifdef X86_BUILD
    // for(int ii = 0; ii < sizeof(test_array)/sizeof(test_array[0]); ii++)
    //     printf("%d\n", test_array[ii]);
    // #endif

    return tb_return(range(test_array, length)); //return the length of the array
    //return tb_return(pack_ptr((uint32_t)test_array, length, false));
}

void merge_sort(int a[], int length)
{
    //start with the entire array
    merge_sort_recursion(a, 0, length - 1);
}

void merge_sort_recursion(int a[], int l, int r)
{
    if (l < r) //continue until array can't be divided further
    {
        int m = l + (r - l)/2; //find the midpoint of the subarray

        //continue splitting the array using recursion
        //The smallest possible array (1 value) is already sorted
        merge_sort_recursion(a, l, m); //left side
        merge_sort_recursion(a, m + 1, r); //right side

        merge_sorted_arrays(a, l, m, r); //merge the sorted subarray
    }
}

void merge_sorted_arrays(int a[], int l, int m, int r)
{
    int left_length = m - l + 1; //length of left portion of array
    int right_length = r - m; //length of the right portion of array

    //temporary arrays
    int temp_left[left_length];
    int temp_right[right_length];

    int i, j, k;

    //copy the left/right portions into temporary arrays
    for (int i = 0; i < left_length; i++)
        temp_left[i] = a[l + i];

    for (int i = 0; i < right_length; i++)
        temp_right[i] = a[m + 1 + i];

    //NOTE: at this point, the left and right temporary arrays
    //are both sorted.

    //This section takes an element from either the left or right
    //temporary arrays and appends it to a bigger array
    
    //i, j, and k are trackers
    //i: left subarray
    //j: right subarray
    //k: main array
    for (i = 0, j = 0, k = l; k <= r; k++)
    {
        //This condition chooses the next smallest element from
        //either temporary array to append to array 'a':
        //temp_left[i] <= temp_right[j]

        //This condition will automatically add from the left
        //array if the end has been reached for the right array:
        //j >= right_length

        //On the contrary, this will automatically add from the
        //right array if the end has been reached for left array:
        //(i < left_length)

        if ((i < left_length) &&
        ((j >= right_length) || temp_left[i] <= temp_right[j]))
        {
            a[k] = temp_left[i];
            i++;
        } else {
            a[k] = temp_right[j];
            j++;
        }
    }
}

//for calculating the range of the array
int range(int a[], int length)
{
    return (a[length-1] - a[0]);
}