.data
source: .word 3, 1, 4, 1, 5, 9, 0
dest: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text
la x18, source # load starting address of source to x18
la x19, dest # load starting address of dest to x19

#for (k = 0; source[k] != 0; k++) {
#        dest[k] = source[k];
#    }
addi x20, x0, 0 # k = 0
start_loop:
slli x21, x20, 2 # x21 = k*4 left shifting by 2 is multiplying by 4
add x22, x18, x21 # x22 = starting address of source + k*4
lw x23, 0(x22) # x23 = source[k]
beq x23, x0, exit_loop # source[k] == 0 goto exit_loop

# dest[k] = source[k]
add x22, x19, x21 # x22 = starting address of source + k*4
sw x23, 0(x22) # dest[k] = source[k]

addi x20, x20, 1 # k++

j start_loop

exit_loop:
add x0, x0, x0 # return 0