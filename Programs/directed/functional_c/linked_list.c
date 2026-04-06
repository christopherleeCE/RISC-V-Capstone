#include "tb.h"
#include "drysoup.h"

typedef struct node_t{
    int data_ptr;
    struct node_t* next_ptr;
}node_t;

int main(){

    node_t* itr = malloc(sizeof(node_t));
    node_t* start = itr;
    node_t* new_itr = 0;

    for(int ii = 0; ii < 10; ++ii){
        itr->data_ptr = 10 + ii;
        itr->next_ptr = malloc(sizeof(node_t));
        itr = itr->next_ptr;
    }

    int ret[10];

    new_itr = start;
    for(int ii = 0; ii < 10; ++ii){
        ret[ii] = new_itr->data_ptr;
        new_itr = new_itr->next_ptr;
    }

    for(int ii = 0; ii < 10; ++ii){
        #ifdef X86_BUILD
        //printf("%d :=: ", ret[ii]);
        #endif
    }

    return tb_return(*ret);
    //return tb_return(pack_ptr(ret, sizeof(ret)/sizeof(ret[0]), false));
}