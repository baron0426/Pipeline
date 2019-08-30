j Main
j Interrupt
j Exception
Main: addi $a0, $zero, 3
mul $a0, $a0, 2
addi $a0, $a0, 2
Loop: beq $zero, $zero, Loop
Interrupt:nop
Exception:
addi $a0, $a0, 1
jr $k0


