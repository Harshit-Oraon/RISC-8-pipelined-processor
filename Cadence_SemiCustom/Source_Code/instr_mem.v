`timescale 1ns/1ps
module instr_mem #(parameter DEPTH = 1024)(
    input [15:0] addr,
    output reg [15:0] instr
);
    reg [15:0] rom [0:DEPTH-1];
    always @(*) begin
        if (addr[15:1] < DEPTH)
            instr = rom[addr[15:1]];
        else
            instr = 16'hFFFF;
    end
endmodule
