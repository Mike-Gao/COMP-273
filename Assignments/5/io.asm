# 260915701 / Zenghao (Mike) Gao
.data 
last:	.space 1024
first:	.space 1024
str:	.asciiz "Please enter your first name\n"
str2:   .asciiz	"\nPlease enter your last name\n"
str3:	.asciiz "\nYour name is:\n"
enter:	.asciiz "\n"
limit:	.word 40
.text
	
main:	

	la $a0, str
	jal puts
	
	la $a1, limit
	la $a0, first
	la $a2, enter
	jal gets
	
	la $a0, str2
	jal puts
	
	la $a0, last
	jal gets
	
	la $a0, str3
	jal puts
	
	la $a0, first
	jal puts
	
	la $a0, last		
	jal puts
	
	li $v0, 10
	syscall
	
gets:	
	subi $sp, $sp, 36
	sw $ra, ($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)	
	addi $t2 $zero 0
	lw $t3 ($a1)
	lb $t4 ($a2)
gloop:
	jal getchar
	sb $v0 ($a0)
	addi $a0 $a0 1
	addi $t2 $t2 1
	beq $t2 $t3 gexit
	beq $v0 $t4 gexit
	jal gloop

gexit:
	lw $a2, 12($sp)
	lw $a1, 8($sp)
	lw $a0, 4($sp)
	lw $ra, ($sp)
	addi $sp, $sp, 36
	jr $ra

puts:	
	subi $sp, $sp, 4
	sw $ra, ($sp)
	
	subi $sp, $sp, 32
	sw $a0, ($sp)
ploop:
	lb $t0, ($a0)
	beqz $t0, pexit
	jal putchar 
	addi $a0, $a0, 1
	bnez $t0, ploop
pexit:	
	lw $a0, ($sp)
	addi $sp, $sp, 32
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra
	
getchar:
	lui $a3, 0xffff
	
isready:
	lw $t1, 0($a3)
	andi $t1, $t1, 0x1
	beqz $t1, isready
	lb $v0, 4($a3)
	jr $ra
	
putchar:
  	lui $a3, 0xffff
  	
check:
	lw $t1, 8($a3)
	andi $t1, $t1, 0x1
	beqz $t1, check
	sw $t0, 12($a3)
	jr $ra
