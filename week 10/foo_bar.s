.data
my_string_1: .string "result is "
new_line: .string "\n"

.text
main:
li x19, 3 # x19 = 3
li x20, 5 # x20 = 5
addi sp, sp, -8 # allocate 8 bytes on the stack
sw x20, 4(sp) # push 5 (x20)
sw x19, 0(sp) # push 3 (x19)
jal foo # call
add x18, x0, a0 # result = foo(3, 5)
addi sp, sp, 8 # deallocate 8 bytes on the stack

# print "result is "
addi a0, x0, 4  # put code 4 to a0
la a1, my_string_1 # put address of my_string_1 to in a1
ecall

# print result
addi a0, x0, 1  # put code 1 to a0
add a1, x0, x18 # put the value of result in a1
ecall

# print "\n"
addi a0, x0, 4  # put code 4 to a0
la a1, new_line # put address of new_line to in a1
ecall

# return 0 in main
addi a0, x0, 10 # put code 10 in a0
add a1, x0, x0 # set a1 to zero
ecall

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
# save ra
addi sp, sp, -4
sw ra, 0(sp)

# save sum
addi sp, sp, -4
sw x21, 0(sp)

# bar(10)
# push 10 on the stack
li x22, 10 # x22 = 10
addi sp, sp, -4
sw x22, 0(sp)

jal bar # call bar
addi sp, sp, 4 # deallocate 4 bytes

# restore sum
lw x21, 0(sp)
addi sp, sp, 4

add x21, x21, a0 # sum = sum + bar(10)

# return sum
add a0, x0, x21
# restore ra
lw ra, 0(sp)
addi sp, sp, 4
jr ra # return

bar:
lw x18, 0(sp) # x18 = n
li x20, 0 # sum = 0
li x19, 0 # i = 0
start_loop_bar:
bge x19, x18, exit_loop_bar # if i >= n goto exit_loop_bar
# sum = sum + i + 1
add x20, x20, x19 # sum = sum + i
addi x20, x20, 1 # sum = sum + 1
addi x19, x19, 1 # i++
j start_loop_bar

exit_loop_bar:
add a0, x0, x20 # move sum to a0
jr ra