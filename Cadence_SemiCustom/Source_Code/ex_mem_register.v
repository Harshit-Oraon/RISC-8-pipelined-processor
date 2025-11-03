`timescale 1ns / 1ps

module ex_mem_register(
    input clk,
    input reset,
    input [7:0] alu_result_in,
    input [7:0] write_data_in,
    input [2:0] rd_in,
    input mem_read_in,
    input mem_write_in,
    input reg_write_in,
    input mem_to_reg_in,
    output reg [7:0] alu_result_out,
    output reg [7:0] write_data_out,
    output reg [2:0] rd_out,
    output reg mem_read_out,
    output reg mem_write_out,
    output reg reg_write_out,
    output reg mem_to_reg_out
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        alu_result_out <= 8'd0;
        write_data_out <= 8'd0;
        rd_out <= 3'd0;
        mem_read_out <= 0;
        mem_write_out <= 0;
        reg_write_out <= 0;
        mem_to_reg_out <= 0;
    end else begin
        alu_result_out <= alu_result_in;
        write_data_out <= write_data_in;
        rd_out <= rd_in;
        mem_read_out <= mem_read_in;
        mem_write_out <= mem_write_in;
        reg_write_out <= reg_write_in;
        mem_to_reg_out <= mem_to_reg_in;
    end
end

endmodule
