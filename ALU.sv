`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2025 02:56:10 PM
// Design Name: 
// Module Name: ALU
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


module ALU #(
  parameter width = 32 )
  (
 input  logic signed  [width -1:0] in1 ,
 input logic signed [width -1:0] rs2_out,
 input logic [3:0] ALUOp_control,
 input logic   [2:0] funct3,
 input logic [6:0] opcode,
 output logic signed [width -1:0]  result ,
 output logic flag);
 


always_comb
begin
    result=0;
    flag   = 1'b0;
    //case (op)
    //7'b0110011: begin
    case (ALUOp_control)
                4'b0010: result = in1 + rs2_out;               // ADD ADDDI
                4'b0110:
                case(opcode)
                7'b0110011 ,
                7'b0010011:result = in1 - rs2_out;// SUB   
                7'b1100011:    
                case(funct3)
               3'b000: flag = (in1 == rs2_out);  // BEQ
               3'b001: flag = (in1 != rs2_out); // BNE
               3'b100: flag = (in1 < rs2_out); // BLT
               3'b101: flag = (in1 >= rs2_out); // BGE
               3'b110: flag = ($unsigned(in1) < $unsigned(rs2_out));// BLTU
               3'b111: flag = ($unsigned(in1) >= $unsigned(rs2_out));// BGEU
               default: flag = 0;
                endcase          
                endcase
                4'b1001: result = in1 << rs2_out[4:0];         // SLL SLLI 
                4'b0111: result = (in1 < rs2_out) ? 1 : 0;    // SLT SLTI
                4'b1000: result = ($unsigned(in1) < $unsigned(rs2_out)) ? 1 : 0; // SLTU SLTIU
                4'b0011: result = in1 ^ rs2_out;               // XOR XORI 
                4'b1010: result = in1 >> rs2_out[4:0];         // SRL SRLI
                4'b1011: result = $signed(in1) >>> rs2_out[4:0]; // SRA SRAI
                4'b0001: result = in1 | rs2_out;               // OR ORI
                4'b0000: result = in1 & rs2_out;               // AND ANDI
                default: result = 0;
    
    
    endcase 
    
    end// r type  
    //7'b0010011:begin
    
   

    

endmodule






