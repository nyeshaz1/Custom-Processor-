`timescale 1ns / 1ps
module Custom_processor_tb;

    parameter width = 32;
    parameter int total_reg = 20;
    parameter int address_reg = $clog2(total_reg);
    parameter int w = 32;
    parameter int d = 128;
    parameter int pc_len = 32;
    parameter int oplen = 7;
    parameter int addr_len = 5;
    parameter int inst_width = 32;
    parameter int immgen_out = 32;
    parameter int len = 100;

    // Signals
    logic clk, reset;
    logic [pc_len-1:0] pc_out;
    logic [width-1:0] resultout;
    logic [width-1:0] alu_in1;
    logic [width-1:0] alu_rs2;
    logic [width-1:0] alu_result;
    logic [immgen_out-1:0] imm_out;           // immediate from ImmGen
    logic [width-1:0] reading;
    logic[width-1:0]writing;

    // Instantiate Processor
    Custom_Processor #(
        .width(width),
        .total_reg(total_reg),
        .w(w),
        .d(d),
        .pc_len(pc_len),
        .oplen(oplen),
        .addr_len(addr_len),
        .inst_width(inst_width),
        .immgen_out(immgen_out),
        .len(len)
    ) uut (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out),
        .resultout(resultout),
        .alu_in1(alu_in1),
        .alu_rs2(alu_rs2),
        .alu_result(alu_result),
        .imm_out(imm_out),
        .reading(reading),
        .writing(writing)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Reset
    initial begin
        reset = 1;
        #10 reset = 0;
    end

    

    // Finish simulation
    initial #200 $finish;

endmodule
