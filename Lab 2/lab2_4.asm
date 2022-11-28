.data
	arr: .word 1,2,3,4,5,6,7,8,9,10 # 10 phâ?n t??
	msg_out: .asciiz "the sum is: "
	
.text
	la $s0, arr # store the pointer to arr at s0
	li $t0, 0 # set t0 as counter 
	addi $s3, $s0, 0 # use s3 as temporary pointer (initially point to the start of array)
	li $s2, 0 # store the answer in s2
	jal sum # start the sum recursion
	j output # jump to output
sum: 	
	addi $sp, $sp, -8
	sw $s3, 0($sp)
	sw $ra, 4($sp)
	slti $t1, $t0, 10 # if the s3 pointer is not at the start of the array
	beq $t1, 1, recursion
lock: 	addi $sp, $sp, 8 
	li $s2, 0 # set init s2 to 0
	jr $ra
	
recursion:
	addi $t0, $t0, 1 # increase counter
	addi $s3, $s3, 4 # point to the next element
	jal sum
	lw $s3, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	lw $t0, 0($s3) # take the value of the element that $s3 point to and save to t0
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
