`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2025 04:33:45 PM
// Design Name: 
// Module Name: C_TOP
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


module C_TOP#(parameter oplen=7)(
input logic [oplen-1:0]op,
input logic [2:0]funct3,
input logic [6:0]funct7,

output logic memtoreg,
output logic [1:0]ALUOp,
output logic ALUSrc,
output logic RegWrite,
output logic MemRead,
output logic MemWrite,
output logic branch,
output logic pc_signal,
output logic [3:0]ALUOp_control

    );
    logic [1:0]ALUOp_connect;
    
    cu#(
    .oplen(oplen))
    cu_uut(
    .op(op),
    .memtoreg(memtoreg),
    .ALUOp(ALUOp_connect),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .pc_signal(pc_signal),
    .branch(branch)
    );
    
    ALU_CU alu_cu_uut (
    .ALUOp(ALUOp_connect),
    .funct3(funct3),
    .funct7(funct7),
    .ALUOp_control(ALUOp_control));
     assign ALUOp=ALUOp_connect;
endmodule
