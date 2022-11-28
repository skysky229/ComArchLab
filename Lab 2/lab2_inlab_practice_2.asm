.data
	arr: .space 40 # 10 phâ?n t??
	msg_out: .asciiz "the sum is: "
	
.text
	la $s0, arr # store the pointer to arr at s0
	li $t0, 0 # use t0 as counter
	
	move $t1, $s0 # use t1 as temporary pointer
input: # input 10 elements
	li $v0, 5 # read input
	syscall 
	
	sw $v0, 0($t1) 
	addi $t1, $t1, 4 # move to the next element
	addi $t0, $t0, 1
	slti $t2, $t0, 10
	beq $t2, 1, input 
	
	addi $s3, $s0, 40 # use s3 as temporary pointer (initially point to the end of array + 1 (due to the < condition))
	li $s2, 0 # store the answer in s2
	jal sum # start the sum recursion
	j output # jump to output
sum: 	
	addi $sp, $sp, -8
	sw $s3, 0($sp)
	sw $ra, 4($sp)
	slt $t1, $s0, $s3
	beq $t1, 1, recursion
lock: 	addi $sp, $sp, 8 
	li $s2, 0 # set init s2 to 0
	jr $ra
	
recursion:
	addi $s3, $s3, -4 # point to the previous element
	jal sum
	lw $s3, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	lw $t0, -4($s3) # take the value of the element that $s3 point to 
	add $s2, $s2, $t0 # ans += temp
	jr $ra

output:
	la $a0, msg_out
	li $v0, 4
	syscall
	
	move $a0, $s2
	li $v0, 1
	syscall
	
exit: 