# 260915701 / Zenghao (Mike) Gao
.data 
promptMsg: .asciiz "Enter a number to find its factorial:"
notvalid: .asciiz "\nThe value you entered is less than zero. This program only works with values greater than or equal to zero. "
input: .asciiz "\nYou input:"
output: .asciiz "\nThe factorial is:"
retrystr: .asciiz "\nRetry? (Y/N)"
yes: .ascii "Y"
.text

main:
	la $a0, promptMsg
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $a0, $v0 # Move to $a0
	la $t1, ($a0)
	
	# check
	slt $t2, $v0, $zero
	bnez $t2, error # if the value in $t2 is not zero, go to error
	
	# Call the factorial function
	jal Fact
	la $t3, ($v0)
	
	li $v0, 4
	la $a0, input
	syscall
	
	li $v0, 1
	la, $a0, ($t1)
	syscall
	
	li $v0, 4
	la $a0, output
	syscall
	
	li $v0, 1
	la $a0, ($t3)
	syscall
	
	j retry
	
Fact:	subi $sp,$sp,8 
	sw $ra,4($sp)
	sw $a0,0($sp)
	li $t7,1
	slt $t0,$a0,$t7
	beq $t0,$zero,L1
	addi $v0,$zero,1
	addi $sp,$sp,8
	jr $ra

L1:	subi $a0,$a0,1
	jal Fact
	lw $a0,0($sp)
	lw $ra,4($sp)
	addi $sp,$sp,8
	mul $v0,$a0,$v0
	jr $ra

retry: 
	li $v0, 4
	la $a0, retrystr
	syscall
	
	li $v0, 12
	syscall
	
	la $t6, yes
	lb $t8, 0($t6)
	beq $v0, $t8, main
	j exit

error:
	la $a0, notvalid
	li $v0, 4
	syscall
	
	j exit
	
exit:	li $v0, 10
	syscall

	
