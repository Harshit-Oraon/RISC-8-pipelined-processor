`timescale 1ns/1ps

`define NOP 16'hFFFF

module program_counter(
    input clk,
    input reset_n,
    input [15:0] pc_in,
    input pc_write,
    output reg [15:0] pc_out
);
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            pc_out <= 16'h0000;
        else if (pc_write)
            pc_out <= pc_in;
    end
endmodule
