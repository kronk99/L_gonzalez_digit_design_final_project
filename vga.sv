module vga(
    input logic clk,
    output logic vgaclk, // 25.175 MHz VGA clock
    output logic hsync, vsync,
    output logic sync_b, blank_b, // To monitor & DAC
    output logic [7:0] r, g, b // To video DAC
);

logic [9:0] x, y;

// Use a PLL to create the 25.175 MHz VGA pixel clock
pll vgapll(.inclk0(clk), .c0(vgaclk));

// Generate monitor timing signals
vgaController vgaCont(
    .vgaclk(vgaclk), 
    .hsync(hsync), 
    .vsync(vsync), 
    .sync_b(sync_b), 
    .blank_b(blank_b), 
    .x(x), 
    .y(y)
);

// User-defined module to determine pixel color
videoGen videoGen(
    .x(x), 
    .y(y), 
    .r(r), 
    .g(g), 
    .b(b)
);

endmodule

module vgaController #(
    parameter HACTIVE = 10'd640,
    parameter HFP = 10'd16,
    parameter HSYN = 10'd96,
    parameter HBP = 10'd48,
    parameter HMAX = (HACTIVE + HFP + HSYN + HBP),
    parameter VBP = 10'd32,
    parameter VACTIVE = 10'd480,
    parameter VFP = 10'd11,
    parameter VSYN = 10'd2,
    parameter VMAX = (VACTIVE + VFP + VSYN + VBP)
)(
    input logic vgaclk,
    output logic hsync, vsync, sync_b, blank_b,
    output logic [9:0] x, y
);

// counters for horizontal and vertical positions
always @(posedge vgaclk) begin
    x++;
    if (x == HMAX) begin
        x = 0;
        y++;
        if (y == VMAX) y = 0;
    end
end

// Compute sync signals (active low)
assign hsync = ~(x >= (HACTIVE + HFP) && x < (HACTIVE + HFP + HSYN));
assign vsync = ~(y >= (VACTIVE + VFP) && y < (VACTIVE + VFP + VSYN));
assign sync_b = hsync && vsync;
// Force outputs to black when outside the legal display area
assign blank_b = (x < HACTIVE) && (y < VACTIVE);

endmodule

module videoGen(
    input logic [9:0] x, y,
    output logic [7:0] r, g, b
);
    logic pixel;
    logic [7:0] text[59:0][79:0]; // Assuming 80x60 characters for 640x480 resolution
    logic [2:0] xoff, yoff;
    logic [7:0] charcode;
	 logic [7:0][7:0] texto;

    // Initialize text array (example: "HELLO WORLD")
    initial begin
        text[0][0] = 1; text[0][1] = 2; text[0][2] = 3; text[0][3] = 4; text[0][4] = 5;
        text[0][5] = 0; text[0][6] = 6; text[0][7] = 7; text[0][8] = 8; text[0][9] = 9; text[0][10] = 11;
		  texto[0] = 10; texto[1] = 11; texto[2] =12; texto[3] = 1; texto[4] = 3;
        // Initialize other characters as needed...
    end

    // Character generator ROM instantiation
    chargenrom charrom(.ch(charcode), .xoff(xoff), .yoff(yoff), .pixel(pixel));

    // Determine the character code and offsets based on x and y positions
    always_comb begin
        if (x < 540 && y < 300 && x>100 && y>100) begin
            charcode = texto; // Each character is 8x8 pixels
            xoff = x % 8;
            yoff = y % 8;
        end else begin
            charcode = 8'h20; // Space character for areas outside the active area
            xoff = 3'b0;
            yoff = 3'b0;
        end
    end
	 
	 rectgen rectgen_inst(
    .x(x), 
    .y(y), 
    .left(10'd120), 
    .top(10'd150), 
    .right(10'd200), 
    .bot(10'd230), 
    .inrect(inrect)
);

    // Assign colors based on the pixel value
    assign r = pixel ? 8'hFF : 8'h00;
    assign g = pixel ? 8'hFF : 8'h00;
    assign b = pixel ? 8'hFF : 8'h00;
endmodule

module chargenrom(
    input logic [7:0] ch, // Character code
    input logic [2:0] xoff, yoff, // Offset within character
    output logic pixel // Pixel value
);

logic [7:0] charrom[2047:0]; // Character generator ROM
logic [7:0] line; // A line read from the ROM

// Initialize ROM with characters from a text file
initial begin
    $readmemb("charrom.txt", charrom); // Load character bitmaps
end

// Calculate the index in the ROM for the given character and line
assign line = charrom[ch * 8 + yoff];

// Reverse order of bits for correct display
assign pixel = line[7 - xoff];

endmodule




module rectgen(
    input logic [9:0] x, y,
    input logic [9:0] left, top, right, bot,
    output logic inrect
);

assign inrect = (x >= left && x < right && y >= top && y < bot);

endmodule

module pll (
    input logic inclk0, // input clock signal
    output logic c0     // output clock signal
);

logic toggle;

initial begin
    toggle = 0;
end

// Flip-flop to divide by 2
always @(posedge inclk0) begin
    toggle <= ~toggle;
end

// Output is the value of toggle, which changes with each rising edge of inclk0
assign c0 = toggle;

endmodule
