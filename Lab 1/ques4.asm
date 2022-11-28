.data 
	arr: .space 20 # array of 5 ints
	space: .asciiz " "
	mess: .asciiz "Enter a number: "
	mess2: .asciiz "Reversed array: "
	
.text 
	la $s0, arr # load base address of arr to $s0
	addi $t0, $zero, 0 # set t0 as count
	
	# read an integer and save it to the array until the size is 5 
input: 	la $a0, mess
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	sw $v0, 0($s0)
	addi $s0, $s0, 4
	addi $t0, $t0, 1
	slti $t1, $t0, 5 # check if the size of array is 5 or not
	bne $t1, $zero, input

	addi $s0, $s0, -4 # set pointer to the last element
	addi $t0, $zero, 0 # set count to 0
	
	la $a0, mess2
	li $v0, 4
	syscall
output:	lw $a0, 0($s0) # print the member at address $s0
	li $v0, 1 
	syscall 
		
	la $a0, space
	li $v0, 4
	syscall
	
	# check if the id is currently equal to zero or not
	addi $s0, $s0, -4
	addi $t0, $t0, 1
	slti $t1, $t0, 5
	bne $t1, $zero, output

	
	# end the program
	li $v0, 10
	syscall
	
	
