`timescale 1ns/1ps
module register_file(
    input clk,
    input reset_n,
    input we,
    input [2:0] ra1,
    input [2:0] ra2,
    input [2:0] wa,
    input [7:0] wd,
    output reg [7:0] rd1,
    output reg [7:0] rd2
);
    reg [7:0] regs [0:7];
    integer i;

    always @(*) begin
        if ((ra1 >= 0) && (ra1 < 8))
            rd1 = ((we && wa == ra1 && wa != 3'b000) ? wd : regs[ra1]);
        else
            rd1 = 8'b0;

        if ((ra2 >= 0) && (ra2 < 8))
            rd2 = ((we && wa == ra2 && wa != 3'b000) ? wd : regs[ra2]);
        else
            rd2 = 8'b0;
    end

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            for (i = 0; i < 8; i = i + 1)
                regs[i] <= 8'h00;
        end else if (we && (wa != 3'b000) && (wa < 8)) begin
            regs[wa] <= wd;
        end
    end
endmodule
