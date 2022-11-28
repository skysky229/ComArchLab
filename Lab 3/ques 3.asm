.data
fout: .asciiz "C:\\Users\\HUY\\Downloads\\ComArch\\Lab 3\\ques 3.txt" # filename for output
buffer_read: .space 1000
.text
	###############################################################
	
	# Open (for reading) a file
	li $v0, 13 # system call for open file
	la $a0, fout # input file name
	li $a1, 0 # Open for reading (flags are 0: read, 1: write)
	li $a2, 0 # mode is ignored	
	syscall # open a file (file descriptor returned in $v0)
	move $s6, $v0 # save the file descriptor

	###############################################################

	# Read from file
	li $v0, 14 # system call for read
	move $a0, $s6 # file descriptor
	la $a1, buffer_read # address of buffer read
	li $a2, 1000 # hardcoded buffer length
	syscall # read file
	
	###############################################################

	# Close the file
	li $v0, 16 # system call for close file
	move $a0, $s6 # file descriptor to close
	syscall # close file
	
input:
	li 	$v0, 9 # system call code for dynamic allocation
	li 	$a0, 1000 # $a0 contains number of bytes to allocate
	syscall
	
	move 	$s1, $v0 # a0 will store the first address in heap memory that is allocated
	
	la 	$s0, buffer_read # store the address of read input
	li 	$t0, 0 # iterator
	
copyLoop:
	lb 	$t1, 0($s0) 
	sb 	$t1, 0($s1) # save to the heap memory
	addi 	$s1, $s1, 1 
	addi 	$s0, $s0, 1
	addi	$t0, $t0, 1
	slti 	$t2, $t0, 1000 # if the end of array is not reached yet
	beq	$t2, 1, copyLoop
	
	move 	$a0, $v0
	li	$v0, 4 # print output 
	syscall
