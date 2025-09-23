.data
my_string: .string "iteration"
new_line: .string "\n"

.text
# x18 = i
li x18, 0 # i = 0
start_loop:
li x19, 5 # x19 = 5
bge x18, x19, exit_loop # if i >= 5 goto exit_loop

# print my_string "iteration"
addi a0, x0, 4  # put code 4 to a0
la a1, my_string # put address of my_string to in a1
ecall

# print i
addi a0, x0, 1  # put code 1 to a0
add a1, x0, x18 # put the value of i in a1
ecall

# print new_line
addi a0, x0, 4  # put code 4 to a0
la a1, new_line # put address of new_line to in a1
ecall

addi x18, x18, 1 # i++
j start_loop

exit_loop:
# exit with code zero
# return 0 in main
addi a0, x0, 10 # put code 10 in a0
add a1, x0, x0 # set a1 to zero
ecall