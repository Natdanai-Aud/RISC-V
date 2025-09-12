.data

A_array: .word 2, 4, 6, 8, 10, 11, 33, 55, 77, 99

.text
la x18, A_array
addi x19, x0, 0 # sum = 0
addi x20, x0, 0 # i = 0
start_loop:
addi x21, x0, 10 # x21 = 10
bge x20, x21, exit_loop # i >= 10 goto exit_loop

# sum += A[i]
slli x22, x20, 2 # x22 = i*4
add x23, x18, x22 # x23 = starting address of A + i*4
lw x24, 0(x23) # x24 = A[i]
add x19, x19, x24 # sum = sum + A[i]
addi x20, x20, 1 # i++
j start_loop

exit_loop:
add x0, x0, x0