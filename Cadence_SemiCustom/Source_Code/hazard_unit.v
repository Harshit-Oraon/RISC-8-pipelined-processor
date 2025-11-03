`timescale 1ns / 1ps

module hazard_unit(
    input [2:0] id_ex_rd,
    input id_ex_mem_read,
    input [2:0] if_id_rs1,
    input [2:0] if_id_rs2,
    output reg stall
);

always @(*) begin
    if (id_ex_mem_read && ((id_ex_rd == if_id_rs1) || (id_ex_rd == if_id_rs2)))
        stall = 1;
    else
        stall = 0;
end

endmodule
