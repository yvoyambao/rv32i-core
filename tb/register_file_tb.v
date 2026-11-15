`timescale 1ns/1ps

module register_file_tb(); 

reg r_Clk = 0;
reg [4:0] r_A1;
reg [4:0] r_A2;
reg [4:0] r_A3;
reg r_WE3;
reg [31:0] r_WD3;

wire [31:0] w_RD1;
wire [31:0] w_RD2;

register_file register_file_tb_inst 
(.i_Clk(r_Clk),
 .i_A1(r_A1),
 .i_A2(r_A2),
 .i_A3(r_A3),
 .i_WE3(r_WE3),
 .i_WD3(r_WD3),

 .o_RD1(w_RD1),
 .o_RD2(w_RD2)
);

task write_task;
    input [4:0] test_reg;
    input [31:0] exp_data;

    begin
        r_A3 = test_reg;
        r_WD3 = exp_data;
        r_WE3 = 1;

        @(posedge r_Clk);
        r_WE3 <= 0;
    end
endtask

task read_task;
    input [4:0] test_reg_1;
    input [4:0] test_reg_2;
    input [31:0] exp_data_1;
    input [31:0] exp_data_2;

    begin
        r_A1 = test_reg_1;
        r_A2 = test_reg_2;
        
        #1;
        if (w_RD1 !== exp_data_1)
            $display("FAIL");
        else
            $display("PASS");

        if (w_RD2 !== exp_data_2)
            $display("FAIL");
        else
            $display("PASS");  
    end
endtask

always
    #5 r_Clk <= !r_Clk;

initial begin
    $dumpfile("register_file.vcd");
    $dumpvars(0, register_file_tb);
    
    write_task(5'd1, 32'hDEADBEEF);
    read_task(5'd1, 5'd1, 32'hDEADBEEF, 32'hDEADBEEF);

    // different reg
    write_task(5'd2, 32'h12345678);
    read_task(5'd1, 5'd2, 32'hDEADBEEF, 32'h12345678);

    // x0
    write_task(5'd0, 32'hFFFFFFFF);
    read_task(5'd0, 5'd0, 32'h0, 32'h0);

    // block writes
    r_A3 = 5'd1; r_WD3 = 32'hBADBAD00; r_WE3 = 0;
    @(posedge r_Clk);
    read_task(5'd1, 5'd1, 32'hDEADBEEF, 32'hDEADBEEF);

    // Highest register
    write_task(5'd31, 32'hCAFEF00D);
    read_task(5'd31, 5'd31, 32'hCAFEF00D, 32'hCAFEF00D);

    // overwrite
    write_task(5'd1, 32'h0BADC0DE);
    read_task(5'd1, 5'd1, 32'h0BADC0DE, 32'h0BADC0DE);

    $finish;

end

endmodule

