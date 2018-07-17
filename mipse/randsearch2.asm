addi $1, $0, 0    //  $1 = 0;
lb $2, $0, 0      //  $2 = n_nodes;
lb $3, $0, 1      //  $3 = n_edges;
addi $12, $0, 10  //  $12 = 10;
addi $1, $1, 1    //first: $1++;  // (debug)
addi $9, $0, -1   //  $9 = -1;
addi $9, $9, 1    //node_loop: $9 = $9 + 1;
beq $9, $2, 39    //  if ($9 == $2) goto node_loop_post;
addi $10, $0, 0   //  $10 = 0;  // Decide one node color
rand $4           //node_try_loop: $4 = genrand();
andi $4, $4, 3    //  $4 = $4 & 3;
add $13, $9, $9
add $13, $13, $13 // (x4 for 32bit storage)
sw $4, $13, 1024  //  nodes[$9] = $4;
addi $11, $0, 1   //  $11 = 1;  // Check for each edge
addi $8, $0, -1   //  $8 = -1;
addi $8, $8, 1    //edge_loop: $8 = $8 + 1;
beq $8, $3, 21    //  if ($8 == $3) goto edge_loop_post;
add $13, $8, $8   // (x2)
lb $6, $13, 2     //  $6 = edges[$8].first;
lb $7, $13, 3     //  $7 = edges[$8].second;
sub $4, $6, $9    //  $4 = $6 - $9;  // Consider only current node
sub $5, $7, $9    //  $5 = $7 - $9;
and $4, $4, $5    //  $4 = $4 & $5;
bne $4, $0, -9    //  if ($4 != 0) goto edge_loop;
slt $4, $9, $6    //  $4 = $9 < $6;  // Ignore edge for later node
slt $5, $9, $7    //  $5 = $9 < $7;
or $4, $4, $5     //  $4 = $4 | $5;
bne $4, $0, -13   //  if ($4 != 0) goto edge_loop;
add $13, $6, $6
add $13, $13, $13 // (x4 for 32bit storage)
lw $4, $13, 1024  //  $4 = nodes[$6];  // Check color validness
add $13, $7, $7
add $13, $13, $13 // (x4 for 32bit storage)
lw $5, $13, 1024  //  $5 = nodes[$7];
sub $4, $4, $5    //  $4 = $4 - $5;
bne $4, $0, -21   //  if ($4 != 0) goto edge_loop;
addi $11, $0, 0   //  $11 = 0;
beq $0, $0, -23   //  goto edge_loop;
addi $10, $10, 1  //edge_loop_post: $10++;
sub $4, $12, $10  //  $4 = ($12 - $10);
slt $4, $0, $4    //  $4 = 0 < $4;
nor $4, $4, $11   //  $4 = ~$4 & ~$11;
andi $4, $4, 1    //  $4 = $ & 1;
bne $4, $0, -41   //  if ($4 != 0) goto first; // Search from the first again...
beq $11, $0, -37  //  if ($11 == 0) goto node_try_loop;
beq $0, $0, -41   //  goto node_loop;
sw $2, $0, 32767  // node_loop_post: ダミーの書き込み(これでシミュレーターが止まる)
beq $0, $0, -1    // 実機用のループ

