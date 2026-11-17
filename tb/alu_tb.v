`timescale 1ns/1ps

module alu_tb();
reg [31:0] r_Src_A;
reg [31:0] r_Src_B;
reg [2:0] r_ALU_Ctrl;
wire [31:0] w_ALU_Result;
wire w_Zero;


alu alu_tb_inst
(.i_Src_A(r_Src_A),
 .i_Src_B(r_Src_B),
 .i_ALU_Ctrl(r_ALU_Ctrl),
 .o_ALU_Result(w_ALU_Result),
 .o_Zero(w_Zero)
 );

task check_op;
    input [31:0] op1;
    input [31:0] op2;
    input [2:0] ctrl;
    input [31:0] exp_res;
    input zero;

    begin
        r_Src_A = op1;
        r_Src_B = op2;
        r_ALU_Ctrl = ctrl;
        #1;
        if (w_ALU_Result !== exp_res)
            $display("FAIL: A=%h B=%h ctrl=%b got %h exp %h",
            op1, op2, ctrl, w_ALU_Result, exp_res);
        else
            $display("PASS");
        if (w_Zero !== zero)
            $display("FAIL: Zero got %b exp %b", w_Zero, zero);
        else
            $display("PASS");
    end
endtask

initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, alu_tb);
    // add
    check_op(32'd5, 32'd3, 3'b000, 32'd8, 1'b0);

    // negative offset
    check_op(32'h00001000, 32'hFFFFFFFC, 3'b000, 32'h00000FFC, 1'b0);

    // zero result
    check_op(32'd5, 32'hFFFFFFFB, 3'b000, 32'h0, 1'b1);

    // max val
    check_op(32'hFFFFFFFF, 32'd1, 3'b000, 32'h0, 1'b1);

    // large val
    check_op(32'h12345678, 32'h87654321, 3'b000, 32'h99999999, 1'b0);

    // default case
    check_op(32'd5, 32'd3, 3'b111, 32'h0, 1'b1);

    $finish;
end

    


endmodule