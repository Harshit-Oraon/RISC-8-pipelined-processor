`timescale 1ns/1ps

module mem_wb_register(
    input clk,
    input reset_n,
    input [7:0] alu_result_in,
    input [7:0] mem_data_in,
    input [2:0] rd_in,
    input [3:0] alu_flag_in,
    input memtoreg_in,
    input regwrite_in,
    output reg [7:0] alu_result_out,
    output reg [7:0] mem_data_out,
    output reg [2:0] rd_out,
    output reg [3:0] alu_flag_out,
    output reg memtoreg_out,
    output reg regwrite_out
);
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            alu_result_out <= 8'd0; mem_data_out <= 8'd0; rd_out <= 3'd0; alu_flag_out <= 4'd0;
            memtoreg_out <= 1'b0; regwrite_out <= 1'b0;
        end else begin
            alu_result_out <= alu_result_in; mem_data_out <= mem_data_in; rd_out <= rd_in;
            alu_flag_out <= alu_flag_in; memtoreg_out <= memtoreg_in; regwrite_out <= regwrite_in;
        end
    end
endmodule
