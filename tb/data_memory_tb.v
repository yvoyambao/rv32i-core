`timescale 1ns/1ps

module data_memory_tb();
reg r_Clk = 0;
reg [31:0] r_Address;
reg r_WE;
reg [31:0] r_WD;

wire [31:0] w_RD;

data_memory data_memory_tb_inst
(.i_Clk(r_Clk),
 .i_Address(r_Address),
 .i_WE(r_WE),
 .i_WD(r_WD),
 .o_RD(w_RD)    
);

task write_task;
    input [31:0] address;
    input [31:0] exp_data;

    begin
        r_Address = address;
        r_WD = exp_data;
        r_WE = 1;

        @(posedge r_Clk);
        #1;
        r_WE = 0;
    end
endtask

task read_task;
    input [31:0] address;
    input [31:0] exp_data;

    begin
        r_Address = address;

        #1;
        if (w_RD !== exp_data)
            $display("FAIL");
        else
            $display("PASS");
    end
endtask


always
    #5 r_Clk <= !r_Clk;

initial begin
    $dumpfile("data_memory.vcd");
    $dumpvars(0, data_memory_tb);

    write_task(32'd8, 32'hDEADBEEF);
    read_task(32'd8, 32'hDEADBEEF);

    write_task(32'd12, 32'h12345678);
    read_task(32'd8, 32'hDEADBEEF);

    $finish;

end

endmodule
