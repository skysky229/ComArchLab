# nhâ?p 10 sô? nguyên, ti?nh tô?ng cu?a ca?c phâ?n t?? l??n h?n 7 tr?? cho tô?ng ca?c phâ?n t?? nho? h?n 10
.data
	arr: .space 40 # 10 phâ?n t??
	msg_out: .asciiz "the answer is: "
	
.text 
	# store pointer to array at $s0
	la $s0, arr
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
	
calc: 	
	li $s1, 0 # use s1 as the sum of elements greater than 7
	li $s2, 0 # use s2 as the sum of elements smaller or equal to 7 
	
	li $t0, -1 # use t0 as counter
	addi $t1, $s0, -4 # use t1 as temporary pointer
	
loop: 	
	addi $t0, $t0, 1
	addi $t1, $t1, 4
	slti $t2, $t0, 10
	beq $t2, 0, output 
	lw $t3, 0($t1) # load the i-th element to t3
	slti $t2, $t3, 8 # t2 = 1 if t3 <= 7
	beq $t2, 1, sumSmaller

sumGreater:
	add $s1, $s1, $t3
	j loop
	
sumSmaller:
	add $s2, $s2, $t3
	j loop
	
output:
	la $a0, msg_out
	li $v0, 4
	syscall
	
	sub $a0, $s1, $s2
	li $v0, 1
	syscall

exit: 