module alu
(input [31:0] i_Src_A,
 input [31:0] i_Src_B,
 input [2:0] i_ALU_Ctrl,
 
 output reg [31:0] o_ALU_Result,
 output o_Zero
);

always @(*) begin
    case(i_ALU_Ctrl)
        3'b000: o_ALU_Result = i_Src_A + i_Src_B;
        default: o_ALU_Result = 32'h0;
    endcase
end

assign o_Zero = (o_ALU_Result == 32'h0);

endmodule
