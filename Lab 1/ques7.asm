.data 
	arr: .space 40 # array of 40 ints
	sum: .asciiz "sum of the array:"
	mess: .asciiz "Enter a number: "

.text
	la $s0, arr # load base address of arr to $s0
	addi $t0, $zero, 0 # set t0 as count
	
input: 	la $a0, mess
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	sw $v0, 0($s0)
	addi $s0, $s0, 4
	addi $t0, $t0, 1
	slti $t1, $t0, 10 # check if the size of array is 10 or not
	bne $t1, $zero, input
	
	addi $t0, $zero, 0 # reset $t0 
	addi $s0, $s0, -4 # set $s0 to the last element of array
	la $a0, sum
	li $v0, 4
	syscall
	
	# the sum will be stored in $a0
	addi $a0, $zero, 0 # init a0
calc: 	lw $t2, 0($s0)
	add $a0, $a0, $t2
	addi $s0, $s0, -4
	addi $t0, $t0, 1
	slti $t1, $t0, 10
	bne $t1, $zero, calc
	
	#print the result
print:	li $v0, 1 
	syscall 
	
	# end the program
	li $v0, 10
	syscall
