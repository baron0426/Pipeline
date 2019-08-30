j Main
j Interrupt
j Exception
Main:add $k1, $zero, $zero
	lui $s0, 0x3000 #$s0 = address of the start of data
	#read the first element N
	lw $s1, 0($s0) #$s1 = N
	#creating the head node
	sw $zero, 4($k1)
	move $s2, $k1 #$s2 = the head node
	move $t1, $s2 #$t1 = the iterator
	li $t0, 1 #$t0 = the counter
createLinkedListLoop:addi $k1, $k1, 8
	#load the array to a linked list
	sw $zero ,4($k1)
	sw $k1, 4($t1)
	move $t1, $k1
	sll $t3, $t0, 2 #CHECK!
	add $t3, $t3, $s0
	lw $t2, 0($t3)
	sw $t2, 0($t1)
	addiu $t0, $t0, 1
	ble $t0, $s1, createLinkedListLoop
	#j printArrayContent #j msort
	lw $a0, 4($s2)
	beqz $a0, printArrayContent
	jal msort
	sw $v0, 4($s2)
	j printArrayContent

merge: move $t1, $a0 #$a0 = left_head, $a1 = right_head
	move $t2, $a1
	addi $k1, $k1, 8
	sw $t1, 4($k1)
	move $t0, $v0 #$t0 = head, $t1 = p_left, $t2 = p_right
	move $t1, $v0
	lw $t3, 0($t1)
mergeInLoop1:lw $t3, 4($t1) #$t3 = p_left->next
	beqz $t3, exitMergeInLoop12
	lw $t3, 0($t3) #$t3 = *(p_left->next)
	lw $t4, 0($t2) #$t4 = *(p_right)
	bgt $t3, $t4, exitMergeInLoop1
	lw $t1, 4($t1)
	j mergeInLoop1
exitMergeInLoop12:sw $t2, 4($t1)
	lw $v0, 4($t0) #return p_left
	jr $ra
exitMergeInLoop1:	move $t4, $t2 #$t4 =  right_temp
MergeInLoop2:lw $t5, 4($t4)
	beqz $t5, exitMergeInLoop2
	lw $t5 , 0($t5) #$t5 = *(right_temp->next)
	bgt $t5, $t3, exitMergeInLoop2
	lw $t4, 4($t4)
	j MergeInLoop2	
exitMergeInLoop2:lw $t3, 4($t1) #$t3 = left_temp_next =  p_left->next #$t0 = head, $t1= p_left, $t2 = p_right, $t4= right_temp
	lw $t5, 4($t4) #$t5 = right_temp_next = right_temp->next
	sw $t3, 4($t4) #right_temp->next = p_left->next
	sw $t2, 4($t1) #p_left->next = p_right
	move $t2, $t5 #p_right ->right_temp_next
	beqz $t2, exitMerge
	move $t1, $t3 # p_left = left_temp_next
	j mergeInLoop1
exitMerge:lw $v0, 4($t0) #return p_left
	jr $ra
	

msort:move $t0, $a0 
	lw $t1, 4($t0)
	bnez $t1, continueMsort
	move $v0, $a0
	jr $ra
continueMsort:move $t1, $a0 #$t1 = stride_1_pointer
	move $t2, $a0 #$t2 = stride_2_pointer
	lw $t2, 4($t2)	#$t2= stride_2_pointer->next
	beqz $t2, exitMidPointLoop
midPointLoop:lw $t2, 4($t2)	#$t2= stride_2_pointer->next #find midpoint
	beqz $t2, exitMidPointLoop
	lw $t1, 4($t1) #$t1 = stride_1_pointer->next
	lw $t2, 4($t2) #$t2 = stride_2_pointer->next
	beqz $t2, exitMidPointLoop
	j midPointLoop
exitMidPointLoop:lw $t2, 4($t1) #$t2 = stride_2_pointer = stride_1_pointer->next
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
#printing array content	
printArrayContent:lw $t0, 4($s2) #next element pointer
printArrayContentLoop:lw $t1, 0($t0)
	lw $t0, 4($t0)
	bnez $t0, printArrayContentLoop
Loop: beq $zero, $zero, Loop
Interrupt: beq $zero, $zero, Interrupt
Exception: beq $zero, $zero, Exception 
