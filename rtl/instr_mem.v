module instruction_memory
(input [31:0] i_Address,

 output [31:0] o_Read_Data
);

parameter DEPTH = 64;

reg [31:0] mem [0:DEPTH-1]; // memory array, byte addressed

initial begin
   $readmemh("hex.txt", mem); 
end

assign o_Read_Data = mem[i_Address[31:2]];
    
endmodule


