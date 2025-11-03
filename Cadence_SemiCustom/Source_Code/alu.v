`timescale 1ns/1ps
module alu(
    input [7:0] a,
    input [7:0] b,
    input [3:0] sel,
    output reg [7:0] y,
    output reg [3:0] flag
);
    reg [8:0] temp_result;
    reg carry, borrow;
    
    always @(*) begin
        carry = 0; borrow = 0; y = 0;
        case(sel)
            4'b0000: begin temp_result = a + b; y = temp_result[7:0]; carry = temp_result[8]; end
            4'b0001: begin temp_result = a - b; y = temp_result[7:0]; borrow = temp_result[8]; end
            4'b0010: y = a & b;
            4'b0011: y = a | b;
            default: y = 8'h00;
        endcase
        flag[3] = (y == 0); flag[2] = carry; flag[1] = borrow; flag[0] = ~^y;
    end
endmodule
