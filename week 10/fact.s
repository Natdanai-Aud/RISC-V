.data
my_string: .string "result is "
new_line:   .string "\n"

.text
main:
li a0, 10 # a0 โหลดค่า 10
jal ra, fact
mv x18, a0
    
# print "result is "
addi a0, x0, 4  # put code 4 to a0
la a1, my_string # put address of my_string_1 to in a1
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

fact:
addi sp, sp, -8 # จองพื้นที่บน stack 8 bytes (สำหรับ 2 register)
sw ra, 4(sp) # Return Address (ra)
sw s3, 0(sp) # เก็บค่าเดิมของ s3 (x19)
    
mv x19, a0 # ย้ายค่า n จาก a0 มาเก็บไว้ที่ x19 (s3)

bnez x19, facttwo # if n!= 0 goto facttwo
    
li a0, 1 # ถ้า n == 0 return 1
j fact_end

facttwo:
addi a0, x19, -1 # -1
jal ra, fact # fact
    
mul a0, a0, x19 # fact(n-1) * n เก็บใน result
    
fact_end:
lw ra, 4(sp)
lw s3, 0(sp)
addi sp, sp, 8
    
ret