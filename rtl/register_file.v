module register_file
(input i_Clk,
 input [4:0] i_A1,
 input [4:0] i_A2,
 input [4:0] i_A3,
 input i_WE3,
 input [31:0] i_WD3,

 output [31:0] o_RD1,
 output [31:0] o_RD2
);

reg [31:0] mem [0:31];

always @(posedge i_Clk)
    begin
        if (i_WE3 == 1'b1) begin
            mem[i_A3] <= i_WD3;    // WE = 1'b1, write data
        end
    end                            // WE = 1'b0, read data

assign o_RD1 = i_A1 == 0 ? 32'b0 : mem[i_A1];
assign o_RD2 = i_A2 == 0 ? 32'b0 : mem[i_A2];

endmodule