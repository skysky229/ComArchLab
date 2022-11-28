.data
	list: .word 1, 2, 3, 4, 5, 6, 7, 8, 50, 10
	sum: .asciiz "sum of the array:"

.text
	la $s0, list # load base address of list to $s0
	addi $t0, $zero, 0 # set $t0 as iterator
	
	la $a0, sum
	li $v0, 4
	syscall
	# the sum will be stored in $a0
	addi $a0, $zero, 0 # init a0
calc: 	lw $t2, 0($s0)
	add $a0, $a0, $t2
	addi $s0, $s0, 4
	addi $t0, $t0, 1
	slti $t1, $t0, 10
	bne $t1, $zero, calc
	
	#print the result
print:	li $v0, 1 
	syscall 
	
	# end the program
	li $v0, 10
	syscall
