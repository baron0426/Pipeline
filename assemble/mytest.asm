addi $2, $0, 16
add $4, $0, $0
beq $4, $0, T1
T2: addi $4, $4, -5
bltzal $4, T3
T1: addi $4, $4, 3
bne $0, $0, T1
addi $4, $4, -5
blez $4, T2
bgezal $4, T4
T3: addi $4, $4, 10
add $2, $0, $4
addi $3, $0, 16
bge $2, $3, Loop
jr $ra
T4: addi $4, $4, 5
jr $ra
Loop: beq $0, $0, Loop
#Loop:nop