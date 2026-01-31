`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2025 12:58:18 PM
// Design Name: 
// Module Name: BSel
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

module BSel #(
    parameter w = 32
)(
    input  logic [w-1:0] rs2,
    input  logic [w-1:0] imm_out,
    input  logic         ALUSrc,      // <?? NEW clean control signal
    output logic [w-1:0] rs2_out
);

always_comb begin
    if (ALUSrc)
        rs2_out = imm_out;  // Immediate goes to ALU B-input
    else
        rs2_out = rs2;      // Register rs2 goes to ALU B-input
end

endmodule

