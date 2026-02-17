// minimal_test.c
__attribute__((naked, used)) 
void _start(void) {
    __asm__ volatile (
        "li sp, 0x100\n"   // initialize stack pointer
        "jal ra, main\n"    // call main, ra points to ebreak
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "ebreak\n"          // stop simulation when main returns
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
        "nop\n"
    );
}

int main() {
    int n = 5, i = 0, t1 = 0, t2 = 1, nextTerm;

    while (i < n) {
        if (i <= 1) {
            nextTerm = i;
        } else {
            nextTerm = t1 + t2;
            t1 = t2;
            t2 = nextTerm;
        }
        i++;
    }

    return nextTerm;
}