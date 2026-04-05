#include <stddef.h>
#include <stdint.h>

#define HEADER_TOTAL_SIZE 8
#define HEADER_SIZE_FIELD_SIZE 4
#define HEADER_FLAGS_FIELD_SIZE 4
#define FOOTER_SIZE 4

/*
block overall byte fields
HEADER
    >size field (4bytes)
    >flags field (4bytes)

PAYLOAD
    >full payload (size_t bytes)

FOOTER
    >size field (4bytes) //same as size in header
*/

extern uint8_t _heap_start;
extern uint8_t _heap_end;


//if payload_size is 0, then ret will point to footer, fuck error handling
void* malloc(size_t payload_size){

    //clamp payload_size to multiples of 4
    int mod = payload_size % 4;
    if(mod != 0){
        payload_size = payload_size + (4 - (payload_size % 4));
    }

    uint8_t* heap_start = &_heap_start;
    uint8_t* heap_end = &_heap_end; //exclusive
    uint8_t* header_ptr = heap_start;
    uint32_t old_block_size, next_block_size, new_block_size;

    while(heap_end > header_ptr){ //todo fix this to more safe

        if(*(header_ptr + HEADER_SIZE_FIELD_SIZE) == 0){ //check if  block is occupied

            //save old block size
            old_block_size = *(int32_t*)(header_ptr);

            //write new size to header.size, set to occupied, set footer.size
            *(int32_t*)(header_ptr) = payload_size;
            *((header_ptr) + HEADER_SIZE_FIELD_SIZE) = 1; 
            *(int32_t*)(header_ptr + HEADER_TOTAL_SIZE + payload_size) = payload_size;

            new_block_size = (HEADER_TOTAL_SIZE + payload_size + FOOTER_SIZE);
            next_block_size = old_block_size - new_block_size;

            *(int32_t*)(header_ptr + new_block_size) = next_block_size;
            *((header_ptr + new_block_size) + HEADER_SIZE_FIELD_SIZE) = 0;
            *(int32_t*)((header_ptr + new_block_size) + HEADER_TOTAL_SIZE + next_block_size) = next_block_size;

            return (header_ptr + HEADER_TOTAL_SIZE);
        
        //inc header_ptr to next header if occupied
        }header_ptr += HEADER_TOTAL_SIZE + *(uint32_t*)header_ptr + FOOTER_SIZE;

    }return (void*)-1; //reached end of heap, could not find free memory
}