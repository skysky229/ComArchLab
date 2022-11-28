.data
	list: .word 1, 2, 3, 4, 5, 20, 7, 8, 70, 10
	oddsum: .asciiz "\n sum of odds: "
	evensum: .asciiz "sum of evens: "

.text
	la $s0, list # load base address of list to $s0
	addi $t0, $zero, 0 # set $t0 as iterator
	addi $t8, $zero, 0 # set $t8 as sum of even
	addi $t9, $zero, 0 # set $t9 as sum of odd
	
sum:	lw $t2, 0($s0) # load current element to $t2
	andi $t3, $t0, 1
	beq $t3, 0, even
	add $t9, $t9, $t2
	
loopCond: 	addi $s0, $s0, 4
		addi $t0, $t0, 1
		slti $t1, $t0, 10
		bne $t1, $zero, sum
		j print 
	
even:	add $t8, $t8, $t2
	j loopCond
	
	# print result of even sum
print: 	la $a0, evensum
	li $v0, 4
	syscall
	
	add $a0, $zero, $t8
	li $v0, 1
	syscall
	
	# print result of odd sum
	la $a0, oddsum
	li $v0, 4
	syscall
	
	add $a0, $zero, $t9
	li $v0, 1
	syscall
	
	# end the program
	li $v0, 10
	syscall
	
	
	
