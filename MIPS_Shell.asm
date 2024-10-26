# MIPS Program Shell

# Tell the program where to execute
.globl main

# Data section - Allocate memory
.data

# Code
.text
main:

    li $v0, 10       # Load system call for exit
    syscall          # Make the system call