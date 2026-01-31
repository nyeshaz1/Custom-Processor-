`timescale 1ns / 1ps
module ImmGen_tb;
parameter int inst_width = 32;

logic [inst_width-1:0] instr;
logic [inst_width-1:0] imm_out;

ImmGen uut(
    .instr(instr),
    .imm_out(imm_out)
);

initial begin

    // I-type: JALR (imm = 7)
    instr = 32'h00708067; #10;

    // I-type: LW (imm = -4)
    instr = 32'hffc08003; #10;

    // S-type: SW (imm = 12)
    // imm[11:5]=0, imm[4:0]=12, rs1=x1, rs2=x3, funct3=010
    instr = {7'b0000000, 5'b00011, 5'b00001, 3'b010, 5'b01100, 7'b0100011}; #10;

    // S-type: SW (imm = -4)
    // imm[11:5]=1111111, imm[4:0]=11100, rs1=x1, rs2=x1, funct3=010
    instr = {7'b1111111, 5'b00001, 5'b00001, 3'b010, 5'b11100, 7'b0100011}; #10;

    // S-type: SW (imm = 16)
    // imm[11:5]=0, imm[4:0]=16, rs1=x1, rs2=x2, funct3=010
    instr = {7'b0000000, 5'b00010, 5'b00001, 3'b010, 5'b10000, 7'b0100011}; #10;

    // J-type: JAL (imm = 40)
    // imm[20]=0, imm[10:1]=0000010100, imm[11]=0, imm[19:12]=00000000, rd=x2, opcode=1101111
    instr = {1'b0, 10'b0000010100, 1'b0, 8'b00000000, 5'b00010, 7'b1101111}; #10;

    // J-type: JAL (imm = 64)
    // imm[20]=1, imm[10:1]=1111111000, imm[11]=1, imm[19:12]=11111111, rd=x3, opcode=1101111
    instr = {1'b1, 10'b1111111000, 1'b1, 8'b11111111, 5'b00011, 7'b1101111}; #10;

    // J-type: JAL (imm = 64)
    // imm[20]=0, imm[10:1]=0000100000, imm[11]=0, imm[19:12]=00000000, rd=x1, opcode=1101111
    instr = {1'b0, 10'b0000100000, 1'b0, 8'b00000000, 5'b00001, 7'b1101111}; #10;
  // brcnh beq
   // BEQ x1, x2, imm = 8
    // offset = 8 ? imm[12:1] = 000000001000
    instr = { 
        1'b0,          // imm[12]
        6'b000000,     // imm[10:5]
        5'b00010,      // rs2 = x2
        5'b00001,      // rs1 = x1
        3'b000,        // funct3 = BEQ
        4'b1000,       // imm[4:1]
        1'b0,          // imm[11]
        7'b1100011     // opcode
    };
    #10;
    // BNE x3, x4, imm = -4
    // offset = -4 ? imm[12:1] = 111111111100
    instr = { 
        1'b1,          // imm[12]
        6'b111111,     // imm[10:5]
        5'b00100,      // rs2 = x4
        5'b00011,      // rs1 = x3
        3'b001,        // funct3 = BNE
        4'b1100,       // imm[4:1]
        1'b1,          // imm[11]
        7'b1100011
    };
    #10;
    // BLT x5, x6, imm = 16
    // offset = 16 ? imm[12:1] = 000000010000
    instr = { 
        1'b0,          // imm[12]
        6'b000001,     // imm[10:5]
        5'b00110,      // rs2 = x6
        5'b00101,      // rs1 = x5
        3'b100,        // funct3 = BLT
        4'b0000,       // imm[4:1]
        1'b0,          // imm[11]
        7'b1100011
    };
    #10;
    // BGE x7, x8, imm = 32
    // offset = 32 ? imm[12:1] = 000000100000
    instr = {
        1'b0,          // imm[12]
        6'b000010,     // imm[10:5]
        5'b01000,      // rs2 = x8
        5'b00111,      // rs1 = x7
        3'b101,        // funct3 = BGE
        4'b0000,       // imm[4:1]
        1'b0,          // imm[11]
        7'b1100011
    };
    #10;
    // BLTU x9, x10, imm = 6
    // offset = 6 ? imm[12:1] = 000000000110
    instr = {
        1'b0,          // imm[12]
        6'b000000,     // imm[10:5]
        5'b01010,      // rs2 = x10
        5'b01001,      // rs1 = x9
        3'b110,        // funct3 = BLTU
        4'b0110,       // imm[4:1]
        1'b0,          // imm[11]
        7'b1100011
    };
    #10;
    // BGEU x11, x12, imm = -8
    // offset = -8 ? imm[12:1] = 111111111000
    instr = {
        1'b1,          // imm[12]
        6'b111111,     // imm[10:5]
        5'b01100,      // rs2 = x12
        5'b01011,      // rs1 = x11
        3'b111,        // funct3 = BGEU
        4'b1000,       // imm[4:1]
        1'b1,          // imm[11]
        7'b1100011
    };
    #10;
    $finish;
end
endmodule
