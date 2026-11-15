`timescale 1ns/1ps
module instruction_memory_tb ();

reg [31:0] r_Address;
wire [31:0] w_Read_Data;

instruction_memory instruction_memory_tb_inst
(.i_Address(r_Address),
 .o_Read_Data(w_Read_Data)
);

task check_address;
    input [31:0] test_address;
    input [31:0] expected_data;

    begin
        r_Address = test_address;
        #1;
        if (w_Read_Data !== expected_data)
            $display("FAIL");
        else
            $display("PASS"); 
    end
endtask
    
initial begin
    $dumpfile("instr_mem.vcd");
    $dumpvars(0, instruction_memory_tb);
    check_address(0, 32'h11111111);
    check_address(4, 32'h22222222);
    check_address(8, 32'h33333333);
    check_address(12, 32'hDEADBEEF);

    $finish;
end

endmodule
