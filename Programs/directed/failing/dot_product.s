# RV32IM Program: Vector Dot Product
# Uses: mul (M-extension), lw, add, addi, blt (I-extension)

.section .data
vector_a:   .word 1, 2, 3, 4, 5      # Vector A
vector_b:   .word 10, 20, 30, 40, 50 # Vector B
size:       .word 5                  # N = 5
# Expected Result: (1*10)+(2*20)+(3*30)+(4*40)+(5*50) = 550 (0x226)

.section .text
.globl _start

_start:
    li   s0, 0        # Base address of A
    li   s1, 20       # Base address of B
    li  s2, 5            # Load size N
    
    li   t0, 0               # Index i = 0
    li   s3, 0               # Accumulator (sum) = 0

loop:
    bge  t0, s2, done        # If i >= N, exit loop (using signed bge)
    
    # Calculate memory offsets
    slli t1, t0, 2           # t1 = i * 4 (byte offset)
    add  t2, s0, t1          # t2 = address of vector_a[i]
    add  t3, s1, t1          # t3 = address of vector_b[i]
    
    # Load values
    lw   t4, 0(t2)           # t4 = vector_a[i]
    lw   t5, 0(t3)           # t5 = vector_b[i]
    
    # Compute product and accumulate
    mul  t6, t4, t5          # t6 = a[i] * b[i] (RV32M instruction)
    add  s3, s3, t6          # sum = sum + t6
    
    # Increment index
    addi t0, t0, 1           # i++
    j    loop

done:
    mv   a0, s3              # Move final sum to a0 for exit
    li   a7, 93              # Exit syscall
    ebreak




#     # RV32IM Program: Vector Dot Product
# # Uses: mul (M-extension), lw, add, addi, blt (I-extension)

# .section .data
# vector_a:   .word 1, 2, 3, 4, 5      # Vector A
# vector_b:   .word 10, 20, 30, 40, 50 # Vector B
# size:       .word 5                  # N = 5
# # Expected Result: (1*10)+(2*20)+(3*30)+(4*40)+(5*50) = 550 (0x226)

# .section .text
# .globl _start

# _start:
#     la   s0, vector_a        # Base address of A
#     la   s1, vector_b        # Base address of B
#     lw   s2, size            # Load size N
    
#     li   t0, 0               # Index i = 0
#     li   s3, 0               # Accumulator (sum) = 0

# loop:
#     bge  t0, s2, done        # If i >= N, exit loop (using signed bge)
    
#     # Calculate memory offsets
#     slli t1, t0, 2           # t1 = i * 4 (byte offset)
#     add  t2, s0, t1          # t2 = address of vector_a[i]
#     add  t3, s1, t1          # t3 = address of vector_b[i]
    
#     # Load values
#     lw   t4, 0(t2)           # t4 = vector_a[i]
#     lw   t5, 0(t3)           # t5 = vector_b[i]
    
#     # Compute product and accumulate
#     mul  t6, t4, t5          # t6 = a[i] * b[i] (RV32M instruction)
#     add  s3, s3, t6          # sum = sum + t6
    
#     # Increment index
#     addi t0, t0, 1           # i++
#     j    loop

# done:
#     mv   a0, s3              # Move final sum to a0 for exit
#     li   a7, 93              # Exit syscall
#     ecall