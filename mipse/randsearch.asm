lb $2, $0, 0
lb $3, $0, 1
addi $4, $0, 3
add $1, $2, $0
add $1, $2, $1
add $1, $2, $1
add $1, $2, $1
addi $1, $1, -4
rand $5
and $5, $5, $4
sw $5, $1, 1024
bne $1, $0, -5
add $1, $3, $0
add $1, $3, $1
addi $1, $1, -1
lb $6, $1, 2
add $6, $6, $6
add $6, $6, $6
addi $1, $1, -1
lb $7, $1, 2
add $7, $7, $7
add $7, $7, $7
lw $8, $6, 1024
lw $9, $7, 1024
beq $8, $9, -22
bne $1, $0, -12
sw $3, $0, 32767
beq $0, $0, -1

