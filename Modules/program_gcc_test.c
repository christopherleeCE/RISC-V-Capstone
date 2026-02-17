// ----- Global initialized (goes to .data)
int global_counter = 42;
int global_array[4] = {1, 2, 3, 4};

// ----- Global uninitialized (goes to .bss)
int global_uninit;
int global_buffer[128];

// ----- Read-only data (goes to .rodata)
const int const_value = 99;
const char message[] = "RISC-V Capstone";

// Function prototypes (forces symbol entries)
int add(int a, int b);
int compute_sum(int *arr, int len);

// ----- Function definitions (go to .text)
int add(int a, int b) {
    return a + b + const_value;
}

int compute_sum(int *arr, int len) {
    int sum = 0;
    for (int i = 0; i < len; i++) {
        sum += arr[i];
    }
    return sum;
}

void touch_bss(void) {
    global_uninit = 5;
    global_buffer[0] = 1234;
}

// Entry point
void _start(void) __attribute__((naked, used));
void _start(void) {
    __asm__ volatile (
        "li sp, 0x1000\n"
        "j main\n"
    );
}

int main(void) {
    touch_bss();

    int result1 = add(global_counter, global_array[0]);
    int result2 = compute_sum(global_array, 4);

    return result1 + result2;
}


