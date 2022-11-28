.data 
	list: .word 1, 2, 3, 4, 5, 20, 7, 8, 70, 10
	mess: .asciiz "Input an iteger from 0 to 9: "
	outMess: .asciiz "The value of element at that index is: "

.text
	la $s0, list # load base address of list to $s0
	addi $t0, $zero, 0 # set t0 as count

	# input the ID and assign to s2
inpID:	la $a0, mess
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s2, $v0

	# $s1 will store the answer
check:  lw $s1, 0($s0)
	beq $t0, $s2, print # check if the current index and the input index are the same
	addi $t0, $t0, 1
	addi $s0, $s0, 4
	slti $t1, $t0, 10 # check if the size of array is 10 or not
	bne $t1, $zero, check
	
print:	la $a0, outMess
	li $v0, 4
	syscall
	move $a0, $s1
	li $v0, 1
	syscall

	# end the program
	li $v0, 10
	syscall


	
