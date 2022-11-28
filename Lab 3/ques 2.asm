.data 
	inp_A: .asciiz "Please input A:"
	inp_B: .asciiz "Please input B:"
	inp_C: .asciiz "Please input C:"
	inp_U: .asciiz "Please input U:"
	inp_V: .asciiz "Please input V:"
	out_msg: .asciiz "The integral is: "
	const0: .float 0.0 
	step: .float 2000 
	
.text
main:
	jal	input
	jal 	calc
	jal 	output
	jal 	exit
	
input:
	# f1 will store A, f2 = B, f3 = C, f4 = U, f5 = V
	la	$a0, inp_A
	li	$v0, 4
	syscall
	
	li	$v0, 6
	syscall 
	
	mov.s	$f1, $f0 
	
	#input B
	la	$a0, inp_B
	li	$v0, 4
	syscall
	
	li	$v0, 6
	syscall 
	
	mov.s	$f2, $f0 
	
	#input C
	la	$a0, inp_C
	li	$v0, 4
	syscall
	
	li	$v0, 6
	syscall 
	
	mov.s	$f3, $f0 
	
	#input U
	la	$a0, inp_U
	li	$v0, 4
	syscall
	
	li	$v0, 6
	syscall 
	
	mov.s	$f4, $f0 
	
	#input V
	la	$a0, inp_V
	li	$v0, 4
	syscall
	
	li	$v0, 6
	syscall 
	
	mov.s	$f5, $f0 
	
	jr	$ra # back to main

func:
	mul.s 	$f8, $f7, $f7 # x^2
	mul.s	$f8, $f8, $f1 # ax^2
	
	mul.s 	$f10, $f7, $f2 # bx
	
	add.s	$f8, $f8, $f10 # ax^2 + bx
	add.s	$f8, $f8, $f3 # ax^2 + bx + c
	jr	$ra # back to calcLoop

calc:
	lwc1	$f7, step 
	sub.s 	$f6, $f5, $f4
	div.s 	$f6, $f6, $f7 # f6 will store the length of each step
	
	li	$t0, 0 # use t0 as iterator
	move	$t1, $ra # t1 will temporarily store the return address
	mov.s	$f7, $f4 # f7 will store the x at the current 
	lwc1	$f11, const0 # f12 will store the answer

calcLoop:
	jal	func # jump to the function, return the value at the current x in $f8
	mul.s	$f9, $f8, $f6 # f(x)*step
	add.s	$f11, $f11, $f9 # add to the answer
	add.s	$f7, $f7, $f6 # move to the next x
	addi	$t0, $t0, 1
	slti	$t2, $t0, 2000 # if the iterator is still smaller than 2000
	beq	$t2, 1, calcLoop

	move 	$ra, $t1 
	jr	$ra

output:
	la	$a0, out_msg
	li	$v0, 4
	syscall 
	
	mov.s	$f12, $f11
	li	$v0, 2
	syscall
	jr	$ra
	
exit: