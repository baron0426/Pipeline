j Main
j Interrupt
j Exception
Main: lui $t0, 0x3000
      add $a0, $zero, $zero
      lw $t1, 0($t0)
      lw $t2, 4($t0)
      sw $t1, 0($a0)
      sw $t2, 4($a0)
Loop: beq $zero, $zero, Loop
Interrupt: beq $zero, $zero, Interrupt
Exception: beq $zero, $zero, Exception 