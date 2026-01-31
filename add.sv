`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2025 03:33:58 PM
// Design Name: 
// Module Name: add
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


module add(
input logic flag,
input logic branch,
output logic add_out

    );
    always_comb begin
    if(flag==1'b1 && branch==1'b1)begin
    add_out=1'b1;
    end
    else 
    add_out=1'b0;
    end 
endmodule
