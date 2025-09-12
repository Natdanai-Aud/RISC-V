main:
addi sp, sp, -8 # allocate 8 bytes on the stack
li x20, 3 # x20 = 3
li x21, 5 # x21 = 5
sw x21, 4(sp) # push x21
sw x20, 0(sp) # push x20
jal foo # call foo
addi sp, sp, 8 # deallocate 8 bytes on the stack
add x18, x0, a0 # result1 (x18) = foo(3, 5)

#save x18 on to the stack
addi sp, sp, -4
sw x18, 0(sp)

addi sp, sp, -8 # allocate 8 bytes on the stack
li x20, 4 # x20 = 4
li x21, 12 # x21 = 12
sw x21, 4(sp) # push x21
sw x20, 0(sp) # push x20
jal foo # call foo
addi sp, sp, 8 # deallocate 8 bytes on the stack
add x19, x0, a0 # result2 (x19) = foo(4, 12)

# restore x18 from the stack
lw x18, 0(sp)
addi sp, sp, 4

add x18, x18, x19 # result1 = result1 + result2

# return 0 from main
addi a0, x0, 10 # exit call OS emulation
add a1, x0, x0# exit call OS emulation
ecall # exit call OS emulation

#       x = x18
#		n = x19
#		i = x20
#		sum = x21

foo:
lw x18, 0(sp) # x18 = x
lw x19, 4(sp) # x19 = n
li x21, 0 # sum = 0
li x20, 0 # i = 0
start_loop:
bge x20, x19, exit_loop # if i >= n goto exit_loop
add x21, x21, x18 # sum += x
addi x20, x20, 1 # i++
j start_loop
exit_loop:
add a0, x0, x21 # a0 = sum
jr ra # return sum