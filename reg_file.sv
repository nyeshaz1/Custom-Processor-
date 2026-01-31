`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2025 12:25:57 AM
// Design Name: 
// Module Name: reg_file
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


module reg_file #(
parameter int width=32,
parameter int total_reg=20,
//if i dont initialize like -> $clog
//then every time i change total register of numbers 
//i manually have to update address for reg 
// but parametrizing it help to just change total reg num 
//rest automatically be done by 
//$clog2(x) = "ceiling of log2(x)"

parameter int address_reg =$clog2(total_reg)//bits needed for address 
)(

input logic wenable,
input logic clk,
input logic [address_reg-1:0]rs1,
input logic [address_reg-1:0]rs2,
input logic [address_reg-1:0]rd,
input logic [width-1:0]rd_in, // alu result 
output logic [width-1:0]out1,
output logic [width-1:0] out2


    );
    //4 registers eaxh of 16 bits , storage is 
    logic [width-1:0] regs [0:total_reg-1];
    //a loop can be added here to incase if
    // mem is missing regs will have a value 
    //we declared in loop
    //if we dont use loop so if mem is not there
    // the values will be garbage aka x
    initial begin 
    $readmemh("reg_file.mem",regs); // this is done to connect to .mem file 
    end 
    
    
    
    
   
 always_comb begin
    
    out1=regs[rs1];
    out2=regs[rs2];
    end
always_ff @(posedge clk) begin
        if (wenable) begin
        if (rd != {address_reg{1'b0}})//x0 cannot be written 
            regs[rd] <= rd_in;
        end
    end
    
    
    
endmodule
