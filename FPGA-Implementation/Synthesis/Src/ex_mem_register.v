`timescale 1ns/1ps

module ex_mem_register(
    input clk,
    input reset_n,
    input [7:0] alu_result_in,
    input [7:0] rd2_in,
    input [2:0] rd_in,
    input zero_in,
    input [3:0] alu_flag_in,
    input memread_in,
    input memwrite_in,
    input memtoreg_in,
    input regwrite_in,
    input branch_in,
    output reg [7:0] alu_result_out,
    output reg [7:0] rd2_out,
    output reg [2:0] rd_out,
    output reg zero_out,
    output reg [3:0] alu_flag_out,
    output reg memread_out,
    output reg memwrite_out,
    output reg memtoreg_out,
    output reg regwrite_out,
    output reg branch_out
);
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            alu_result_out <= 8'd0; rd2_out <= 8'd0; rd_out <= 3'd0; zero_out <= 1'b0;
            alu_flag_out <= 4'd0; memread_out <= 1'b0; memwrite_out <= 1'b0;
            memtoreg_out <= 1'b0; regwrite_out <= 1'b0; branch_out <= 1'b0;
        end else begin
            alu_result_out <= alu_result_in; rd2_out <= rd2_in; rd_out <= rd_in; zero_out <= zero_in;
            alu_flag_out <= alu_flag_in; memread_out <= memread_in; memwrite_out <= memwrite_in;
            memtoreg_out <= memtoreg_in; regwrite_out <= regwrite_in; branch_out <= branch_in;
        end
    end
endmodule
