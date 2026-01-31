`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2025 01:33:25 PM
// Design Name: 
// Module Name: BSel_tb
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


module BSel_tb();
parameter w=32;
 parameter oplen=7;
logic [w-1:0] rs2;
logic [oplen-1:0] op;
logic [w-1:0] imm_out;
logic [w-1:0] rs2_out;

BSel uut(
.rs2(rs2),
.op(op),
.imm_out(imm_out),
.rs2_out(rs2_out)
);
initial begin
rs2 = 32'h0000000A;     //decimal 10
imm_out = 32'h00000014; //decimal 20
//r type 
op=7'b0110011;
#10
// i type 
op=7'b0010011 ;
#10
op=7'b1111111;
#10 $finish;
end 
endmodule
