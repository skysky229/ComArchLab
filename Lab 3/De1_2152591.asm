.data 
	arr: .space 80
.text
main:
	jal input
	jal findMin
	jal output
	jal exit
	
input:
	li $v0, 5
	syscall 
	
	move $s0, $v0 # s0 stores n
	
	li $t0, 0 # set up t0 as iterator
	la $t1, arr # t1 as pointer to the first element
	
inputLoop:
	li $v0, 5
	syscall
	move $t3, $v0 # t3 store temporary element
	sw $t3, 0($t1) # save to the current position
	addi $t1, $t1, 4 # move to the next element
	addi $t0, $t0, 1 # increase iterator
	slt $t2, $t0, $s0 # if iterator < n
	beq $t2, 1, inputLoop
	jr $ra # go back to main 

findMin:
	li $t0, 0 # set up t0 as iterator
	la $t1, arr # t1 as pointer to the first element
	lw $s1, 0($t1) # s1 store the min
	
calcLoop:
	lw $t3, 0($t1)
	slt $t2, $t3, $s1 # if current element is smaller than min
	beq $t2, 0, cont # if current element is larger than min, move to cont
	add $s1, $0, $t3 # else assign to min
cont:
	addi $t1, $t1, 4 # move to the next element
	addi $t0, $t0, 1 # increase iterator
	slt $t2, $t0, $s0 # if iterator < n
	beq $t2, 1, calcLoop
	
	jr $ra # go back to main
	
output:
	move $a0, $s1
	li $v0, 1
	syscall
	jr $ra # go back to main
	
exit:
	
	
