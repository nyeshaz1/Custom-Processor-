`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2025 04:12:52 PM
// Design Name: 
// Module Name: pc_reg
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


module pc_reg#(
parameter int w=32)(
input logic [w-1:0] pc_mux,
input logic clk,
input logic reset,
output logic [w-1:0] pc_out

    );
    always_ff @(posedge clk or posedge reset )
    begin
    if(reset)
    pc_out<=0;
    else
    pc_out<=pc_mux;
    end 
endmodule
