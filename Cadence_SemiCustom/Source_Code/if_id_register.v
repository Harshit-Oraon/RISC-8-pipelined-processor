`timescale 1ns/1ps
module if_id_register(
    input clk,
    input reset_n,
    input stall,
    input flush,
    input [15:0] instr_in,
    input [15:0] pcplus2_in,
    output reg [15:0] instr_out,
    output reg [15:0] pcplus2_out
);
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            instr_out <= 16'hFFFF;
            pcplus2_out <= 16'h0000;
        end else if (flush) begin
            instr_out <= 16'hFFFF;
            pcplus2_out <= 16'h0000;
        end else if (!stall) begin
            instr_out <= instr_in;
            pcplus2_out <= pcplus2_in;
        end
    end
endmodule
