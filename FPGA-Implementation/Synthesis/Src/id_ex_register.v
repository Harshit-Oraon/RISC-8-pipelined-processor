`timescale 1ns/1ps

module id_ex_register(
    input clk,
    input reset_n,
    input flush,
    input [15:0] pcplus2_in,
    input [15:0] imm_in,
    input [7:0] rd1_in,
    input [7:0] rd2_in,
    input [2:0] rd_in,
    input [2:0] rs1_in,
    input [2:0] rs2_in,
    input [3:0] aluop_in,
    input alusrc_in,
    input memread_in,
    input memwrite_in,
    input memtoreg_in,
    input regwrite_in,
    input branch_in,
    output reg [15:0] pcplus2_out,
    output reg [15:0] imm_out,
    output reg [7:0] rd1_out,
    output reg [7:0] rd2_out,
    output reg [2:0] rd_out,
    output reg [2:0] rs1_out,
    output reg [2:0] rs2_out,
    output reg [3:0] aluop_out,
    output reg alusrc_out,
    output reg memread_out,
    output reg memwrite_out,
    output reg memtoreg_out,
    output reg regwrite_out,
    output reg branch_out
);
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n || flush) begin
            pcplus2_out <= 16'd0; imm_out <= 16'd0; rd1_out <= 8'd0; rd2_out <= 8'd0;
            rd_out <= 3'd0; rs1_out <= 3'd0; rs2_out <= 3'd0; aluop_out <= 4'd0;
            alusrc_out <= 1'b0; memread_out <= 1'b0; memwrite_out <= 1'b0;
            memtoreg_out <= 1'b0; regwrite_out <= 1'b0; branch_out <= 1'b0;
        end else begin
            pcplus2_out <= pcplus2_in; imm_out <= imm_in; rd1_out <= rd1_in; rd2_out <= rd2_in;
            rd_out <= rd_in; rs1_out <= rs1_in; rs2_out <= rs2_in; aluop_out <= aluop_in;
            alusrc_out <= alusrc_in; memread_out <= memread_in; memwrite_out <= memwrite_in;
            memtoreg_out <= memtoreg_in; regwrite_out <= regwrite_in; branch_out <= branch_in;
        end
    end
endmodule
