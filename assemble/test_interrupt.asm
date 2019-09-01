j Main
j Interrupt
j Exception
Main:lui $t0, 0x4000




Loop: beq $zero, $zero, Loop
Interrupt: beq $zero, $zero, Interrupt
Exception: beq $zero, $zero, Exception 