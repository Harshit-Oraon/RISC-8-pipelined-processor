`timescale 1ns/1ps

module alu(
    input [7:0] a,
    input [7:0] b,
    input [3:0] sel,
    output reg [7:0] y,
    output reg [3:0] flag
);
    reg carry, borrow;
    always @* begin
        carry = 0;
        borrow = 0;
        case(sel)
            4'b0000: {carry, y} = a + b;
            4'b0001: {borrow, y} = {1'b0, a} - b;
            4'b0010: y = a & b;
            4'b0011: y = a | b;
            4'b0100: y = a ^ b;
            4'b0101: y = ~(a | b);
            4'b0110: y = ~(a & b);
            4'b0111: y = ~(a ^ b);
            4'b1000: y = a << 1;
            4'b1001: y = a >> 1;
            4'b1010: y = b << 1;
            4'b1011: y = b >> 1;
            4'b1100: y = (a == b) ? 8'h01 : 8'h00;
            4'b1101: y = (a < b)  ? 8'h01 : 8'h00;
            4'b1110: y = (a > b)  ? 8'h01 : 8'h00;
            4'b1111: y = ~a;
            default: y = 8'h00;
        endcase
        flag[3] = (y == 8'h00);
        flag[2] = carry;
        flag[1] = borrow;
        flag[0] = ~^y;
    end
endmodule
