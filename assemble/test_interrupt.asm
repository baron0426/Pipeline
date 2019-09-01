j Main
j Interrupt
j Exception
Main:addi $t0, $zero, 0x40000014
lw $gp, 0($t0)
addi $a0, $zero, 3  #set the value n
jal sum #run sum(n) to calculate the sum from 1 to n
addi $t0, $zero, 0x40000014
lw $t1, 0($t0)
sub $gp, $t1, $gp #$gp save the total period elapsed
add $s2, $zero, $zero #$s2 indicate if $gp has been displayed 
addi $s0, $zero, 0xfffffff0  #CHANGE WHEN IMPLEMENT WITH HARDWARE
addi $s1, $zero, 0x40000000 #$s1 save the base address of the timer
sw $s0, 0($s1) 
addi $s0, $zero, 0x0003 #$s0 save the TCON variable of the timer
sw $s0, 8($s1)
Loop:    beq $zero, $zero, Loop  #construct an infinite loop for the program to stuck in after all the codes above are executed.
Loop2:    beq $zero, $zero, Loop2
sum:     addi $sp, $sp, -8 #building function stack of sum(m)
	sw $ra,  4($sp)  #pushing return address (of the OS or sum(m+1) )$ra into the function stack of sum (m)
	sw $a0, 0($sp)   #pushing "m" into the function stack of sum(m)
	slti $t0, $a0, 1
	beq $t0, $zero, L1 #the two lines are equivalent to if(m >= 1) goto L1;
	xor $v0, $zero, $zero #if(m==0) let $v0 = sum(0) =  0;
	addi $sp, $sp, 8  #destroying function stack of sum(0)
	jr $ra            #return $v0;
L1:     addi $a0, $a0, -1 #Let m = m-1;
	jal sum #call sum(m-1);
	lw $a0,  0($sp)  #popping return address $ra from the function stack of sum (m)
	lw $ra, 4($sp)   #popping "m" from the function stack of sum(m)
	addi $sp, $sp, 8 #destroying function stack of sum(m)
	add $v0, $a0, $v0 #let $v0 =  sum(m) = m + sum(m-1)
	jr $ra           #return $v0 to  sum(m+1) or the OS
Interrupt: 
andi $s0, $s0, 0x0000
sw $s0, 8($s1)
bgt $s2, 11,  changeResult #CHANGE WHEN IMPLEMENT WITH HARDWARE
ProcStart:addi $s3, $s3, 0 #$s3 = {digit_en, digit}
andi $t1, $s3, 0x00000f00
ori $s3, $s3, 0x0f00
beq $t1, 0x0e00, Digit1110
beq $t1, 0x0d00, Digit1101
beq $t1, 0x0b00, Digit1011
beq $t1, 0x0700, Digit0111
j DigitProcEnd
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
jr $k1
changeResult: add $gp, $zero, $v0
j ProcStart
Exception: beq $zero, $zero, Exception 
