# Program_2.asm
# A program that calculate the sum of a sequence of number

# Tell the program where to execute
.globl main

# Data section - Allocate memory
.data

# Code
.text
main:
    li  $t5, 0          # initialize sum = 0       

    jal input_stream    # jump to input function
    j   test

input_stream: 
    li  $v0, 5               # Syscall to read an integer
    syscall
    move $t1, $v0           # save the input in $t1

    li  $v0, 5               # Syscall to read an integer
    syscall
    move $t2, $v0           # save the input in $t2

    add $t3, $t1, $t2   # save the sum of $t1 and $t2 in $t3

    jr  $ra                 # jump back to function

test: 
    slt $t4, $t1, $t3   # test if $t1 < $t3
    bne $t4, $zero, loop    # if true go to loop
    j print_output      # print the output

loop: 
    add $t5, $t1, $t5   # $t4 = $t4 + $t0
    addi $t1, $t1, 1    # $t1 += 1
    j test

print_output:
    move  $a0, $t5        # if not true
    li $v0, 1       # Syscall to print integer in $a0
    syscall

    li $v0, 10      # Syscall to escape program
    syscall




