.data
prompt_int: .asciiz "Enter an integer: "
prompt_binary: .asciiz "Binary: "
prompt_hex: .asciiz "The hexadecimal is: 0x"
prompt_continue: .asciiz "Continue? {0 or 1} "
newline: .asciiz "\n"

.text
.globl main

main:
    # Outer loop for the conversion process
    loop:
        # Prompt user for an integer input
        li $v0, 4                     #print
        la $a0, prompt_int
        syscall

        # Read integer input
        li $v0, 5
        syscall
        move $t0, $v0  #storing input in $t0

        # Binary conversion
        li $v0, 4                     #print statement, "binary: "
        la $a0, prompt_binary
        syscall

        li $t1, 31  #setting the counter
        binary_loop:
            srl $t2, $t0, $t1  #shift in order to get the $t1-th bit
            andi $t2, $t2, 1  #masking all the bits other than the least sig one
            addi $t2, $t2, 48         #Ascii convert
            li $v0, 11    #print
            move $a0, $t2
            syscall
            sub $t1, $t1, 1           #decrement
            bgez $t1, binary_loop     #if $t1 >= 0 continue

        # Print newline after binary output
        li $v0, 4
        la $a0, newline
        syscall

        # Hexadecimal conversion
        li $v0, 4                     #print
        la $a0, prompt_hex
        syscall

        li $t3, 7                     #Hex digit counter (8 nibbles for 32 bits)
        hex_loop:
            sll $t2, $t0, 28          #shift to the leftmost position
            srl $t2, $t2, 28          #shifting back in order to get hex digit
            addi $t2, $t2, 48         #converting
            blt $t2, 58, hex_digit  #if less than 9
            addi $t2, $t2, 7          #then adjust ASCII for A-F
        hex_digit:
            li $v0, 11  #printing hex character
            move $a0, $t2
            syscall

            sll $t0, $t0, 4           #shift left to prepare next hex digit
            sub $t3, $t3, 1           #decrement
            bgez $t3, hex_loop        #if $t3 >= 0

        li $v0, 4
        la $a0, newline
        syscall

        li $v0, 4  #continue statement, loop
        la $a0, prompt_continue
        syscall

        # Read user's response
        li $v0, 5  #read integer
        syscall
        beq $v0, 1, loop              #repeat if 1
        j end  #or end the program

end:
    li $v0, 10
    syscall
