module risc8_pipeline_top(
    input clk_in,
    input reset_n_in
);
    wire clk;
    wire reset_n;

    BUFG clk_buf (
        .I(clk_in),
        .O(clk)
    );

    reg [3:0] reset_sync;
    always @(posedge clk or negedge reset_n_in) begin
        if (!reset_n_in)
            reset_sync <= 4'b0000;
        else
            reset_sync <= {reset_sync[2:0], 1'b1};
    end
    assign reset_n = reset_sync[3];

    wire [15:0] pc;
    wire [15:0] pc_next;
    wire stall, flush_ifid, flush_idex, branch_taken;
    assign flush_ifid = branch_taken;
    assign flush_idex = branch_taken || stall;

    program_counter PC(
        .clk(clk),
        .reset_n(reset_n),
        .pc_in(pc_next),
        .pc_write(~stall),
        .pc_out(pc)
    );

    wire [15:0] instr;
    wire [9:0] instr_addr = pc[11:2];

    blk_mem_gen_0 IMEM (
        .clka(clk),
        .ena(1'b1),
        .wea(1'b0),
        .addra(instr_addr),
        .dina(16'b0),
        .douta(instr)
    );

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

    wire [3:0] opcode = id_instr[15:12];
    wire [2:0] rd     = id_instr[11:9];
    wire [2:0] rs1    = id_instr[8:6];
    wire [2:0] rs2    = id_instr[5:3];

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

    wire [7:0] writeback_data;
    wire [2:0] wb_rd;
    wire wb_regwrite;
    wire [7:0] rd1, rd2;
    wire [7:0] reg0_out, reg1_out, reg2_out, reg3_out, reg4_out, reg5_out, reg6_out, reg7_out;
    register_file RF(
        .clk(clk),
        .reset_n(reset_n),
        .we(wb_regwrite),
        .ra1(rs1),
        .ra2(rs2),
        .wa(wb_rd),
        .wd(writeback_data),
        .rd1(rd1),
        .rd2(rd2),
        .reg0_out(reg0_out),
        .reg1_out(reg1_out),
        .reg2_out(reg2_out),
        .reg3_out(reg3_out),
        .reg4_out(reg4_out),
        .reg5_out(reg5_out),
        .reg6_out(reg6_out),
        .reg7_out(reg7_out)
    );

    wire [15:0] imm6;
    immediate_gen IMM(
        .instr(id_instr),
        .imm6_sext(imm6)
    );

    wire [2:0] ex_rd;
    wire ex_memread;
    hazard_unit HU(
        .id_rs1(rs1),
        .id_rs2(rs2),
        .ex_rd(ex_rd),
        .ex_memread(ex_memread),
        .stall(stall)
    );

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

    wire [7:0] alu_y_pipe;
    wire [3:0] alu_flag;
    wire [7:0] mem_alu_y, mem_rd2;
    wire [2:0] mem_rd;
    wire [3:0] mem_alu_flag;
    wire mem_memread, mem_memwrite, mem_memtoreg, mem_regwrite, mem_branch_flag, mem_zero_flag;
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

    wire [7:0] alu_in1, alu_in2, alu_in2_base;
    assign alu_in1 = (forwardA == 2'b00) ? ex_rd1 :
                     (forwardA == 2'b01) ? mem_alu_y :
                     (forwardA == 2'b10) ? writeback_data : ex_rd1;
    assign alu_in2_base = ex_alusrc ? ex_imm[7:0] : ex_rd2;
    assign alu_in2 = (forwardB == 2'b00) ? alu_in2_base :
                     (forwardB == 2'b01) ? mem_alu_y :
                     (forwardB == 2'b10) ? writeback_data : alu_in2_base;

    alu ALU(
        .a(alu_in1),
        .b(alu_in2),
        .sel(ex_aluop),
        .y(alu_y_pipe),
        .flag(alu_flag)
    );

    assign branch_taken = ex_branch && alu_flag[3];
    assign pc_next = branch_taken ? (ex_pcplus2 + ex_imm) : (pc + 16'd2);

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

    assign writeback_data = wb_memtoreg ? wb_mem_data : wb_alu_y;
    assign wb_rd         = wb_stage_rd;
    assign wb_regwrite   = wb_stage_regwrite;

    // ILA Probe Mapping
    ila_0 u_ila (
        .clk(clk),
        .probe0(reg0_out),
        .probe1(reg1_out),
        .probe2(reg2_out),
        .probe3(reg3_out),
        .probe4(reg4_out),
        .probe5(reg5_out),
        .probe6(reg6_out),
        .probe7(reg7_out),
        .probe8(instr),
        .probe9(pc),
        .probe10(alu_y_pipe),
        .probe11(reset_n)
    );
endmodule
