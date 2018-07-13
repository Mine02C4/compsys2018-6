	lui $30,0x0001
	add $1,$0,$0
	addi $2,$0,1
loop: add $3,$2,$1
	add $1,$0,$2
	add $2,$0,$3
	j loop
