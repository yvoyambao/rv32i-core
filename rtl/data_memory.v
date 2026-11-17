module data_memory
(input i_Clk,
 input [31:0] i_Address,
 input i_WE,
 input [31:0] i_WD,
 
 output [31:0] o_RD
 );

parameter DEPTH = 64;

reg [31:0] mem [0:DEPTH-1];

always @(posedge i_Clk)
begin
    if (i_WE == 1'b1) begin
        mem[i_Address[31:2]] <= i_WD;
    end
end

assign o_RD = mem[i_Address[31:2]];

endmodule