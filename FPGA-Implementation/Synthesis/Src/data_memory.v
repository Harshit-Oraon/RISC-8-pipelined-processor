`timescale 1ns/1ps

module data_memory(
    input clk,
    input reset_n,
    input memread,
    input memwrite,
    input [7:0] addr,
    input [7:0] writedata,
    output reg [7:0] readdata
);
    reg [7:0] ram [0:255];
    integer i;

    initial begin
        for (i = 0; i < 256; i = i + 1)
            ram[i] = 8'h00;
    end

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            for (i = 0; i < 256; i = i + 1)
                ram[i] <= 8'h00;
            readdata <= 8'h00;
        end else begin
            if (memwrite)
                ram[addr] <= writedata;
            if (memread)
                readdata <= ram[addr];
        end
    end
endmodule
