`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2025 03:48:08 PM
// Design Name: 
// Module Name: branch_mux
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


module branch_mux#(
parameter int w=32 )(
input logic [w-1:0] pcoutput,
input logic [w-1:0] sum,
input logic add_out,
output logic [w-1:0] pc_mux_out

    );
    always_comb begin
    if(add_out)begin
    pc_mux_out=sum;
    
    end
    else begin
    pc_mux_out=pcoutput;
    end 
    end 
endmodule
