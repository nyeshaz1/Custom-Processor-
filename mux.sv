`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2025 04:16:57 PM
// Design Name: 
// Module Name: mux
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


module mux#(
parameter w=32)(
input logic [w-1:0] rd,//from memory 
input logic [w-1:0] result, // from alu
input logic memtoreg,//control signal
output logic [w-1:0] data_write//output 

);
 always_comb begin
        case (memtoreg)
            1'b0: data_write = result;      // select rd=ALU result
            1'b1: data_write = rd;   // select data memory and write to register file 
            default: data_write = result;   // default to ALU
        endcase
    end

endmodule
