`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2025 03:27:54 PM
// Design Name: 
// Module Name: ALU_TB
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


module ALU_TB;
  parameter width=32;
  logic signed [width-1:0] in1 ;
  logic signed [width-1:0] rs2_out;
  logic signed [width-1:0] result;
  logic [3:0] ALUOp_control;
  logic [2:0]funct3;
  logic flag;
  logic [6:0]opcode;
  
  
    ALU uut(
    .in1(in1),
    .rs2_out(rs2_out),
    .ALUOp_control(ALUOp_control),
    .result(result),
    .funct3(funct3),
    .flag(flag),
    .opcode(opcode)
    
    );
    initial 
    begin 
   
   
   // Test ADD
        in1 = 10; rs2_out = 5; ALUOp_control = 4'b0010; #10; // Expected: 15

        // Test SUB
        in1 = 20; rs2_out = 7; ALUOp_control = 4'b0110; #10; // Expected: 13

        // Test SLL (Shift Left Logical)
        in1 = 4; rs2_out = 2; ALUOp_control = 4'b1001; #10;  // Expected: 16

        // Test SLT (Set Less Than, signed)
        in1 = -5; rs2_out = 3; ALUOp_control = 4'b0111; #10; // Expected: 1

        // Test SLTU (Set Less Than, unsigned)
        in1 = 5; rs2_out = -3; ALUOp_control = 4'b1000; #10; // Expected: 0 (since unsigned 5 > unsigned -3)

        // Test XOR
        in1 = 12; rs2_out = 5; ALUOp_control = 4'b0011; #10; // Expected: 9

        // Test SRL (Shift Right Logical)
        in1 = 32; rs2_out = 2; ALUOp_control = 4'b1010; #10; // Expected: 8

        // Test SRA (Shift Right Arithmetic)
        in1 = -16; rs2_out = 2; ALUOp_control = 4'b1011; #10; // Expected: -4

        // Test OR
        in1 = 12; rs2_out = 10; ALUOp_control = 4'b0001; #10; // Expected: 14

        // Test AND
        in1 = 12; rs2_out = 10; ALUOp_control = 4'b0000; #10; // Expected: 8
       opcode = 7'b1100011;  // Branch

        // BEQ
        funct3 = 3'b000;
        in1 = 5; rs2_out = 5; ALUOp_control = 4'b0110; #10;

        // BNE
        funct3 = 3'b001;
        in1 = 5; rs2_out = 8; #10;

        // BLT
        funct3 = 3'b100;
        in1 = 3; rs2_out = 10; #10;

        // BGE
        funct3 = 3'b101;
        in1 = 10; rs2_out = 3; #10;

        // BLTU
        funct3 = 3'b110;
        in1 = 3; rs2_out = -1; #10;

        // BGEU
        funct3 = 3'b111;
        in1 = -1; rs2_out = 3; #10;
   
    
  $finish;
    end 
endmodule
