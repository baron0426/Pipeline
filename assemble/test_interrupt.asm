j Main
j Interrupt
j Exception
Main:addi $t0, $zero, 0x40000014
lw $gp, 0($t0)
addi $a0, $zero, 3  #set the value n
jal sum #run sum(n) to calculate the sum from 1 to n
addi $t0, $zero, 0x40000014
lw $t1, 0($t0)
sub $gp, $t1, $gp
add $s1, $zero, $zero
addi $t0, $zero, 0xfffffff0

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
Interrupt: jr $k1
Exception: beq $zero, $zero, Exception 