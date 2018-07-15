`include "def.h"
module mipse(
input clk, rst_n,
input [`DATA_W-1:0] instr,
input [`DATA_W-1:0] readdata,
output reg [`DATA_W-1:0] pc,
output [`DATA_W-1:0] aluresult,
output [`DATA_W-1:0] writedata,
output memwrite);

wire [`DATA_W-1:0] srca, srcb, rd2, result, rand_result;
wire [`OPCODE_W-1:0] opcode;
wire [`SHAMT_W-1:0] shamt;
wire [`OPCODE_W-1:0] func;
wire [`REG_W-1:0] rs, rd, rt, writereg;
wire [`SEL_W-1:0] com;
wire [`DATA_W-1:0] signimm;
wire [`DATA_W-1:0] pcplus4;
wire regwrite;
wire sw_op, beq_op, bne_op, addi_op, lw_op, j_op, jal_op, jr_op, alu_op;
wire slt_op, ori_op, andi_op, sb_op, lb_op, lui_op, rand_op;

wire zero;
assign zero = 32'b0;

assign {opcode, rs, rt, rd, shamt, func} = instr;
assign signimm = {{16{instr[15]}},instr[15:0]};

// Decorder
assign sw_op = (opcode == `OP_SW);
assign lw_op = (opcode == `OP_LW);
assign sb_op = (opcode == `OP_SB);
assign lb_op = (opcode == `OP_LB);
assign alu_op = (opcode == `OP_REG) & (func[5:3] == 3'b100);
assign addi_op = (opcode == `OP_ADDI);
assign andi_op = (opcode == `OP_ANDI);
assign ori_op = (opcode == `OP_ORI);
assign beq_op = (opcode == `OP_BEQ);
assign bne_op = (opcode == `OP_BNE);
assign lui_op = (opcode == `OP_LUI);
assign j_op = (opcode == `OP_J);
assign jal_op = (opcode == `OP_JAL);
assign jr_op = (opcode == `OP_REG) & (func == `FUNC_JR);
assign slt_op = (opcode == `OP_REG) & (func == `FUNC_SLT);
assign rand_op = (opcode == `OP_RAND);

assign writedata =
        sb_op & !aluresult[1] & !aluresult[0] ? {rd2[7:0], 24'b0} :
        sb_op & !aluresult[1] & aluresult[0] ? {8'b0, rd2[7:0], 16'b0} :
        sb_op & aluresult[1] & !aluresult[0] ? {16'b0, rd2[7:0], 8'b0} :
        sb_op & aluresult[1] & aluresult[0] ? {24'b0, rd2[7:0]} : rd2;

assign memwrite = {(sw_op | !aluresult[1] & !aluresult[0] &sb_op),
                   (sw_op | !aluresult[1] & aluresult[0] &sb_op),
                   (sw_op | aluresult[1] & !aluresult[0] &sb_op),
                   (sw_op | aluresult[1] & aluresult[0] &sb_op)};


assign srcb = (addi_op | lw_op | sw_op | lb_op | sb_op) ? signimm :
              (andi_op | ori_op) ? {16'b0, instr[15:0]} :
              lui_op ? {instr[15:0], 16'b0}:rd2;

assign com = (addi_op|lw_op|sw_op|lb_op|sb_op) ? `ALU_ADD:
             (beq_op | bne_op | slt_op) ? `ALU_SUB:
             (andi_op) ? `ALU_AND: ori_op ? `ALU_OR:
             (lui_op) ? `ALU_THB: func;

assign result =
        slt_op ? {31'b0, aluresult[31]} :
        jal_op ? pcplus4:
        lw_op  ? readdata :
        lb_op & !aluresult[1] & !aluresult[0]? {{24{readdata[31]}}, readdata[31:24]}:
        lb_op & !aluresult[1] & aluresult[0]? {{24{readdata[23]}}, readdata[23:16]}:
        lb_op & aluresult[1] & !aluresult[0]? {{24{readdata[15]}}, readdata[15:8]}:
        lb_op & aluresult[1] & aluresult[0]? {{24{readdata[7]}}, readdata[7:0]}:
        rand_op ? rand_result:
        aluresult;

assign regwrite = lw_op | alu_op | addi_op | jal_op | slt_op | lb_op | lui_op |
                  andi_op | ori_op | rand_op;

assign writereg = jal_op ? 5'b11111: (alu_op | slt_op | rand_op) ? rd : rt;

rand rand_1(.clk(clk), .rst_n(rst_n), .out(rand_result));

alu alu_1(.a(srca), .b(srcb), .s(com), .y(aluresult));

rfile rfile_1(.clk(clk), .rd1(srca), .a1(rs), .rd2(rd2), .a2(rt),
              .wd3(result), .a3(writereg), .we3(regwrite));

assign pcplus4 = pc+4;
always @(posedge clk or negedge rst_n)
begin
    if(!rst_n) pc <= 0;
    else if (j_op | jal_op)
        pc <= {pc[31:28],instr[25:0],2'b0};
    else if (jr_op)
        pc <= srca;
    else if ((beq_op & (aluresult == zero) | (bne_op & (aluresult != zero))))
        pc <= pcplus4 +{signimm[29:0],2'b0} ;
    else
        pc <= pcplus4;
end

endmodule
