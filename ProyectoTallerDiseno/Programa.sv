module Programa(input logic clk, reset,write_enable_switch,input logic [1:0] switches,
output logic [31:0] WriteData,
 output logic MemWrite, output logic [31:0] DataAdr, output logic salida,
 output logic [7:0] r,g,b , output logic vgaclk,hsync,vsync,sync_b,blank_b, );
 
	logic [31:0] PC, Instr, ReadData , extra;
// instantiate processor and memories
	arm arm(.clk(clk), .reset(reset), .PC(PC), .Instr(Instr), .MemWrite(MemWrite), 
	.ALUResult(DataAdr),
	.WriteData(WriteData), .ReadData(ReadData));
	
	ROM mirom(.address(PC),.clock(clk), .q(Instr));
	
	RAMtree dmem(.address_a(DataAdr),.address_b(DataAdr),
	.clock(clk),.data_a(WriteData),.data_b(WriteData),.wren_a(1'b0),.wren_b(MemWrite),.q_a(ReadData),.q_b(extra));
	
	
	switch_controller micontroller(
        .clk(clk),
        .switches(switches),
        .write_enable_switch(write_enable_switch),
        .ram_data(ram_data),
        .ram_we(ram_we),
        .ram_addr(ram_addr)
    );
	 logic vgaclk, hsync, vsync, sync_b, blank_b;
    logic [7:0] r, g, b;

    // Instantiate the vga module
    vga dut (
        .clk(clk),
        .vgaclk(vgaclk),
        .hsync(hsync),
        .vsync(vsync),
        .sync_b(sync_b),
        .blank_b(blank_b),
        .r(r),
        .g(g),
        .b(b)
    );

endmodule