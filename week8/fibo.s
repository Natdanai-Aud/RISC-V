addi x18, x0, 0 # a = 0
addi x19, x0, 1 # b = 1
addi x20, x0, 8 # n = 8
bne x20, x0, else_if # if n != 0 goto else_if
add x21, x0, x18 #fib_n = a
j exit_if_else

else_if:
addi x24, x0, 1 # x24 = 1
bne x20, x24, else # if n != 1 goto else
add x21, x0, x19 # fib_n = b
j exit_if_else

else:
addi x22, x0, 2 # i = 2
start_loop:
bgt x22, x20, exit_loop # if i > n goto exit_loop
add x23, x18, x19 # c = a + b
add x18, x0, x19 # a = b
add x19, x0, x23 # b = c
addi x22, x22, 1 # i++
j start_loop
exit_loop:
add x21, x0, x19 # fib_n = b

exit_if_else:
addi x23, x0, 0 # c = 0 