`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2025 08:58:39 PM
// Design Name: 
// Module Name: reg_file_tb
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


module reg_file_tb();
parameter int width=32;
parameter int total_reg=32;
parameter int address_reg =$clog2(total_reg);

logic clk;
logic wenable;
logic [address_reg-1:0]rs1;
logic [address_reg-1:0]rs2;
logic [address_reg-1:0]rd;
logic [width-1:0]rd_in;
logic [width-1:0]out1;
logic [width-1:0] out2;

//instantiate calling 
reg_file uut(
   .clk(clk),
   .wenable(wenable),
   .rs1(rs1),
   .rs2(rs2),
   .rd(rd),
   .rd_in(rd_in),
   .out1(out1),
   .out2(out2)
);
 
initial clk = 0;
    always #5 clk = ~clk; 

// stimulus and initialization 
initial 
begin
// setting everyhting to zeo so i can get a 
//clean start not a garbage value 
wenable=0;
rs1=0;
rs2=0;
rd=0;
rd_in=0;

    #10
    rs1 = 1; rs2 = 2; wenable = 0; //read regs 1 andd 2
    #10
    rd = 3; rd_in = 100; wenable = 1; //write 100 to x3
    #10
    rs1 = 3; rs2 = 0; wenable = 0; //read x3 and x0
    #10
    rd = 0; rd_in = 200; wenable = 1; //attempt write to x0 (ignored)
    #10
    rs1 = 0; rs2 = 3; wenable = 0; //read x0 and x3
    #10



#10
$finish;

end 

endmodule