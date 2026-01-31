`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2025 02:34:14 PM
// Design Name: 
// Module Name: DMem
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


module DMem #(
parameter f3=3,
parameter addlen = 32,
parameter vlen=32,
parameter width=8,
parameter len=100

    )(
    input logic clk,
    input logic [f3-1:0] funct3,
    input logic[addlen-1:0] address,
    input logic MemWrite ,
    input logic MemRead ,
    input  logic [vlen-1:0]   rs,
    output logic [vlen-1:0]   rd
    );
    logic[7:0] datamem[0:len-1];
    initial begin 
    $readmemh("datamem.mem", datamem);
    end
    logic [7:0] valTemp; 
    logic [15:0] valTemp1;
     logic [31:0] valTemp2; 
     
     
     
     always_comb begin
     rd = 32'b0; //default
     if (MemRead) begin
         case (funct3)
         //lb load byte signed 
               3'b000: begin
               valTemp = datamem[address];
               rd = { {24{valTemp[7]}}, valTemp };  //sign extend
     end

          //lh load half word signed 
               3'b001: begin
                valTemp1 = { datamem[address + 1], datamem[address] };
                rd = { {16{valTemp1[15]}}, valTemp1 };  //sign extend
     end

               //lw load word 
                3'b010: begin
                 valTemp2 = { datamem[address + 3], datamem[address + 2],
               datamem[address + 1], datamem[address] };
                rd = valTemp2;
      end

               //lbu load byte unsigned  
               3'b100: begin
               valTemp = datamem[address];
               rd = { 24'b0, valTemp};
               end

               //lhu load half word unsigned  
              3'b101: begin
              valTemp1 = {datamem[address + 1], datamem[address]};
              rd = {16'b0, valTemp1};
     end

   default: rd = 32'b0;
   endcase
   end
   end
     
    
   always_ff @(posedge clk) begin
        if (MemWrite) begin
            case (funct3)
                //sb store byte
                3'b000: datamem[address] <= rs[7:0];

                //sh store half-word
                3'b001: begin
                    datamem[address]     <= rs[7:0];
                    datamem[address + 1] <= rs[15:8];
                end

                //sw store word
                3'b010: begin
                    datamem[address]     <= rs[7:0];
                    datamem[address + 1] <= rs[15:8];
                    datamem[address + 2] <= rs[23:16];
                    datamem[address + 3] <= rs[31:24];
                end
            endcase
        end
    end  
     
    
   

endmodule
