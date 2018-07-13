	lui $1,0xa100
lpin:	lb $2,3($1)
	beq $2,$0,lpin
	lb $2,2($1)
	lui $1,0xa000
lpo: lb $3,3($1)
	beq $3,$0,lpo
	sb $2,2($1)
	rfe
