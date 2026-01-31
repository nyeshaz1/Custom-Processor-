`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2025 11:07:00 PM
// Design Name: 
// Module Name: pc_tb
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


module pc_tb();
    parameter pc_len = 32;

    logic [pc_len-1:0] pc_in;
    logic [pc_len-1:0] pc_out;

    // Instantiate DUT (Device Under Test)
    pc #(pc_len) uut (
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    initial begin
        // Test 1: start at 0
        pc_in = 32'd0;
        #5;

        // Test 2: some random value
        pc_in = 32'd20;
        #5;

        // Test 3: large number
        pc_in = 32'h0000_00FC;
        #5;

        $finish;
    end

endmodule
