`timescale 1ns / 1ps

module vga_tb;

    // Inputs
    logic clk;

    // Outputs
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

    // Clock generation
    always #5 clk = ~clk;

    // Initial clock value
    initial begin
        clk = 1'b0;
        #10;
    end

    // Add stimulus here if necessary

endmodule
