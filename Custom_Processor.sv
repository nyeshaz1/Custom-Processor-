`timescale 1ns / 1ps
module Custom_Processor #(
    parameter width = 32,
    parameter int total_reg = 20,
    parameter int w = 32,
    parameter int d = 128,
    parameter int pc_len = 32,
    parameter int oplen = 7,
    parameter int addr_len = 5,
    parameter int inst_width = 32,
    parameter int immgen_out = 32,
    parameter int len = 100
)(
    input  logic clk,
    input  logic reset,

    // outputs required by you
    output logic [pc_len-1:0] pc_out,               // current PC (from pc_reg)
    output logic [width-1:0] resultout,             // final write-back value
    output logic [width-1:0] alu_in1,               // ALU input1
    output logic [width-1:0] alu_rs2,               // ALU input2
    output logic [width-1:0] alu_result,            // ALU result
    output logic [immgen_out-1:0] imm_out  ,         // immediate from ImmGen
    output logic [width-1:0] reading,       // memory read value
    output logic [width-1:0] writing        // memory write value
);

    logic [31:0] instruction;
    logic [pc_len-1:0] pc_plus4;                     // pc + 4
    logic [pc_len-1:0] pc_branch_target;             // pc + imm (branch target)
    logic [pc_len-1:0] pc_mux_out;                   // input to pc_reg
    logic add_out;                                   // branch & zero flag
     
     
     
     //INSTRUCTION DECODER
      logic [addr_len-1:0] rs1, rs2, rd;
    logic [oplen-1:0] op;
    logic [2:0] funct3;
    logic [6:0] funct7;
    assign op     = instruction[6:0];
    assign rd     = instruction[11:7];
    assign funct3 = instruction[14:12];
    assign rs1    = instruction[19:15];
    assign rs2    = instruction[24:20];
    assign funct7 = instruction[31:25];
 //INSTRUCTION MEMORY
     ins_mem #(
        .w(w),
        .d(d),
        .pc_len(pc_len),
        .oplen(oplen),
        .addr_len(addr_len)
    ) ins_mem_uut(
        .pcaddress(pc_out),     // current PC is address
        .instruction(instruction)  
   );
    
   

    // Register file signals
    logic [width-1:0] rd_in;
    logic [width-1:0] reg_out1, reg_out2;

    // Control + ALU
    logic memtoreg;
    logic [1:0] ALUOp;
    logic ALUSrc;
    logic RegWrite;
    logic MemRead, MemWrite, branch, pc_signal;
    logic [3:0] ALUOp_control;
    logic flag;

    // BSel and ALU inputs
    logic [width-1:0] rs2_out_internal;

    // Data memory readback
    logic [width-1:0] mem_rd;

    // sign-extended immediate (pc_len wide) to add with PC
    logic [pc_len-1:0] imm_sext;


    // pc_reg holds the current PC and is driven by pc_mux_out
    pc_reg #(.w(pc_len)) pc_reg_uut(
        .clk(clk),
        .reset(reset),
        .pc_mux(pc_mux_out),
        .pc_out(pc_out)
    );

    // pc + 4 (combinational)
    pc #(.pc_len(pc_len)) pc_increment (
        .pc_in(pc_out),
        .pc_out(pc_plus4)
    );

    // ImmGen -> imm_out (immgen_out wide)
    ImmGen #(.inst_width(inst_width)) ImmGen_uut (
        .instr(instruction),
        .imm_out(imm_out)
    );

    // Sign-extend imm_out to pc_len (handles immgen_out != pc_len)
    // If immgen_out == pc_len this is a no-op.
    assign imm_sext = {{(pc_len-immgen_out){imm_out[immgen_out-1]}}, imm_out};

    // PC + imm (branch target)
    add_sum #(.w(pc_len)) add_pc_imm(
        .pcoutput(pc_out),
        .imm_out(imm_sext),
        .sum(pc_branch_target)
    );

    // Branch AND zero -> add_out
    add add_uut(
        .flag(flag),
        .branch(branch),
        .add_out(add_out)
    );

    // Branch mux: when add_out==1 -> choose branch target; else choose pc_plus4
    branch_mux #(.w(pc_len)) branch_mux_uut(
        .pcoutput(pc_plus4),
        .sum(pc_branch_target),
        .add_out(add_out),
        .pc_mux_out(pc_mux_out)
    );

    
    //  CONTROL UNIT
    C_TOP #(.oplen(oplen)) control_top_uut(
        .op(op),
        .funct3(funct3),
        .funct7(funct7),
        .memtoreg(memtoreg),
        .ALUOp(ALUOp),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ALUOp_control(ALUOp_control),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .branch(branch),
        .pc_signal(pc_signal)
    );

    //  REGISTER FILE 
    reg_file #(.width(width), .total_reg(total_reg)) reg_file_uut (
        .clk(clk),
        .wenable(RegWrite),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .rd_in(rd_in),
        .out1(reg_out1),
        .out2(reg_out2)
    );

    // ALU inputs
    assign alu_in1 = reg_out1;

    // -BSel (choose between rs2 or imm) 
    BSel #(.w(w), .oplen(oplen)) BSel_uut(
        .rs2(reg_out2),
        .ALUSrc(ALUSrc),
        .imm_out(imm_out),
        .rs2_out(rs2_out_internal)
    );
    assign alu_rs2 = rs2_out_internal;

    //  ALU 
    ALU #(.width(width)) ALU_uut(
        .in1(alu_in1),
        .rs2_out(alu_rs2),
        .result(alu_result),
        .ALUOp_control(ALUOp_control),
        .funct3(funct3),
        .opcode(op),
        .flag(flag)
    );

    //  DATA MEMORY 
    DMem #(.f3(3), .addlen(width), .vlen(width), .len(len)) DMem_uut(
        .clk(clk),
        .address(alu_result),
        .funct3(funct3),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .rs(reg_out2),
        .rd(mem_rd)
    );

    //  WRITEBACK MUX 
    mux #(.w(width)) Mux_uut(
        .rd(mem_rd),
        .result(alu_result),
        .memtoreg(memtoreg),
        .data_write(rd_in)
    );

    // Outputs you wanted
    assign resultout = rd_in;          // value written back to regfile
    // alu_in1, alu_rs2 and alu_result are already assigned/connected above
    // imm_out is output from ImmGen (already an output port)
    assign reading = mem_rd;       // memory read value
    assign writing = reg_out2;     // memory write value

endmodule
