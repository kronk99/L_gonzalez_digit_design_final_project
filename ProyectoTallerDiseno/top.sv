module top(input logic clk, reset,
output logic [31:0] WriteData,
 output logic MemWrite, output logic [31:0] DataAdr, output logic salida); //me muestra, lo que escribo, donde lo escribo y si lo escribo
 
	logic [31:0] PC, Instr, ReadData , extra;
// instantiate processor and memories
	arm arm(.clk(clk), .reset(reset), .PC(PC), .Instr(Instr), .MemWrite(MemWrite), 
	.ALUResult(DataAdr),
	.WriteData(WriteData), .ReadData(ReadData));
	
	ROM mirom(.address(PC),.clock(clk), .q(Instr));
	
	RAMtree dmem(.address_a(DataAdr),.address_b(DataAdr),
	.clock(clk),.data_a(WriteData),.data_b(WriteData),.wren_a(1'b0),.wren_b(MemWrite),.q_a(ReadData),.q_b(extra));
	always @(posedge clk) begin
		salida = ReadData;	
	end
	
endmodule