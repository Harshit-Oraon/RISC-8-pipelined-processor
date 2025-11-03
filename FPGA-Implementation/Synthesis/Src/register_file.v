`timescale 1ns/1ps

module register_file(
  input clk,
  input reset_n,
  input we,
  input [2:0] ra1,
  input [2:0] ra2,
  input [2:0] wa,
  input [7:0] wd,
  output wire [7:0] rd1,
  output wire [7:0] rd2,
  output wire [7:0] reg0_out,
  output wire [7:0] reg1_out,
  output wire [7:0] reg2_out,
  output wire [7:0] reg3_out,
  output wire [7:0] reg4_out,
  output wire [7:0] reg5_out,
  output wire [7:0] reg6_out,
  output wire [7:0] reg7_out
);
  reg [7:0] regs [0:7];
  integer i;

  initial begin
    for (i = 0; i < 8; i = i + 1)
      regs[i] = 8'h00;
  end

  assign rd1 = ((we && (wa == ra1) && (wa != 3'b000)) ? wd : regs[ra1]);
  assign rd2 = ((we && (wa == ra2) && (wa != 3'b000)) ? wd : regs[ra2]);

  assign reg0_out = regs[0];
  assign reg1_out = regs[1];
  assign reg2_out = regs[2];
  assign reg3_out = regs[3];
  assign reg4_out = regs[4];
  assign reg5_out = regs[5];
  assign reg6_out = regs[6];
  assign reg7_out = regs[7];

  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      for (i = 0; i < 8; i = i + 1)
        regs[i] <= 8'h00;
    end else if (we && (wa != 3'b000)) begin
      regs[wa] <= wd;
    end
  end
endmodule
