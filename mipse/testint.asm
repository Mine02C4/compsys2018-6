	lui $29,0xa100
lpin:	lb $28,3($29)
	beq $28,$0,lpin
	lb $28,2($29)
	lui $29,0xa000
lpo: lb $27,3($29)
	beq $27,$0,lpo
	sb $28,2($29)
	rfe
