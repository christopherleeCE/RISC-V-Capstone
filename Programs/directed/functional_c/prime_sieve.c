/*
The Sieve of Eratosthenes, an ancient yet efficient algorithm for identifying all 
prime numbers up to a certain limit. Based on the constant limit declared at the
start of this program, the returned array will hold all the prime integers up to
said limit. If the limit is too small, it will return -1 due to no prime numbers
being present.

-Edgar G.

*/

#include "base.h"
#include "drysoup.h"

#define LIMIT 100 //maximum depends on available memory

int main()
{
    if (LIMIT < 2)
        return tb_return(-1, -1); //return in case of no prime numbers
    else
    {
        int is_prime[LIMIT+1]; //holds which numbers are prime or not
        int prime_count = LIMIT-1; //total prime numbers, remove 0 and 1
        is_prime[0] = is_prime[1] = 0; //0 and 1 removed

        for (int i = 2; i <= LIMIT; i++)
            is_prime[i] = 1; //assume remaining numbers could be prime

        /*
        The algorithm selects a number, then eliminates multiples of said
        number (found w/ addition) since they can't be prime. There are
        several optimizations:

        1. Only need to use this algorithm up to the sqrt of the limit
        2. Even numbers are not primes (except 2)
        3. Don't need to evaluate numbers that we already know aren't primes
            (their multiples will also not be)
        4. Can start from the square of the number being evaluated (smaller
            values will already be covered)
        */

        //start the algorithm
        for(int i = 2; i*i <= LIMIT; i++)
            for(int j = i*i; (j <= LIMIT) && (is_prime[i] != 0); j += i)
                if(is_prime[j] != 0)
                {
                    is_prime[j] = 0; //this value of j is not prime
                    prime_count--; //decrement the total

                }

        //create dynamic array and fill with prime numbers
        int *prime_list = malloc(prime_count*sizeof(int));
        int *list_track = prime_list; //for indexing
        for(int i = 0; i <= LIMIT; i++)
            if(is_prime[i] != 0)
            {
                *list_track = i; //store the prime number
                list_track++; //increment the pointer
            }

        return tb_return(
        *prime_list,
        pack_ptr((uint32_t*)prime_list, prime_count, false)
        );
    }       
}