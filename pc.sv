`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2025 11:01:24 PM
// Design Name: 
// Module Name: pc
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


module pc#(
    parameter int pc_len = 32
)(
    input  logic [pc_len-1:0] pc_in,
    output logic [pc_len-1:0] pc_out
);

    assign pc_out = pc_in + 4;

endmodule



































