`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2025 02:36:32 PM
// Design Name: 
// Module Name: cu
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


module cu#(
parameter oplen=7)(
input logic [oplen-1:0]op,
output logic memtoreg,
output logic [1:0]ALUOp,
output logic ALUSrc,
output logic RegWrite,
output logic MemRead ,
output logic MemWrite,
output logic branch,
output logic pc_signal

    );
  always_comb begin 
    
       // Default values (avoid latches)
        RegWrite = 1'b0;
        ALUSrc   = 1'b0;
        ALUOp    = 2'b00;
        memtoreg = 1'b0;
        MemWrite = 1'b0;
        MemRead  = 1'b0;
        branch   = 1'b0;
        pc_signal =1'b0;
     case (op)
       7'b0110011: begin //rtype
        
        RegWrite = 1'b1;
        ALUSrc   = 1'b0;
        MemRead  = 1'b0;
        MemWrite = 1'b0;
        memtoreg = 1'b0;
        branch   = 1'b0;
        ALUOp    = 2'b10;
        pc_signal =1'b0;
        
        
        
        
    
        end 
        7'b0010011: begin //itype
         
         
        RegWrite = 1'b1;
        ALUSrc   = 1'b1;
        MemRead  = 1'b0;
        MemWrite = 1'b0;
        memtoreg = 1'b0;
        branch   = 1'b0;
        ALUOp    = 2'b10;
        pc_signal =1'b0;
     
         end
       7'b0000011 : begin //lw
       
       RegWrite = 1'b1;
        ALUSrc   = 1'b1;
        MemRead  = 1'b1;
        MemWrite = 1'b0;
        memtoreg = 1'b1;
        branch   = 1'b0;
        ALUOp    = 2'b00;
        pc_signal =1'b0;
        
       end 
       
       7'b0100011 : begin //sw
       RegWrite = 1'b0;
        ALUSrc   = 1'b1;
        MemRead  = 1'b0;
        MemWrite = 1'b1;
        memtoreg = 1'b0;
        branch   = 1'b0;
        ALUOp    = 2'b00;
        pc_signal =1'b0; 
       end 
       7'b1100011 : begin //branch
       RegWrite = 1'b0;
        ALUSrc   = 1'b0;
        MemRead  = 1'b0;
        MemWrite = 1'b0;
        memtoreg = 1'b0;
        branch   = 1'b1;
        ALUOp    = 2'b01;
        pc_signal =1'b1;
       end 
       
         
         default: begin
                // default control signals stay at 0
            end
            endcase 
    
    
    end 
    
endmodule
