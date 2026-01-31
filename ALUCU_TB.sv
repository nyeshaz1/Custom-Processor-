`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2025 04:23:35 PM
// Design Name: 
// Module Name: ALUCU_TB
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


module ALUCU_TB(

    );
logic [1:0] ALUOp;
logic [2:0]funct3;
logic [6:0]funct7;
logic [3:0]ALUOp_control;

ALU_CU uut(
.ALUOp(ALUOp),
.funct3(funct3),
.funct7(funct7),
.ALUOp_control(ALUOp_control)
);

initial begin 
 ALUOp=2'b10;
        
        
        
       ///
        // ADD
    funct3 = 3'b000; funct7 = 7'b0000000; #10;
    // SUB
    funct3 = 3'b000; funct7 = 7'b0100000; #10;
    // SLL
    funct3 = 3'b001; funct7 = 7'b0000000; #10;
    // SLT
    funct3 = 3'b010; funct7 = 7'b0000000; #10;
    // SLTU
    funct3 = 3'b011; funct7 = 7'b0000000; #10;
    // XOR
    funct3 = 3'b100; funct7 = 7'b0000000; #10;
    // OR
    funct3 = 3'b110; funct7 = 7'b0000000; #10;
    // AND
    funct3 = 3'b111; funct7 = 7'b0000000; #10;
    // SRL
     funct3 = 3'b101; funct7 = 7'b0000000; #10;
    // SRA
     funct3 = 3'b101; funct7 = 7'b0100000; #10;
    // LW SW
    ALUOp=2'b00;
    #10
    ALUOp=2'b01;
    #10
    
        
         
        $finish;
end 
endmodule
