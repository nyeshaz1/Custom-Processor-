`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2025 03:36:31 PM
// Design Name: 
// Module Name: ALU_CU
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


module ALU_CU(
input logic [1:0] ALUOp,
input logic [2:0]funct3,
input logic [6:0]funct7,
output logic [3:0]ALUOp_control

    );
    always_comb begin
     ALUOp_control = 4'b0000;  
    case(ALUOp)
    2'b10: begin
    if(funct3==3'b000 && funct7==7'b0000000)begin//add
    ALUOp_control=4'b0010;
    end 
    else if (funct3==3'b000 && funct7==7'b0100000)begin//sub
    ALUOp_control=4'b0110;
    end 
    else if (funct3==3'b001)begin//sll
    ALUOp_control=4'b1001;
    end 
    else if (funct3==3'b010)begin//slt
    ALUOp_control=4'b0111;
    
    end 
    else if (funct3==3'b011)begin//sltu
    ALUOp_control=4'b1000;
    end 
    else if (funct3==3'b100)begin//xor
    ALUOp_control=4'b0011;
    end 
    else if (funct3 == 3'b101 && funct7 == 7'b0000000) begin
    ALUOp_control = 4'b1010; // SRL
    end
    else if (funct3 == 3'b101 && funct7 == 7'b0100000) begin
    ALUOp_control = 4'b1011; // SRA
        end
    else if (funct3 == 3'b110) begin
    ALUOp_control = 4'b0001; // OR
    end 
    else if (funct3 == 3'b111) begin
    ALUOp_control = 4'b0000; // AND
    end   
   else 
    ALUOp_control=4'b0000;
    
    end 
    2'b00 : begin// lw and sw 
    ALUOp_control=4'b0010;
    
    end 
    2'b01 : begin //BRANCH
    ALUOp_control=4'b0110;
    end 
  
    endcase 
    end 
endmodule
