`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2025 11:40:32 PM
// Design Name: 
// Module Name: ImmGen
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


module ImmGen #(
parameter int inst_width=32
)(
input  logic [inst_width-1:0] instr,
output logic [inst_width -1:0] imm_out
);
logic [6:0] opcode;
assign opcode = instr[6:0];
always_comb begin 
case(opcode)
             7'b0000011, // Load (LW)
            7'b0010011, // Immediate ALU ops
            7'b1100111: // JALR
                imm_out = {{20{instr[31]}}, instr[31:20]};
            // SW, SH, SB
            7'b0100011:
           imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // sign-extend imm[11:0]
               // JAL
             7'b1101111: // JAL
                     imm_out = {{11{instr[31]}}, instr[31], instr[19:12],
                instr[20], instr[30:21], 1'b0}; 
             // Branch (BEQ, BNE, BLT, BGE, BLTU, BGEU)
               7'b1100011:
               imm_out = {{19{instr[31]}}, instr[31], instr[7],
                         instr[30:25], instr[11:8], 1'b0};
              // ADD, SUB, AND, OR, etc. ? No immediate
            default: imm_out = 32'b0;
endcase
end 
endmodule
