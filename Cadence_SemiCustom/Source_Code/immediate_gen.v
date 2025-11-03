`timescale 1ns/1ps
module immediate_gen(
    input [15:0] instr,
    output wire [15:0] imm6_sext
);
    assign imm6_sext = {{10{instr[5]}}, instr[5:0]};
endmodule
