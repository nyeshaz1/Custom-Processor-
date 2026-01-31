`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2025 06:57:36 PM
// Design Name: 
// Module Name: mux_tb
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


module mux_tb();
parameter w=32;
logic [w-1:0] rd;//from memory 
logic [w-1:0] result; // from alu
logic memtoreg;//control signal
logic [w-1:0] data_write;//output

mux uut(
.rd(rd),
.result(result),
.data_write(data_write),
.memtoreg(memtoreg)
);

initial begin

 rd = 32'hAAAA_BBBB;
 //output should be result 
        result = 32'h1111_2222;
        memtoreg = 1'b0;
        #10;
        //output should be rd
         memtoreg = 1'b1;
        #10;
        //
         rd = 32'h0000_0000;
        result = 32'hFFFF_FFFF;
        memtoreg = 1'b0;
        #10;
        $finish;
end 
endmodule
