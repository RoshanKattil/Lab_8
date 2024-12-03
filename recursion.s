.data
prompt: .asciiz "Enter an integer: "
newline: .asciiz "\n"

.text
main:
    la $a0, prompt
    li $v0, 4
    syscall

    li $v0, 5             # Read integer
    syscall

    move $a0, $v0
    jal recursion
    move $t0, $v0

    move $a0, $t0
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    li $v0, 10            # Exit
    syscall

recursion:
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp)

    bgez $a0, not_minus_one
    li $v0, 1             # m == -1
    j end_recur

not_minus_one:
    bne $a0, 0, not_zero
    li $v0, 3             # m == 0
    j end_recur

not_zero:
    sw $a0, 4($sp)

    addi $a0, $a0, -2     # recursion(m - 2)

    jal recursion
    move $t0, $v0

    lw $a0, 4($sp)

    addi $a0, $a0, -1     # recursion(m - 1)

    jal recursion

    add $v0, $v0, $t0 

end_recur:
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    addi $sp, $sp, 8

    jr $ra
