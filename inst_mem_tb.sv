`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2025 10:38:11 PM
// Design Name: 
// Module Name: inst_mem_tb
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


module inst_mem_tb;
parameter w=32;
parameter d=128;
parameter pc_len=32;
parameter addr_len=5;
parameter oplen=7;
parameter addr_len2=5;

//signalss
logic [pc_len-1:0] pcaddress;
logic [addr_len-1:0] rs1,rs2,rd;
logic [oplen-1:0] op;
logic [2:0]funct3;
logic [6:0]funct7;
logic [11:0]imm;
logic [w-1:0] instruction;// why we are not doing this , because its not output
ins_mem uut (
.pcaddress(pcaddress),
.op(op),
.rs1(rs1),
.rs2(rs2),
.rd(rd),
.funct3(funct3),
.funct7(funct7),
.instruction(instruction),
.imm(imm)

);

// stimulus and initialization 

initial 
begin
for(pcaddress=0;pcaddress<64;pcaddress=pcaddress+4)begin
#10;

end 

#10 $finish;
end
endmodule
