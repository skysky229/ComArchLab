.data 
	inputmsg: .asciiz "please input a number: "
	gap: .asciiz  " "
	invalid: .asciiz "invalid input"
	
.text
		la $s0, inputmsg # s0 save the input message
		la $s2, invalid # s2 save the message when input is invalid
		
		move $a0, $s0 # print input message
		li $v0, 4
		syscall
		
		li $v0, 5 # read the input and save to t1
		syscall
		move $t1, $v0
		
		slti $t0, $t1, 1 # check if t1 is less than or equal to 0. if not, move to findFibo function
		beq $t0, 0, findFibo

notvalid:	move $a0, $s2 # if not valid, print the invalid msg 
		li $v0, 4
		syscall
		j exit

findFibo: 
		addi $s3, $zero, 0 # set $s3 as 0th fibo number
		addi $s4, $zero, 1 # set $s4 as 1th fibo number
		
		# start of for loop
		addi $t2, $zero, 1 # set t2 as iterator, start from 1 (which will increase to 2 at the start of loop)
		slt $t0, $t2, $t1 # check if iterator is already larger than the need-to-calculate fibo number
		beq $t0, 1, loop  # if no, jump to loop
		jal printAns # if yes, jump to printAns 
		j exit
		
		
loop:		# each step i, we calculate the i-th fibo number
		jal printAns # print the i-1th fibo number
		addi $t2, $t2, 1 # increase i-1 to i
		addi $t3, $s4, 0 # save the ith to temp (which will be assigned to i-1th fibo number ($s3) after calculating the i+1th fibo number 
		add $s4, $s4, $s3
		addi $s3, $t3, 0
		
		slt $t0, $t2, $t1 # check if iterator is at the need-to-calculate fibo number

		beq $t0, 1, loop
		
		jal printAns # print the n-th fibo number
		j exit 

printAns:	
		move $a0, $s4
		li $v0, 1
		syscall
		
		la $a0, gap # print gaps
		li $v0, 4
		syscall 
		
		jr $ra
exit:
		
		
