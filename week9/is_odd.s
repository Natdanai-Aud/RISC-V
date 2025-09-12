main:
li x19, 53 # x19 = 53
addi sp, sp, -4 # allocate 4 bytes on the stack
sw x19, 0(sp) # push x19
jal is_odd # call is_odd
addi sp, sp, 4 # deallocate 4 bytes on the stack
add x18, x0, a0 # result (x18) = is_odd(53)

# return 0 from main
addi a0, x0, 10 # exit call OS emulation
add a1, x0, x0# exit call OS emulation
ecall # exit call OS emulation


is_odd:
lw x18, 0(sp) # x18 = x
andi x19, x18, 0x1 # temp1 (x19) = x & 0x1
li x20, 1 # temp2 (x20) = 1
bne x19, x20, else_part # if (x & 0x1) != 1 goto else_part
# return 1
li a0, 1
jr ra

else_part:
# return 0
li a0, 0
jr ra