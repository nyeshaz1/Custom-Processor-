`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2025 03:44:19 PM
// Design Name: 
// Module Name: add_sum
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


module add_sum#(
parameter int w=32)(
input logic[w-1:0]pcoutput,
input logic [w-1:0]imm_out,
output logic[w-1:0] sum 

    );
    assign sum=pcoutput+imm_out;
endmodule
