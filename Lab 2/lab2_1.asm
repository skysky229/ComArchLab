.data 
	sentence: .asciiz  "Ho Chi Minh City - University of Technology"
	length: .word 42

.text 
		# use t0 as sentence to reverse, t1 as pointer of that string, t5 as length
		la $t0, sentence
		lw $t1, length 
		lw $t5, length
	
		add $t1, $t1, $t0 #set t1 point to the end of sentence
	
		addi $t2, $0, 0 #set t2 as counter for loop
	
loop:		lbu $a0, 0($t1)
		li $v0, 11
		syscall
		addi $t1, $t1, -1 # move backward one step
	
		slt $t4, $t2, $t5
		addi $t2, $t2, 1
		beq $t4, 1, loop
	
	
