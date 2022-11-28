.data 

.text
	# read the first integer and save it to $t0
	li $v0, 5
	syscall
	addi $t0, $v0, 0
	
	# read the second integer and save it to $t1
	li $v0, 5
	syscall
	addi $t1, $v0, 0
	
	# sum two integers and save to $a0
	add $a0, $t0, $t1
	
	# print the answer
	li $v0, 1
	syscall 
	
	#end the program
	li $v0, 10
	syscall