`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2025 10:29:34 PM
// Design Name: 
// Module Name: ins_mem
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


module ins_mem #(
parameter int w = 32,
parameter int d=128,
parameter int pc_len=32,
parameter int oplen=7,//new 2 to 7
parameter int addr_len=5//new 2 to 5

)(
input logic [pc_len-1:0] pcaddress,
output logic [w-1:0]instruction
);
//logic [w-1:0] instruction;
logic [7:0]memory [0:d-1];
initial 
begin 
 $readmemh("ins_mem.mem", memory); 
end 
always_comb begin
instruction={memory[pcaddress+3],memory[pcaddress+2],memory[pcaddress+1],memory[pcaddress]};
end
endmodule
