int sum(int x, int y);

void _start() __attribute__((naked, used));
void _start() {
    __asm__ volatile (
        "li sp, 0x80\n"  // initialize stack pointer
        "j main\n"             // jump to main
    );
}


int main() {
    int a = 5;
    int b = 10;
    int c = a + b;
    return c;
}

/*

00000000 <main>:
   0:   fe010113                addi    sp,sp,-32
   4:   00812e23                sw      s0,28(sp)
   8:   02010413                addi    s0,sp,32
   c:   00500793                li      a5,5
  10:   fef42623                sw      a5,-20(s0)
  14:   00a00793                li      a5,10
  18:   fef42423                sw      a5,-24(s0)
  1c:   fec42703                lw      a4,-20(s0)
  20:   fe842783                lw      a5,-24(s0)
  24:   00f707b3                add     a5,a4,a5
  28:   fef42223                sw      a5,-28(s0)
  2c:   fe442783                lw      a5,-28(s0)
  30:   00078513                mv      a0,a5
  34:   01c12403                lw      s0,28(sp)
  38:   02010113                addi    sp,sp,32
  3c:   00008067                ret

*/

// TODO sw failured
// int sum(int x, int y) {
//     int s = x + y;
//     int t = s * 2;  // another local variable
//     return t;
// }

// int main() {
//     int a = 5;
//     int b = 10;
//     int c = sum(a, b);
//     int d = sum(c, a);
//     return d;
// }



// int main() {

//     int a = 5;
//     int b = 10;
//     int c = sum(a, b);
//     int d = sum(c, a);
//     return d;
// }

// int sum(int x, int y) {
//     int s = x + y;
//     int t = s * 2;  // another local variable
//     return t;
// }