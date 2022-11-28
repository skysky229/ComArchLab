.data
	arr: .word 100,2,3,4,5,6,7,8,9,2 # 10 phâ?n t??
	msg_out: .asciiz "the max value is: "
	
.text
	la $s0, arr # store the pointer to arr at s0
	li $t0, 0 # set t0 as counter 
	addi $s3, $s0, 0 # use s3 as temporary pointer (initially point to the start of array)
	li $s2, 0 # store the answer in s2
	jal find_max # start the find_max recursion
	j output # jump to output
	
find_max: 	
	addi $sp, $sp, -8
	sw $s3, 0($sp)
	sw $ra, 4($sp)
	slti $t1, $t0, 10 # if the s3 pointer is not at the start of the array
	beq $t1, 1, recursion
lock: 	addi $sp, $sp, 8 
	li $s2, 0 # set init s2 to 0
	jr $ra
	
recursion:
	addi $t0, $t0, 1
	addi $s3, $s3, 4 # point to the previous element
	jal find_max
	lw $s3, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	lw $t0, 0($s3) # take the value of the element that $s3 point to and save to t0
	slt $t2, $s2, $t0 # compare current max and t0
	beq $t2, 0, cont # if current max is greater than t0, jump to continue (Dont assign new value)
assign: move $s2, $t0 # else assign
cont:	jr $ra

output:
	la $a0, msg_out
	li $v0, 4
	syscall
	
	move $a0, $s2
	li $v0, 1
	syscall
	
exit: 
