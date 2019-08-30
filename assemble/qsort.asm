.data
	 in_buff: .space 5000
	input: .asciiz "a.in"
	output: .asciiz "a.out"
	space: .asciiz " "
	newline: .asciiz "\n"
.text
main:
	#open file to be read
	la $a0, input
	li $a1, 0
	li $a2, 0
	li $v0, 13
	syscall
	move $a0, $v0 # $a0 = pointer of input_file
	#read the first element N
	la $a1, in_buff
	li $a2, 4
	li $v0, 14
	syscall
	lw $s1, 0($a1) #$s1 = N
	#load the whole array
	li $v0, 14
	sll $a2, $s1, 2
	syscall
	la $s2, in_buff #$s2 = pointer to the array
	#close the file
	li $v0, 16
	syscall
	ble $s1, 1, printArrayContent
	move $a0, $s2
	move $a1, $zero
	move $a2, $s1
	addiu $a2, $a2, -1
	sll $a2, $a2, 2
	jal qsort
	j printArrayContent
qsort:
	#array = $a0
	move $t1, $a1 # qsort start, i = $t1 = $a1 = left
	move $t2, $a2 # j = $t2 = $a2 = right
	addu $t3, $t1, $t2
	srl $t3, $t3, 2
	divu $t3, $t3, 2
	sll $t3, $t3, 2
	addu $t3, $t3, $a0
	lw $t3, 0($t3) #mid = $t3	
qsortLoopOut:
	bgt $t1, $t2, qsortLoopSkip
qsortLoopi:
	addu $t8, $t1, $a0
	lw $t9, 0($t8)
	bge $t9, $t3, qsortLoopj #if(arr[i] >= mid) break;
	addiu $t1, $t1, 4 # i++;
	j qsortLoopi
qsortLoopj:
	addu $t8, $t2, $a0
	lw $t9, 0($t8)
	ble $t9, $t3, qsortLoopijEnd #if(arr[j] <= mid) break; 
	addiu $t2, $t2, -4 #j++;
	j qsortLoopj
qsortLoopijEnd:
	bgt $t1, $t2, qsortLoopContinue
	addu $t7, $a0, $t1
	addu $t8, $a0, $t2
	lw $t5, 0($t7) #tmp = arr[i]
	lw $t6, 0($t8) #tmp2 = arr[j]
	sw $t6, 0($t7) #arr[i] = tmp2 (== arr[j])
	sw $t5, 0($t8) #arr[j] = temp
	addiu $t1, $t1, 4 #i++
	addi $t2, $t2, -4 #j--
qsortLoopContinue:
	j qsortLoopOut
qsortLoopSkip:
	bge $a1, $t2, leftSeqSkip
	subi $sp, $sp, 20
	sw $ra, 0($sp)  #return address
	sw $a1, 4($sp)  #left
	sw $a2, 8($sp)  #right
	sw $t1, 12($sp)  #i
	sw $t2, 16($sp)  #j, preserving the current local variables
	move $a2, $t2
	jal qsort
	lw $ra, 0($sp) #return address
	lw $a1, 4($sp) #left
	lw $a2, 8($sp) #right
	lw $t1, 12($sp) #i
	lw $t2, 16($sp)  #j, preserving the current local variables
	addi $sp, $sp, 20
leftSeqSkip:
	bge $t1, $a2, rightSeqSkip
	subi $sp, $sp, 12
	sw $ra, 0($sp)  #return address
	sw $a2, 4($sp)  #right
	sw $t1, 8($sp)  #i, preserving the current local variables
	move $a1, $t1
	jal qsort
	lw $ra, 0($sp)  #return address
	lw $a2, 4($sp)  #right
	lw $t1, 8($sp)  #preserving the current local variables
	addi $sp, $sp, 12
rightSeqSkip:
	jr $ra

printArrayContent:
	#printing array content
	li $t0, 0
	sll $t3, $s1, 2
printArrayContentLoop:
	addu $t1, $s2, $t0
	lw $a0, 0($t1)
	li $v0, 1
	syscall
	la $a0, space
	li $v0, 4
	syscall
	addiu $t0, $t0, 4
	blt $t0, $t3, printArrayContentLoop
	#open file to be write
	la $a0, output
	li $a1, 1
	li $a2, 0
	li $v0, 13
	syscall
	#write the file
	move $a0, $v0 # $a0 = pointer of input_file
	move $a1, $s2
	move $a2, $s1
	sll $a2, $a2, 2
	li $v0, 15
	syscall
	#close the file
	li $v0, 16
	syscall
 terminateProgram:
	li $v0, 10
	syscall