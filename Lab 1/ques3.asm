.data 
	F: .asciiz "f is: "
	G: .asciiz "\n g is: "
.text	
	# read a and save it to $t0
	li $v0, 5
	syscall
	addi $t0, $v0, 0
	
	# read b and save it to $t1
	li $v0, 5
	syscall
	addi $t1, $v0, 0
	
	# read c and save it to $t2
	li $v0, 5
	syscall
	addi $t2, $v0, 0
	
	# read d and save it to $t3
	li $v0, 5
	syscall
	addi $t3, $v0, 0
	
	# calculate a + b and assign to $t4
	add $t4, $t0, $t1
	
	# calculate c - d - 2 and assign to $t5
	sub $t5, $t2, $t3
	addi $t5, $t5, -2
	
	# calculate f and assign to $t8
	sub $t8, $t4, $t5
	
	# print f
	la $a0, F
	li $v0, 4
	syscall
	move $a0, $t8
	li $v0, 1
	syscall

	
	# calculate (c + d)*2 and assign to $t6
	add $t6, $t2, $t3
	add $t6, $t6, $t6
	
	# calculate (a+b)*3 and assign to $t7
	add $t7, $t4, $t4
	add $t7, $t7, $t4
	
	#calculate g and assgin to $t9
	sub $t9, $t7, $t6
	
	# print g
	la $a0, G
	li $v0, 4
	syscall
	move $a0, $t9
	li $v0, 1
	syscall
	
	#end the program
	li $v0, 10
	syscall
