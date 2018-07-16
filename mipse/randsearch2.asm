lb $1, $0, 0      // reg1 = n_nodes;
lb $2, $0, 1      // reg2 = n_edges;
addi $11, $0, 10  // reg11 = 10;  // 乱数ループ上限
addi $8, $0, -1   // first: reg8 = -1;
addi $8, $8, 1    // node_loop: reg8++;
beq $8, $1, 37    // if (reg8 == reg1) goto node_loop_post;
addi $9, $0, 0    // reg9 = 0;
rand $3           // node_try_loop: reg3 = genrand();
andi $3, $3, 3    // reg3 = reg3 & 3;
add $12, $8, $8
add $12, $12, $12 // (x4 for 32bit storage)
sw $3, $12, 1024  // nodes[reg8] = reg3;
addi $10, $0, 1   // reg10 = 1;
addi $7, $0, -1   // reg7 = -1;
addi $7, $7, 1    // edge_loop: reg7++;
beq $7, $2, 21    // if (reg7 == reg2) goto edge_loop_post;
add $12, $7, $7
add $12, $12, $12 // (x4 for 32bit storage)
lb $5, $12, 2     // reg5 = edges[reg7].first;
lb $6, $12, 3     // reg6 = edges[reg7].second;
sub $3, $5, $8    // reg3 = reg5 - reg8;
sub $4, $6, $8    // reg4 = reg6 - reg8;
and $3, $3, $4    // reg3 = reg3 & reg4;
bne $3, $0, -10   // if (reg3) goto edge_loop;
slt $3, $8, $5    // reg3 = reg8 < reg5;
slt $4, $8, $6    // reg4 = reg8 < reg6;
or $3, $3, $4     // reg3 = reg3 | reg4;
bne $3, $0, -14   // if (reg3) goto edge_loop;
add $12, $5, $5
add $12, $12, $12 // (x4 for 32bit storage)
lw $3, $12, 1024  // reg3 = nodes[reg5];
add $12, $6, $6
add $12, $12, $12 // (x4 for 32bit storage)
lw $4, $12, 1024  // reg4 = nodes[reg6];
bne $3, $4, -21   // if (reg3 != reg4) goto edge_loop;
addi $10, $0, 0   // reg10 = 0;
beq $0, $0, -23   // goto edge_loop;
addi $9, $9, 1    // edge_loop_post: reg9++;
sub $3, $9, $11   // reg3 = (reg9 - reg11);
nor $3, $3, $10   // reg3 = !reg3 & !reg10;
bne $3, $0, -38   // if (reg3) goto first; // Search from the first again...
beq $10, $0, -35  // if (!reg10) goto node_try_loop;
beq $0, $0, -39   // goto node_loop;
sw $2, $0, 32767  // node_loop_post: ダミーの書き込み(これでシミュレーターが止まる)
beq $0, $0, -1    // 実機用のループ
