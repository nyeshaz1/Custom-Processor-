`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2025 03:20:20 PM
// Design Name: 
// Module Name: DMem_tb
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


module DMem_tb();
parameter f3=3;
parameter addlen = 32;
parameter vlen=32;
parameter width=8;
parameter len=100;

logic clk;
logic [f3-1:0] funct3;
logic[addlen-1:0] address;
logic MemWrite ;
logic MemRead ;
logic [vlen-1: 0] rs,rd;

DMem uut (
.clk(clk),
.funct3(funct3),
.address(address),
.MemRead(MemRead),
.MemWrite(MemWrite),
.rs(rs),
.rd(rd)
);
always #5 clk = ~clk;

   initial begin
   // store word
    clk = 0; MemWrite = 0; MemRead = 0;
    funct3 = 3'b010; 
    address = 0; rs = 32'hAABBCCDD;

    #10 MemWrite = 1;  
    #10 MemWrite = 0; 
    
    //load word
    #10 MemRead = 1; 
    funct3 = 3'b010;
    #10
    //load byte signed
    funct3 = 3'b000;
    #10
    //load byte unsigned
    funct3 = 3'b100;
    #10
    
    //load halfsigned 
    funct3 = 3'b001;
    #10
    //load half unsigned
     funct3 = 3'b101; 
    
    
    
     
    #10 $finish;      
end
endmodule











