#ifndef X86_BUILD //prevent custom func defn in x86build, gcc will then default to automatic inclusion og glibc

    #include <stddef.h>
    #include <stdint.h>
    #include <stdbool.h>
    #include "drysoup.h"

    #define HEADER_TOTAL_SIZE 8
    #define HEADER_SIZE_FIELD_SIZE 4
    #define HEADER_FLAGS_FIELD_SIZE 4
    #define FOOTER_SIZE 4

    /* TODO, use ifdef to include stdlib malloc instead
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

    //TODO check if this needs updated
    //if payload_size is 0, then ret will point to footer, fuck error handling
    void* malloc(size_t payload_size){

        //clamp payload_size to multiples of 4
        int mod = payload_size % 4;
        if(mod != 0){
            payload_size = payload_size + (4 - mod);
        }

        uint8_t* heap_start = &_heap_start;
        uint8_t* heap_end = &_heap_end; //exclusive
        uint8_t* header_ptr = heap_start;

        bool same_size, valid_bigger_size;

        while(heap_end > header_ptr){ //todo fix this to more safe

            same_size = (*(size_t*)(header_ptr) == payload_size);
            valid_bigger_size = (*(size_t*)(header_ptr) >= (payload_size + HEADER_TOTAL_SIZE + FOOTER_SIZE));

            //check if  block is occupied & size is equal to, or large enuf to fit 2nd half of split
            if((*(header_ptr + HEADER_SIZE_FIELD_SIZE) == 0) & (same_size | valid_bigger_size)){

                //save old block size
                size_t old_payload_size = *(size_t*)(header_ptr);

                //write new size to header.size, set to occupied, set footer.size
                *(size_t*)(header_ptr) = payload_size;
                *((header_ptr) + HEADER_SIZE_FIELD_SIZE) = 1; 
                *(size_t*)(header_ptr + HEADER_TOTAL_SIZE + payload_size) = payload_size;

                //if we need to, allocate a free second block
                if(valid_bigger_size){
                    size_t new_block_size = (HEADER_TOTAL_SIZE + payload_size + FOOTER_SIZE);
                    size_t next_payload_size = old_payload_size - new_block_size; //old_payload_size - payload_size - header&footer

                    uint8_t* next_header_addr = header_ptr + new_block_size;
                    //write header, set to unoccoupied, set footer.size for second half of split block
                    *(size_t*)(next_header_addr) = next_payload_size;
                    *(next_header_addr + HEADER_SIZE_FIELD_SIZE) = 0;
                    *(size_t*)(next_header_addr + HEADER_TOTAL_SIZE + next_payload_size) = next_payload_size;

                //return ptr to allocated block
                }return (header_ptr + HEADER_TOTAL_SIZE);
            
            //inc header_ptr to next header if occupied
            }header_ptr += HEADER_TOTAL_SIZE + *(size_t*)header_ptr + FOOTER_SIZE;

        }return NULL; //reached end of heap, could not find free memory
    }

    void* calloc(size_t count, size_t element_size){

        size_t total = count*element_size;

        //clamp total to multiples of 4
        int mod = total % 4;
        if(mod != 0) {total = total + (4 - mod);}

        uint32_t* ret_ptr = malloc(total);

        if(ret_ptr == NULL) {return NULL;}

        total = total / 4;
        for(size_t ii = 0; ii < total; ++ii){
            *(ret_ptr + ii) = 0;

        }return ret_ptr;
    }

    void* realloc(void* ptr, size_t new_size){

        if(ptr == NULL){ //if ptr is NULL, just malloc
            return malloc(new_size);

        }size_t old_size = *(size_t*)((uint8_t*)ptr - HEADER_TOTAL_SIZE);

        if(new_size == 0){ //just free ptr
            free(ptr);
            return NULL;

        }else if(new_size <= old_size){ //just return ptr, (no action)
            return ptr;

        }else{ //actually reallocate
            uint8_t* ret_ptr = malloc(new_size);

            //dont copy data if malloc failed
            if (ret_ptr == NULL) {return NULL;}

            //copy over old data
            for(size_t ii = 0; ii < old_size; ++ii){
                *(ret_ptr + ii) = *((uint8_t*)ptr + ii);

            }free(ptr);
            return ret_ptr;
        }
    }

    void free(void* ptr){

        uint8_t* heap_start = &_heap_start;
        uint8_t* header_ptr = ptr - HEADER_TOTAL_SIZE;

        size_t mid_blk_tot_size = (HEADER_TOTAL_SIZE + *(size_t*)header_ptr + FOOTER_SIZE);
        size_t new_size;
        uint8_t* prev_blk_header_addr;
                                //next blk header.size  //middle blk total size  //middle blk headerprt
        bool next_free = !*(bool*)((HEADER_SIZE_FIELD_SIZE) + mid_blk_tot_size + (header_ptr)); //next blk status

        bool prev_free = 0; //if at start of heap, dont check prev blk
        if(header_ptr != heap_start){
            size_t prev_blk_pl_size = *(header_ptr - FOOTER_SIZE);
            prev_blk_header_addr = header_ptr - FOOTER_SIZE - prev_blk_pl_size - HEADER_TOTAL_SIZE;

                                //middle hptr  //prev footer  //prev blk payload size  //prev blk header.flags
            prev_free = !*(bool*)((header_ptr) - FOOTER_SIZE - prev_blk_pl_size - HEADER_FLAGS_FIELD_SIZE); //prev blk status
        }
        //return (next_free << 16) | (prev_free & 0xFFFF);
        if(!next_free & !prev_free){
            *((uint8_t*)ptr - HEADER_FLAGS_FIELD_SIZE) = 0;

        }else if(!next_free & prev_free){
            new_size = *(size_t*)(header_ptr) + *(size_t*)(prev_blk_header_addr) + HEADER_TOTAL_SIZE + FOOTER_SIZE;
            *(size_t*)(prev_blk_header_addr) = new_size;
            *(size_t*)(*(size_t*)header_ptr + HEADER_TOTAL_SIZE + header_ptr) = new_size;
            *((uint8_t*)prev_blk_header_addr + HEADER_SIZE_FIELD_SIZE) = 0;
            
            
        }else if(next_free & !prev_free){
            uint8_t* next_blk_header_addr = mid_blk_tot_size + header_ptr;
            new_size = *(size_t*)(next_blk_header_addr) + *(size_t*)(header_ptr) + HEADER_TOTAL_SIZE + FOOTER_SIZE;
            *(size_t*)(header_ptr) = new_size;
            *(size_t*)(*(size_t*)(next_blk_header_addr) + HEADER_TOTAL_SIZE + next_blk_header_addr) = new_size;
            *((uint8_t*)ptr - HEADER_FLAGS_FIELD_SIZE) = 0;

        }else if(next_free & prev_free){
            uint8_t* next_blk_header_addr = mid_blk_tot_size + header_ptr;
            new_size = *(size_t*)(next_blk_header_addr) + *(size_t*)(header_ptr) + *(size_t*)(prev_blk_header_addr) + 2*(HEADER_TOTAL_SIZE + FOOTER_SIZE);
            *(size_t*)(prev_blk_header_addr) = new_size;
            *(size_t*)(*(size_t*)(next_blk_header_addr) + HEADER_TOTAL_SIZE + next_blk_header_addr) = new_size;
            *((uint8_t*)prev_blk_header_addr + HEADER_SIZE_FIELD_SIZE) = 0;
            
        }
    }

#endif