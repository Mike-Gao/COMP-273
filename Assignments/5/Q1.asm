# 260915701 / Zenghao (Mike) Gao
	.data 
str:	.asciiz "How old are you (in years)?\n"
str2:   .asciiz "You have been alive for this many days: "
	.text
	

main:
	la $a0, str
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0 #saved to t0
	li $t1, 1
	li $t3, 0
	j loop
	
loop:	bgt $t1, $t0, exit
	addi $t1, $t1, 1
	addi $t3, $t3, 365
	j loop

exit:	la $a0, str2
	li $v0, 4
	syscall
	
	la $a0, ($t3)
	li $v0, 1
	syscall
	li $v0, 10
	syscall

	