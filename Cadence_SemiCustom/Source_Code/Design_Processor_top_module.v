`timescale 1ns/1ps
module risc8_pipeline_top(
    input clk,
    input reset_n,
    output [15:0] pc,
    output [7:0] reg_write_data
);
    wire [15:0] pc_next, instr;
    wire stall, flush_ifid, flush_idex, branch_taken;
    
    assign flush_ifid = branch_taken;
    assign flush_idex = branch_taken || stall;

    // Program Counter
    program_counter PC(
        .clk(clk),
        .reset_n(reset_n),
        .pc_in(pc_next),
        .pc_write(~stall),
        .pc_out(pc)
    );

    // Instruction Memory
    instr_mem IMEM(
        .addr(pc),
        .instr(instr)
    );

    // IF/ID Pipeline Register
    wire [15:0] id_pcplus2, id_instr;
    if_id_register IFID(
        .clk(clk),
        .reset_n(reset_n),
        .stall(stall),
        .flush(flush_ifid),
        .instr_in(instr),
        .pcplus2_in(pc + 16'd2),
        .instr_out(id_instr),
        .pcplus2_out(id_pcplus2)
    );

    // Instruction Decode
    wire [3:0] opcode;
    wire [2:0] rd, rs1, rs2;
    assign opcode = id_instr[15:12];
    assign rd     = id_instr[11:9];
    assign rs1    = id_instr[8:6];
    assign rs2    = id_instr[5:3];

    // Control Unit
    wire regwrite_cu, memread, memwrite, memtoreg, alusrc, branch;
    wire [3:0] aluop;
    control_unit CU(
        .opcode(opcode),
        .regwrite(regwrite_cu),
        .memread(memread),
        .memwrite(memwrite),
        .memtoreg(memtoreg),
        .alusrc(alusrc),
        .branch(branch),
        .aluop(aluop)
    );

    // Register File
    wire [7:0] writeback_data;
    wire [2:0] wb_rd;
    wire       wb_regwrite;
    wire [7:0] rd1, rd2;
    
    register_file RF(
        .clk(clk),
        .reset_n(reset_n),
        .we(wb_regwrite),
        .ra1(rs1),
        .ra2(rs2),
        .wa(wb_rd),
        .wd(writeback_data),
        .rd1(rd1),
        .rd2(rd2)
    );

    // Immediate Generator
    wire [15:0] imm6;
    immediate_gen IMM(
        .instr(id_instr),
        .imm6_sext(imm6)
    );

    // Hazard Detection
    wire [2:0] ex_rd;
    wire       ex_memread;
    hazard_unit HU(
        .id_rs1(rs1),
        .id_rs2(rs2),
        .ex_rd(ex_rd),
        .ex_memread(ex_memread),
        .stall(stall)
    );

    // ID/EX Pipeline Register
    wire [7:0] ex_rd1, ex_rd2;
    wire [15:0] ex_imm, ex_pcplus2;
    wire [2:0] ex_rs1, ex_rs2;
    wire ex_memwrite, ex_memtoreg, ex_regwrite, ex_branch;
    wire [3:0] ex_aluop;
    wire ex_alusrc;

    id_ex_register IDEX(
        .clk(clk),
        .reset_n(reset_n),
        .flush(flush_idex),
        .pcplus2_in(id_pcplus2),
        .imm_in(imm6),
        .rd1_in(rd1),
        .rd2_in(rd2),
        .rd_in(rd),
        .rs1_in(rs1),
        .rs2_in(rs2),
        .aluop_in(aluop),
        .alusrc_in(alusrc),
        .memread_in(memread),
        .memwrite_in(memwrite),
        .memtoreg_in(memtoreg),
        .regwrite_in(regwrite_cu),
        .branch_in(branch),
        .pcplus2_out(ex_pcplus2),
        .imm_out(ex_imm),
        .rd1_out(ex_rd1),
        .rd2_out(ex_rd2),
        .rd_out(ex_rd),
        .rs1_out(ex_rs1),
        .rs2_out(ex_rs2),
        .aluop_out(ex_aluop),
        .alusrc_out(ex_alusrc),
        .memread_out(ex_memread),
        .memwrite_out(ex_memwrite),
        .memtoreg_out(ex_memtoreg),
        .regwrite_out(ex_regwrite),
        .branch_out(ex_branch)
    );

    // Forwarding Unit
    wire [7:0] mem_alu_y, mem_rd2;
    wire [2:0] mem_rd;
    wire [3:0] mem_alu_flag;
    wire mem_memread, mem_memwrite, mem_memtoreg, mem_regwrite, mem_branch_flag, mem_zero_flag;
    wire [2:0] wb_stage_rd;
    wire wb_stage_regwrite;
    wire [1:0] forwardA, forwardB;
    
    forwarding_unit FU(
        .id_ex_rs1(ex_rs1),
        .id_ex_rs2(ex_rs2),
        .ex_mem_rd(mem_rd),
        .mem_wb_rd(wb_stage_rd),
        .ex_mem_regwrite(mem_regwrite),
        .mem_wb_regwrite(wb_stage_regwrite),
        .forwardA(forwardA),
        .forwardB(forwardB)
    );

    // ALU with Forwarding Muxes
    wire [7:0] alu_in1, alu_in2, alu_in2_base;
    wire [7:0] alu_y_pipe;
    wire [3:0] alu_flag;
    
    assign alu_in1 = (forwardA == 2'b00) ? ex_rd1 :
                     (forwardA == 2'b01) ? mem_alu_y :
                     writeback_data;
                     
    assign alu_in2_base = ex_alusrc ? ex_imm[7:0] : ex_rd2;
    assign alu_in2 = (forwardB == 2'b00) ? alu_in2_base :
                     (forwardB == 2'b01) ? mem_alu_y :
                     writeback_data;

    alu ALU(
        .a(alu_in1),
        .b(alu_in2),
        .sel(ex_aluop),
        .y(alu_y_pipe),
        .flag(alu_flag)
    );

    // Branch Logic
    assign branch_taken = ex_branch && alu_flag[3];
    assign pc_next = branch_taken ? (ex_pcplus2 + ex_imm) : (pc + 16'd2);

    // EX/MEM Pipeline Register
    ex_mem_register EXMEM(
        .clk(clk),
        .reset_n(reset_n),
        .alu_result_in(alu_y_pipe),
        .rd2_in(ex_rd2),
        .rd_in(ex_rd),
        .zero_in(alu_flag[3]),
        .alu_flag_in(alu_flag),
        .memread_in(ex_memread),
        .memwrite_in(ex_memwrite),
        .memtoreg_in(ex_memtoreg),
        .regwrite_in(ex_regwrite),
        .branch_in(ex_branch),
        .alu_result_out(mem_alu_y),
        .rd2_out(mem_rd2),
        .rd_out(mem_rd),
        .zero_out(mem_zero_flag),
        .alu_flag_out(mem_alu_flag),
        .memread_out(mem_memread),
        .memwrite_out(mem_memwrite),
        .memtoreg_out(mem_memtoreg),
        .regwrite_out(mem_regwrite),
        .branch_out(mem_branch_flag)
    );

    // Data Memory
    wire [7:0] mem_data_out;
    data_memory DMEM(
        .clk(clk),
        .reset_n(reset_n),
        .memread(mem_memread),
        .memwrite(mem_memwrite),
        .addr(mem_alu_y),
        .writedata(mem_rd2),
        .readdata(mem_data_out)
    );

    // MEM/WB Pipeline Register
    wire [7:0] wb_alu_y, wb_mem_data;
    wire [3:0] wb_alu_flag;
    wire wb_memtoreg;

    mem_wb_register MEMWB(
        .clk(clk),
        .reset_n(reset_n),
        .alu_result_in(mem_alu_y),
        .mem_data_in(mem_data_out),
        .rd_in(mem_rd),
        .alu_flag_in(mem_alu_flag),
        .memtoreg_in(mem_memtoreg),
        .regwrite_in(mem_regwrite),
        .alu_result_out(wb_alu_y),
        .mem_data_out(wb_mem_data),
        .rd_out(wb_stage_rd),
        .alu_flag_out(wb_alu_flag),
        .memtoreg_out(wb_memtoreg),
        .regwrite_out(wb_stage_regwrite)
    );

    // Writeback Stage
    assign writeback_data = wb_memtoreg ? wb_mem_data : wb_alu_y;
    assign reg_write_data = writeback_data;

endmodule
