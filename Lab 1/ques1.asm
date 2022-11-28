.data
	sentence: .asciiz "Input an integer number:\n"
	
.text
main:
	#output the required sentence 	
	li $v0, 4
	la $a0, sentence 
	syscall
	
	# read the integer and save it to $t0
	li $v0, 5
	syscall
	addi $t0, $v0, 0
	
	# increase the integer by one
	addi $t0, $t0, 1
	
	# print the integer
	li $v0, 1
	move $a0, $t0
	syscall
	
	#end the program
	li $v0, 10
	syscall

