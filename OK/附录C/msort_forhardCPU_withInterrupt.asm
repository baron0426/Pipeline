j Main
j Interrupt
j Exception
Main:addi $t0, $zero, 0x40000014
	lw $gp, 0($t0)
	add $k1, $zero, $zero
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
	move $t0, $k1 #$t0 = head, $t1 = p_left, $t2 = p_right
	move $t1, $k1
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
printArrayContent:lw $t8, 0($zero)
addi $t0, $zero, 0x40000014
lw $t1, 0($t0)
sub $gp, $t1, $gp #$gp save the total period elapsed
add $s2, $zero, $zero #$s2 indicate if $gp has been displayed 
addi $s0, $zero, 0xfffec77f  #CHANGE WHEN IMPLEMENT WITH HARDWARE
addi $s1, $zero, 0x40000000 #$s1 save the base address of the timer
sw $s0, 0($s1) 
addi $s0, $zero, 0x0003 #$s0 save the TCON variable of the timer
addi $s3, $zero, 0x0fff #$s3 = {digit_en, digit}
sw $s0, 8($s1)
Loop: beq $zero, $zero, Loop
Interrupt:andi $s0, $s0, 0x0000
sw $s0, 8($s1)
bgt $s2, 2000,  changeResult #CHANGE WHEN IMPLEMENT WITH HARDWARE
ProcStart: andi $t1, $s3, 0x00000f00
ori $s3, $s3, 0x0f00
beq $t1, 0x0e00, Digit1110
beq $t1, 0x0d00, Digit1101
beq $t1, 0x0b00, Digit1011
beq $t1, 0x0700, Digit0111
j Digit0111
Digit1110:andi $s3, $s3, 0x0dff
srl  $a0, $gp, 4
j DigitProcEnd
Digit1101:andi $s3, $s3, 0x0bff
srl  $a0, $gp, 8
j DigitProcEnd
Digit1011:andi $s3, $s3, 0x07ff
srl  $a0, $gp, 12
j DigitProcEnd
Digit0111:andi $s3, $s3, 0x0eff
srl  $a0, $gp, 0
j DigitProcEnd
DigitProcEnd:ori $s3, $s3, 0x00ff
andi $a0, $a0, 0x000f
beq $a0, 0x0000, Number0
beq $a0, 0x0001, Number1
beq $a0, 0x0002, Number2
beq $a0, 0x0003, Number3
beq $a0, 0x0004, Number4
beq $a0, 0x0005, Number5
beq $a0, 0x0006, Number6
beq $a0, 0x0007, Number7
beq $a0, 0x0008, Number8
beq $a0, 0x0009, Number9
beq $a0, 0x000a, NumberA
beq $a0, 0x000b, NumberB
beq $a0, 0x000c, NumberC
beq $a0, 0x000d, NumberD
beq $a0, 0x000e, NumberE
beq $a0, 0x000f, NumberF
j NumberProcEnd
Number0: andi $s3, $s3, 0x0f40 
j NumberProcEnd
Number1: andi $s3, $s3, 0x0f79 
j NumberProcEnd
Number2: andi $s3, $s3, 0x0f24 
j NumberProcEnd
Number3: andi $s3, $s3, 0x0f30 
j NumberProcEnd
Number4: andi $s3, $s3, 0x0f19 
j NumberProcEnd
Number5: andi $s3, $s3, 0x0f12 
j NumberProcEnd
Number6: andi $s3, $s3, 0x0f02 
j NumberProcEnd
Number7: andi $s3, $s3, 0x0f78 
j NumberProcEnd
Number8: andi $s3, $s3, 0x0f00 
j NumberProcEnd
Number9: andi $s3, $s3, 0x0f10 
j NumberProcEnd
NumberA: andi $s3, $s3, 0x0f08 
j NumberProcEnd
NumberB: andi $s3, $s3, 0x0f03 
j NumberProcEnd
NumberC: andi $s3, $s3, 0x0f46 
j NumberProcEnd
NumberD: andi $s3, $s3, 0x0f21
j NumberProcEnd
NumberE: andi $s3, $s3, 0x0f06 
j NumberProcEnd
NumberF: andi $s3, $s3, 0x0f0e 
j NumberProcEnd
NumberProcEnd:sw $s3, 16($s1)
addi $s2, $s2, 1
ori $s0, $s0, 0x0003
sw $s0, 8($s1)
jr $k0
changeResult:lw $gp, 0($t8)
	add $s2, $zero, $zero
	lw $t8, 4($t8)
	j ProcStart
Exception: beq $zero, $zero, Exception 
