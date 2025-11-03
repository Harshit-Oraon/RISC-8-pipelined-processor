`timescale 1ns / 1ps

module id_ex_register(
    input clk,
    input reset,
    input [7:0] read_data1_in,
    input [7:0] read_data2_in,
    input [7:0] immediate_in,
    input [2:0] alu_op_in,
    input mem_read_in,
    input mem_write_in,
    input reg_write_in,
    input mem_to_reg_in,
    input [2:0] rd_in,
    output reg [7:0] read_data1_out,
    output reg [7:0] read_data2_out,
    output reg [7:0] immediate_out,
    output reg [2:0] alu_op_out,
    output reg mem_read_out,
    output reg mem_write_out,
    output reg reg_write_out,
    output reg mem_to_reg_out,
    output reg [2:0] rd_out
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        read_data1_out <= 8'd0;
        read_data2_out <= 8'd0;
        immediate_out <= 8'd0;
        alu_op_out <= 3'd0;
        mem_read_out <= 0;
        mem_write_out <= 0;
        reg_write_out <= 0;
        mem_to_reg_out <= 0;
        rd_out <= 3'd0;
    end else begin
        read_data1_out <= read_data1_in;
        read_data2_out <= read_data2_in;
        immediate_out <= immediate_in;
        alu_op_out <= alu_op_in;
        mem_read_out <= mem_read_in;
        mem_write_out <= mem_write_in;
        reg_write_out <= reg_write_in;
        mem_to_reg_out <= mem_to_reg_in;
        rd_out <= rd_in;
    end
end

endmodule
