
#div and rem
li a1, 53
li a0, 10
 div x20, a1, a0 # 5
 rem x21, a1, a0 # 3
divu x22, a1, a0 # 5
remu x23, a1, a0 # 3
 div x24, a0, a1 # 0
 rem x25, a0, a1 # 10
divu x26, a0, a1 # 0
remu x27, a0, a1 # 10

li a1, 53
li a0, -10
 div x20, a1, a0 # -5
 rem x21, a1, a0 # 3
divu x22, a1, a0 # 0
remu x23, a1, a0 # 53
 div x24, a0, a1 # 0
 rem x25, a0, a1 # -10
divu x26, a0, a1 # 81,037,118
remu x27, a0, a1 # 32

li a1, -53
li a0, 10
 div x20, a1, a0 # -5
 rem x21, a1, a0 # -3
divu x22, a1, a0 # 429,496,724
remu x23, a1, a0 # 3
 div x24, a0, a1 # 0
 rem x25, a0, a1 # 10
divu x26, a0, a1 # 0
remu x27, a0, a1 # 10

li a1, -53
li a0, -10
 div x20, a1, a0 # 5
 rem x21, a1, a0 # -3
divu x22, a1, a0 # 0
remu x23, a1, a0 # -53
 div x24, a0, a1 # 0
 rem x25, a0, a1 # -10
divu x26, a0, a1 # 1
remu x27, a0, a1 # 43

li a0, 23
li a1, -23
 div x20, a0, zero # -1
 rem x21, a0, zero # 23
divu x22, a0, zero # -1
remu x23, a0, zero # 23
 div x24, a1, zero # -1
 rem x25, a1, zero # -23
divu x26, a1, zero # -1
remu x27, a1, zero # -23
 div x20, zero, a0 # 0
 rem x21, zero, a0 # 0
divu x22, zero, a0 # 0
remu x23, zero, a0 # 0
 div x24, zero, a1 # 0
 rem x25, zero, a1 # 0
divu x26, zero, a1 # 0
remu x27, zero, a1 # 0

li a0, 23
li a1, -23
 div x20, zero, zero # -1
 rem x21, zero, zero # 0
divu x22, zero, zero # -1
remu x23, zero, zero # 0
 div x20, a0, a0 # 1
 rem x21, a0, a0 # 0
divu x22, a0, a0 # 1
remu x23, a0, a0 # 0
 div x24, a1, a1 # 1
 rem x25, a1, a1 # 0
divu x26, a1, a1 # 1
remu x27, a1, a1 # 0

li a1, 0x80000000
li a0, -1
 div x20, a1, a0 # -2147483648
 rem x21, a1, a0 # 0
divu x22, a1, a0 # 0
remu x23, a1, a0 # -2147483648
 div x24, a0, a1 # 0
 rem x25, a0, a1 # -1
divu x26, a0, a1 # 1
remu x27, a0, a1 # 2147483647

li a1, 0x80000000
li a0, 0x7FFFFFFF
 div x20, a1, a0 # -1
 rem x21, a1, a0 # -1
divu x22, a1, a0 # 1
remu x23, a1, a0 # 1
 div x24, a0, a1 # 0
 rem x25, a0, a1 # 2147483647
divu x26, a0, a1 # 0
remu x27, a0, a1 # 2147483647

nop
nop
nop
nop
nop
ebreak
nop
nop
nop
nop
nop