module sign_extend
(input [31:7] i_Instr,
 output [31:0] o_Imm_Ext
);

assign o_Imm_Ext = {{20{i_Instr[31]}}, i_Instr[31:20]}; //lw instruction

endmodule