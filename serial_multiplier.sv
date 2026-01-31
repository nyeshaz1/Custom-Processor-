`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/02/2026 04:42:33 PM
// Design Name: 
// Module Name: serial_multiplier
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


`timescale 1ns / 1ps

module serial_multiplier (
    input  logic        clk,
    input  logic        rst,
    input  logic        start,
    input  logic [2:0]  funct3,        // 000=MUL, 001=MULH, 010=MULHSU, 011=MULHU
    input  logic [31:0] A,
    input  logic [31:0] B,

    output logic [63:0] result_64,     // full 64-bit result
    output logic [31:0] result,        // 32-bit sliced result per funct3
    output logic        ready,
    output logic        stall,

    // debug signals
    output logic [31:0] count_out,
    output logic [63:0] product_out,
    output logic [31:0] multiplier_out,
    output logic [31:0] multiplicand_out
);

    // Internal state
    logic [63:0] product;
    logic [31:0] multiplier;
    logic [63:0] multiplicand;         // 64-bit to handle shifts
    logic [5:0]  count;
    logic        busy;
    logic        sign;
    logic [2:0]  funct3_reg;

    assign stall = busy;

    // expose internal signals for debug
    assign count_out        = {26'b0, count};
    assign product_out      = product;
    assign multiplier_out   = multiplier;
    assign multiplicand_out = multiplicand[31:0];

    
    // Result slicing

   always_comb begin
        case (funct3_reg)
            3'b000: result = result_64[31:0];     // MUL
            3'b001: result = result_64[63:32];    // MULH
            3'b010: result = result_64[63:32];    // MULHSU
            3'b011: result = result_64[63:32];    // MULHU
            default: result = result_64[31:0];
        endcase
    end

    // Multiplication FSM
   
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            product      <= 64'b0;
            multiplicand <= 64'b0;
            multiplier   <= 32'b0;
            count        <= 6'b0;
            busy         <= 1'b0;
            ready        <= 1'b0;
            sign         <= 1'b0;
            funct3_reg   <= 3'b0;
            result_64    <= 64'b0;
        end else begin
            ready <= 1'b0; // default, cleared each cycle

            // Start new multiplication
            if (start && !busy) begin
                funct3_reg <= funct3;
                busy <= 1'b1;
                count <= 6'b0;
              // result_64 <= 64'b0;

                case (funct3)
                    3'b000, 3'b001: begin // MUL, MULH (signed × signed)
                        sign <= A[31] ^ B[31];
                        multiplicand <= (A[31]) ? {32'b0, -A} : {32'b0, A};
                        multiplier   <= (B[31]) ? -B : B;
                    end
                    3'b010: begin // MULHSU (signed × unsigned)
                        sign <= A[31];
                        multiplicand <= (A[31]) ? {32'b0, -A} : {32'b0, A};
                        multiplier   <= B;
                    end
                    3'b011: begin // MULHU (unsigned × unsigned)
                        sign <= 1'b0;
                        multiplicand <= {32'b0, A};
                        multiplier   <= B;
                    end
                    default: begin // default to MUL
                        sign <= A[31] ^ B[31];
                        multiplicand <= (A[31]) ? {32'b0, -A} : {32'b0, A};
                        multiplier   <= (B[31]) ? -B : B;
                    end
                endcase

                product <= 64'b0;
            end

            // Serial multiplication logic
            else if (busy) begin
                if (multiplier[0]) begin
                    product <= product + multiplicand;
                end

                multiplier   <= {1'b0, multiplier[31:1]};  // logical right shift
                multiplicand <= {multiplicand[62:0], 1'b0}; // left shift
                count <= count + 1;

                // Finish multiplication after 32 cycles
                if (count == 6'd31) begin
                    busy <= 1'b0;
                    ready <= 1'b1;

                    // Apply sign if needed
                    if (sign) begin
                        result_64 <= ~product + 1'b1;
                    end else begin
                        result_64 <= product;
                    end
                end
            end
        end
    end
 
endmodule
