`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2025 03:38:54 PM
// Design Name: 
// Module Name: add_tb
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


module add_tb(

    );
    

    logic flag;
    logic branch;
    logic add_out;

    // DUT
    add uut (
        .flag(flag),
        .branch(branch),
        .add_out(add_out)
    );

    initial begin
        // Test case 1: flag=0, branch=0
        flag = 0; branch = 0; #10;

        // Test case 2: flag=0, branch=1
        flag = 0; branch = 1; #10;

        // Test case 3: flag=1, branch=0
        flag = 1; branch = 0; #10;

        // Test case 4: flag=1, branch=1
        flag = 1; branch = 1; #10;

        #10;
        $finish;
    end

endmodule
