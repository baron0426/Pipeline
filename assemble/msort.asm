.data
	in_buff: .space 20
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
	move $s0, $v0 # $s0 = pointer of input file
	#read the first element N
	move $a0, $s0
	la $a1, in_buff
	li $a2, 4
	li $v0, 14
	syscall
	lw $s1, 0($a1) #$s1 = N
	#creating the head node
	li $a0, 8
	li $v0, 9
	syscall
	sw $zero, 4($v0)
	move $s2, $v0 #$s2 = the head node
	move $t1, $s2 #$t1 = the iterator
	li $t0, 1 #$t0 = the counter
createLinkedListLoop:
	li $a0, 8
	li $v0, 9
	syscall
	#load the array to a linked list
	sw $zero ,4($v0)
	sw $v0, 4($t1)
	move $t1, $v0
	move $a0, $s0
	la $a1, in_buff
	li $a2, 4
	li $v0, 14
	syscall
	lw $t2, 0($a1)
	sw $t2, 0($t1)
	addiu $t0, $t0, 1
	ble $t0, $s1, createLinkedListLoop
	#close the file
	li $v0, 16
	syscall 
	#move $a0, $s2
	#j printArrayContent #j msort
	lw $a0, 4($s2)
	beqz $a0, printArrayContent
	jal msort
	sw $v0, 4($s2)
	j printArrayContent

merge: #$a0 = left_head, $a1 = right_head
	move $t1, $a0
	move $t2, $a1
	li $v0, 9
	li $a0, 8
	syscall
	sw $t1, 4($v0)
	move $t0, $v0 #$t0 = head, $t1 = p_left, $t2 = p_right
	move $t1, $v0
	lw $t3, 0($t1)
mergeInLoop1:
	lw $t3, 4($t1) #$t3 = p_left->next
	beqz $t3, exitMergeInLoop12
	lw $t3, 0($t3) #$t3 = *(p_left->next)
	lw $t4, 0($t2) #$t4 = *(p_right)
	bgt $t3, $t4, exitMergeInLoop1
	lw $t1, 4($t1)
	j mergeInLoop1
exitMergeInLoop12:
	sw $t2, 4($t1)
	lw $v0, 4($t0) #return p_left
	jr $ra
exitMergeInLoop1:	
	move $t4, $t2 #$t4 =  right_temp
MergeInLoop2:
	lw $t5, 4($t4)
	beqz $t5, exitMergeInLoop2
	lw $t5 , 0($t5) #$t5 = *(right_temp->next)
	bgt $t5, $t3, exitMergeInLoop2
	lw $t4, 4($t4)
	j MergeInLoop2	
exitMergeInLoop2:
	#$t0 = head, $t1= p_left, $t2 = p_right, $t4= right_temp
	lw $t3, 4($t1) #$t3 = left_temp_next =  p_left->next
	lw $t5, 4($t4) #$t5 = right_temp_next = right_temp->next
	sw $t3, 4($t4) #right_temp->next = p_left->next
	sw $t2, 4($t1) #p_left->next = p_right
	move $t2, $t5 #p_right ->right_temp_next
	beqz $t2, exitMerge
	move $t1, $t3 # p_left = left_temp_next
	j mergeInLoop1
exitMerge:
	lw $v0, 4($t0) #return p_left
	jr $ra
	

msort:
	move $t0, $a0 
	lw $t1, 4($t0)
	bnez $t1, continueMsort
	move $v0, $a0
	jr $ra
continueMsort:
	move $t1, $a0 #$t1 = stride_1_pointer
	move $t2, $a0 #$t2 = stride_2_pointer
	lw $t2, 4($t2)	#$t2= stride_2_pointer->next
	beqz $t2, exitMidPointLoop
midPointLoop:
	#find midpoint
	lw $t2, 4($t2)	#$t2= stride_2_pointer->next
	beqz $t2, exitMidPointLoop
	lw $t1, 4($t1) #$t1 = stride_1_pointer->next
	lw $t2, 4($t2) #$t2 = stride_2_pointer->next
	beqz $t2, exitMidPointLoop
	j midPointLoop
exitMidPointLoop:
	lw $t2, 4($t1) #$t2 = stride_2_pointer = stride_1_pointer->next
	sw $zero, 4($t1) #stride_1_pointer->next = NULL
	
	move $a0, $t0
	subi $sp, $sp, 8
	sw $ra, 0($sp)
	sw $t2, 4($sp) #preserving the current local variables
	jal msort
	move $t3, $v0 #$t3= l_head
	lw $ra, 0($sp) #releasing the current local variables
	lw $t2, 4($sp)
	addi $sp, $sp, 8
	
	move $a0, $t2
	subi $sp, $sp, 8
	sw $ra, 0($sp)
	sw $t3, 4($sp)
	jal msort
	move $t4, $v0 #$t4 = r_head
	lw $ra, 0($sp)
	lw $t3, 4($sp)
	addi $sp, $sp, 8
	
	move $a0, $t3
	move $a1, $t4
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	jal merge
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
printArrayContent:
	#open file to be write
	la $a0, output
	li $a1, 1
	li $a2, 0
	li $v0, 13
	syscall
	move $s0, $v0
	#printing array content
	lw $t0, 4($s2) #next element pointer
printArrayContentLoop:
	lw $t1, 0($t0)
	move $a0, $t1
	li $v0, 1
	syscall
	la $a0, space
	li $v0, 4
	syscall
	#write the file
	move $a0, $s0 # $a0 = pointer of input_file
	move $a1, $t0
	li $a2, 4
	li $v0, 15
	syscall
	lw $t0, 4($t0)
	bnez $t0, printArrayContentLoop
	#close the file
	li $v0, 16
	syscall
 terminateProgram:
	li $v0, 10
	syscall
