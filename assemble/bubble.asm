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
 
 j sort
 
swapNeighborIfGreater:
 lw $t1, 0($a0) 
 lw $t2, 4($a0) 
 ble $t1, $t2, swapNeighborIfGreaterSkip #if(a>b) swap(a,b)
 sw $t2, 0($a0)
 sw $t1, 4($a0)
swapNeighborIfGreaterSkip:
 jr $ra
 
sort:
 ble $s1, 1, printArrayContentStart
 addi $t0, $s1, -1
 bltz $t0, terminateProgram
 sll $t0, $t0, 2
 li $t1, 0
loop_out:
 li $t2, 0
 subu $t3, $t0, $t1
	loop_in:
	 addu $a0, $s2, $t2
	 move $s4, $t1
	 move $s5, $t2
	 jal swapNeighborIfGreater
	 move $t1, $s4
	 move $t2, $s5
 	 addiu $t2, $t2, 4
 	 blt $t2, $t3, loop_in
 addiu $t1, $t1, 4
 blt $t1, $t0, loop_out
 
 printArrayContentStart:
 #printing array content
 li $t0, 0
 sll $t3, $s1, 2
 printArrayContent:
 addu $t1, $s2, $t0
 lw $a0, 0($t1)
 li $v0, 1
 syscall
 la $a0, space
 li $v0, 4
 syscall
 addiu $t0, $t0, 4
 blt $t0, $t3, printArrayContent
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
