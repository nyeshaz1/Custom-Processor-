`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2025 03:20:45 PM
// Design Name: 
// Module Name: cu_tb
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


module cu_tb(

    );
 parameter oplen=7;
logic [oplen-1:0]op;
logic memtoreg;
logic [1:0]ALUOp;
logic ALUSrc;
logic RegWrite;
logic MemRead;
logic MemWrite;
logic branch;
logic pc_signal;

cu uut(
.op(op),
.memtoreg(memtoreg),
.ALUOp(ALUOp),
.ALUSrc(ALUSrc),
.RegWrite(RegWrite),
.MemRead(MemRead),
.MemWrite(MemWrite),
.branch(branch),
.pc_signal(pc_signal)
);
initial begin
op=7'b0010011;//i type 
#10
op=7'b0110011;// r type 
#10
op=7'b0000011;//lw 
#10
op=7'b0100011;//sw
#10
op=7'b1100011;// branch 

#10 $finish;
end 

endmodule

