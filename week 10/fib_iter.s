.data
my_string_1: .string "my_fib = "
my_string_2: .string "my_num = "
new_line: .string "\n"

.text
main:
li x18, 4 # my_num = 4

# save my_num (x18) on to the stack
addi sp, sp, -4
sw x18, 0(sp)

# fib_iter(12)
li x20, 12 # x20 = 12
addi sp, sp, -4 # allocate 4 bytes on the stack
sw x20, 0(sp) # push 12 (x20)
jal fib_iter # call fib_iter

# my_fib = fib_iter(12)
add x19, x0, a0 # put result from fib_iter (a0) to x19 (my_fib) my_fib = fib_iter(12)
addi sp, sp, 4 # deallocate 4 bytes on the stack

# restore my_num (x18) from the stack
lw x18, 0(sp)
addi sp, sp, 4

addi x18, x18, 1 # my_num++
# printf("my_fib = %d\n", my_fib);
# print "my_fib = "
addi a0, x0, 4  # put code 4 to a0
la a1, my_string_1 # put address of my_string_1 to in a1
ecall

# print my_fib
addi a0, x0, 1  # put code 1 to a0
add a1, x0, x19 # put the value of my_fib in a1
ecall

# print new_line
addi a0, x0, 4  # put code 4 to a0
la a1, new_line # put address of new_line to in a1
ecall

# print "my_num = "
addi a0, x0, 4  # put code 4 to a0
la a1, my_string_2 # put address of my_string_1 to in a1
ecall
# print my_num
addi a0, x0, 1  # put code 1 to a0
add a1, x0, x18 # put the value of my_num in a1
ecall
# print new_line
addi a0, x0, 4  # put code 4 to a0
la a1, new_line # put address of new_line to in a1
ecall

# return 0 in main
addi a0, x0, 10 # put code 10 in a0
add a1, x0, x0 # set a1 to zero
ecall

fib_iter:
# n = x18
# curr_fib = x19
# next_fib = x20
# new_fib = x21
# i = x22

lw x18, 0(sp) # x18 = n
li x19, 0 # curr_fib = 0
li x20, 1 # next_fib = 1
add x22, x0, x18 # i = n
start_loop:
ble x22, x0, exit_loop # if i <= 0 goto exit_loop
add x21, x19, x20 # new_fib = curr_fib + next_fib
add x19, x0, x20 # curr_fib = next_fib
add x20, x0, x21 # next_fib = new_fib
addi x22, x22, -1 # i--
j start_loop

exit_loop:
add a0, x0, x19 # put curr_fib (x19) to a0 for return
jr ra