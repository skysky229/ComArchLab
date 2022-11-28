.data 
	arr: .space 40
	inputmsg: .asciiz "input 10 numbers: "
	outputmsg: .asciiz  "sorted numbers: "
	gap: .asciiz  " "
	
.text
		la $s0, inputmsg # s0 stores the inputmsg
		la $s1, outputmsg #s1 stores the outputmsg
		la $s2, arr #s2 store the address of the first element of the array
		la $s3, gap 
		# t2 is the truth value for slt/slti
	
		move $a0, $s0 # print input msg
		li $v0, 4
		syscall
	
		add $t0, $zero, $s2 # set $t0 as temporary pointer
		add $t1, $0, $0 # set t1 as iterator for loop
	
input:	
		li $v0, 5 # read integer
		syscall
		
		sw $v0, 0($t0) # save input integer to t1-th element of the array
		addi $t0, $t0, 4 # move the pointer to the next element
		addi $t1, $t1, 1
		slti $t2, $t1, 10 # check if the number of elements in the array is 10
		beq $t2, 	1, input 
		j sort

sort:		# use insertion sort to sort the array
		addi $t0, $s2, 4 # set t0 as pointer to the second element of unsorted array 
		addi $t3, $zero, 1 # set t3 as the number of element in the sorted array

loop:	
		addi $t4, $t0, 0 # set t4 as temporary pointer to the first element of unsorted array (for sorting)
		jal findPos
		addi $t0, $t0, 4 # increase pointer t0
		addi $t3, $t3, 1 # one more element is sorted
		slti $t2, $t3, 10 # check the number of element in the sorted array
		beq $t2, 1, loop # if not 10, loop again
		j print #else print
		
findPos:	
		# save ra to $sp
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		lw $t6, 0($t4) # t6 as arr[j]
		lw $t7, -4($t4) # t7 as arr[j-1]
		slt $t2, $t7, $t6 # if arr[j-1] < arr[j]
		beq $t2, 0, goback
		
swap:	# swap a[j] and a[j-1]
		lw $t8, 0($t4) # t3 as a[j]
		lw $t5, -4($t4) # t5 as a[j-1] 
		sw $t8, -4($t4)
		sw $t5, ($t4)
		
		addi $t4, $t4, -4 # move backward one element
		slt $t2, $s2, $t4 # check if j (t4) is at the first element (cannot move backward)
		beq $t2, 1, findPos
		
goback:
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
		
print:	
		move $a0, $s1 # print output msg
		li $v0, 4
		syscall 
		
		add $t0, $zero, $s2 # set $t0 as temporary pointer
		add $t1, $0, $0 # set t1 as iterator
		
loopPrint:
		lw $a0, 0($t0) # print t1-th element
		li $v0, 1
		syscall
		
		move $a0, $s3 # print gap
		li $v0, 4
		syscall 
		
		addi $t0, $t0, 4
		addi $t1, $t1, 1
		slti $t2, $t1, 10 # check if the number of elements in the array is 10
		beq $t2, 	1, loopPrint 
		j exit

 exit: 
