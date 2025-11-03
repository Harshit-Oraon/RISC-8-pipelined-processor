`timescale 1ns/1ps
module control_unit(
    input [3:0] opcode,
    output reg regwrite,
    output reg memread,
    output reg memwrite,
    output reg memtoreg,
    output reg alusrc,
    output reg branch,
    output reg [3:0] aluop
);
    always @(*) begin
        regwrite = 0; memread = 0; memwrite = 0;
        memtoreg = 0; alusrc = 0; branch = 0; aluop = 0;

        case(opcode)
            4'h0: begin regwrite=1; aluop=4'b0000; end
            4'h1: begin regwrite=1; aluop=4'b0001; end
            4'h2: begin regwrite=1; aluop=4'b0010; end
            4'h3: begin regwrite=1; aluop=4'b0011; end
            4'h4: begin regwrite=1; alusrc=1; aluop=4'b0000; end
            4'h5: begin regwrite=1; memread=1; memtoreg=1; alusrc=1; aluop=4'b0000; end
            4'h6: begin memwrite=1; alusrc=1; aluop=4'b0000; end
            4'hF: ; // NOP
        endcase
    end
endmodule
