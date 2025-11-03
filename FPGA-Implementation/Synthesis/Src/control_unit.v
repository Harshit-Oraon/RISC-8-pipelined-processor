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
    always @* begin
        regwrite = 0; memread = 0; memwrite = 0;
        memtoreg = 0; alusrc = 0; branch = 0; aluop = 4'b0000;

        case(opcode)
            4'h0: begin regwrite=1; aluop=4'b0000; end // ADD
            4'h1: begin regwrite=1; aluop=4'b0001; end // SUB
            4'h2: begin regwrite=1; aluop=4'b0010; end // AND
            4'h3: begin regwrite=1; aluop=4'b0011; end // OR
            4'h4: begin regwrite=1; alusrc=1; aluop=4'b0000; end // ADDI
            4'h5: begin regwrite=1; memread=1; memtoreg=1; alusrc=1; aluop=4'b0000; end // LD
            4'h6: begin memwrite=1; alusrc=1; aluop=4'b0000; end // ST
            4'h7: begin regwrite=1; aluop=4'b0111; end // XNOR
            4'h8: begin branch=1; aluop=4'b0001; end // BEQ
            4'h9: begin regwrite=1; aluop=4'b1001; end // SR A
            4'hA: begin regwrite=1; aluop=4'b1010; end // SL B
            4'hB: begin regwrite=1; aluop=4'b1011; end // SR B
            4'hC: begin regwrite=1; aluop=4'b1100; end // EQ
            4'hD: begin regwrite=1; aluop=4'b1101; end // LT
            4'hE: begin regwrite=1; aluop=4'b1110; end // GT
            4'hF: ; // NOP
            default: ;
        endcase
    end
endmodule
