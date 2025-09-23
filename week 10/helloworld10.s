.data
my_string: .string "Hello World"
new_line: .string "\n"

.text
main:
addi x18, x0, 10 # x = 10

# print my_string
addi a0, x0, 4  # put code 4 to a0
la a1, my_string # put address of my_string to in a1
ecall

# print new_line
addi a0, x0, 4  # put code 4 to a0
la a1, new_line # put address of new_line to in a1
ecall

# print x
addi a0, x0, 1  # put code 1 to a0
add a1, x0, x18 # put the value of x in a1
ecall

# print new_line
addi a0, x0, 4  # put code 4 to a0
la a1, new_line # put address of new_line to in a1
ecall

# exit with code zero
# return 0 in main
addi a0, x0, 10 # put code 10 in a0
add a1, x0, x0 # set a1 to zero
ecall