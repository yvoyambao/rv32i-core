`timescale 1ns/1ps
module sign_extend_tb();

reg [31:7] r_Instr;
wire [31:0] w_Imm_Ext;

sign_extend sign_extend_tb_inst
(.i_Instr(r_Instr),
 .o_Imm_Ext(w_Imm_Ext)
);

task check_imm;
    input [31:7] instr;
    input [31:0] exp_imm;

    begin
        r_Instr = instr;
        #1;
        if (w_Imm_Ext !== exp_imm)
            $display("FAIL: imm=%h got %h exp %h", instr, w_Imm_Ext, exp_imm);
        else
            $display("PASS");
    end
endtask

initial begin
    $dumpfile("sign_extend.vcd");
    $dumpvars(0, sign_extend_tb);

    // neg num check
    check_imm(25'h1FF8000, 32'hFFFFFFFC);

    // pos num check
    check_imm(25'h0FFFABC, 32'h000007FF);

    // opposite edge
    check_imm(25'h1001FFF, 32'hFFFFF800);   

    $finish;
end

endmodule