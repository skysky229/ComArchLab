.data
	list: .word 1, 3, 5, 7, 9, 11, 13, 15, 17, 19
	space: .asciiz " "
	mess: .asciiz "Reversed array: "
	
.text
	la $s0, list # load base address of list to $s0
	add $t0, $zero, $s0 # set $t0 as iterator from the start
	addi $t1, $s0, 36 # set $t1 as iterator from the end 
	addi $t3, $zero, 0 # set $t3 as count
	
reverse: jal swap
	addi $t0, $t0, 4
	addi $t1, $t1, -4
	addi $t3, $t3, 1
	slti $t2, $t3, 5
	bne $t2, $zero, reverse
	j exit 
	
swap: 	lw $t5, 0($t0)
	lw $t4, 0($t1)
	sw $t4, 0($t0)
	sw $t5, 0($t1)
	jr $ra
	
exit:   la $a0, mess
	li $v0, 4
	syscall
	addi $t3, $zero, 0 # set $t3 as count
	
print:	lw $a0, 0($s0) # print the member at address $s0
	li $v0, 1 
	syscall 
		
	la $a0, space
	li $v0, 4
	syscall
	
	# check if the id is currently equal 9 or not
	addi $s0, $s0, 4
	addi $t3, $t3, 1
	slti $t1, $t3, 10
	bne $t1, $zero, print

	# end the program
	li $v0, 10
	syscall
