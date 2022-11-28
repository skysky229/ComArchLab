.data 	
	input_msg: .asciiz "Choose the shape you want to calculate: rectangle (0), square (1)"
	inp_rec_height: .asciiz "Input the height: "
	inp_rec_width: .asciiz "Input the width: "
	inp_sqr: .asciiz "Input the edge: "
	output_msg: .asciiz "The area is: "
	const0: .float 0
	
.text

main:
	jal 	input
	jal 	calc
	jal 	output
	jal 	exit
	
input:
	la 	$a0, input_msg
	li 	$v0, 4
	syscall
	
	li	$v0, 5
	syscall
	
	move 	$s0, $v0 # save user choice
	beq 	$s0, 0, inputRec # input rectangle
	beq	$s0, 1, inputSqr # input square
	
inputRec: 
	la 	$a0, inp_rec_height
	li 	$v0, 4
	syscall
	li	$v0, 6
	syscall 
	
	lwc1 	$f1, const0
	add.s	$f1, $f1, $f0
	
	la 	$a0, inp_rec_width
	li 	$v0, 4
	syscall
	li	$v0, 6
	syscall 
	
	lwc1 	$f2, const0
	add.s	$f2, $f2, $f0
	jr 	$ra
	
inputSqr:
	la 	$a0, inp_sqr
	li 	$v0, 4
	syscall
	li	$v0, 6
	syscall 
	
	lwc1 	$f3, const0
	add.s	$f3, $f3, $f0
	jr 	$ra
	
calc:
	beq	$s0, 0, calcRec # calcRectangle
	beq 	$s0, 1, calcSqr # calc Square
	
calcRec:
	mul.s	$f12, $f1, $f2
	jr 	$ra
	
calcSqr:
	mul.s	$f12, $f3, $f3
	jr	$ra

output:
	la 	$a0, output_msg
	li	$v0, 4
	syscall
	
	li 	$v0, 2
	syscall
	jr 	$ra

exit:
