`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2025 04:45:06 PM
// Design Name: 
// Module Name: C_TOP_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module C_TOP_TB;
    parameter oplen=7;
logic [oplen-1:0] op;
logic [2:0] funct3;
logic [6:0] funct7;
logic memtoreg;
logic [1:0] ALUOp;
logic ALUSrc;
logic MemRead;
logic MemWrite;
logic branch;
logic RegWrite;
logic [3:0] ALUOp_control;

C_TOP #(.oplen(oplen)) uut(
        .op(op),
        .funct3(funct3),
        .funct7(funct7),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .branch(branch),  
        .memtoreg(memtoreg),
        .ALUOp_control(ALUOp_control)
);
initial begin
 op = 7'b0110011; funct3 = 3'b000; funct7 = 7'b0000000; #10;//add
  op = 7'b0110011; funct3 = 3'b000; funct7 = 7'b0100000; #10;//sub
  op = 7'b0110011; funct3 = 3'b001; funct7 = 7'b0000000; #10;//sll
  op = 7'b0110011; funct3 = 3'b111; funct7 = 7'b0000000; #10;//and
  op=7'b0000011; #10//lw
  op=7'b0100011; #10 //sw
  op=7'b1100011;#10 // branch 
  $finish;

end 

endmodule
