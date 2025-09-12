.globl main
.text

# int main()
main:
    addi x2, x2, -4 # จองพื้นที่บน stack 1 word (4 bytes)
    sw x1, 0(x2)         

    # --- เตรียมการและเรียกใช้ foo(3, 5) ---
    li x18, 3 # x = 3
    li x19, 5 # n = 5
    jal x1, foo        

    # ผลลัพธ์ของ foo(3, 5) อยู่ใน x10
    mv x18, x10

   # return 0 from main
    addi a0, x0, 10 # exit call OS emulation
    add a1, x0, x0 # exit call OS emulation
    ecall # exit call OS emulation

    lw x1, 0(x2)
    addi x2, x2, 4
    ret             

bar:
    li x20, 0 # sum = 0
    li x19, 0 # i = 0
bar_loop:
    bge x19, x18, bar_exit # for (i < n) if i >= n
    addi x22, x19, 1 # temp = i + 1
    add x20, x20, x22 # sum += temp
    addi x19, x19, 1 # i++
    j bar_loop
bar_exit:
    mv x10, x20 # return sum
    ret
    
foo:
    addi x2, x2, -12 # จองพื้นที่บน stack 3 words (12 bytes)
    sw x1, 8(x2) # return address ของ foo
    sw x21, 4(x2) # บันทึกค่า sum ของ foo
    sw x18, 0(x2) # บันทึกค่า x ของ foo

    li x21, 0 # sum = 0
    li x20, 0 # i = 0
foo_loop:
    bge x20, x19, foo_call_bar # for (i < n) if i >= n
    add x21, x21, x18 # sum += x
    addi x20, x20, 1 # i++
    j foo_loop

foo_call_bar:
    li x18, 10 # n=10
    jal x1, bar # เรียกฟังก์ชัน bar
    
    add x21, x21, x10 # sum = sum + bar(10);
    mv x10, x21 # return sum

    lw x1, 8(x2)         # คืนค่า ra
    lw x21, 4(x2)        # คืนค่า sum เดิม
    lw x18, 0(x2)        # คืนค่า x เดิม
    addi x2, x2, 12        # คืนพื้นที่บน stack
    ret
