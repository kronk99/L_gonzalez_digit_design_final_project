module vga(
    input logic clk,
    output logic vgaclk, // 25.175 MHz VGA clock
    output logic hsync, vsync,
    output logic sync_b, blank_b, // To monitor & DAC
    output logic [7:0] r, g, b
); 
    // To video DAC
    logic [9:0] x, y;
    
    // Use a PLL to create the 25.175 MHz VGA pixel clock
    // 25.175 MHz clk period = 39.772 ns
    // Screen is 800 clocks wide by 525 tall, but only 640 x 480 used
    // HSync = 1/(39.772 ns *800) = 31.470 kHz
    // Vsync = 31.474 kHz / 525 = 59.94 Hz (~60 Hz refresh rate)
    vgapll vgapll(.refclk(clk), .outclk_0(vgaclk));
    // Generate monitor timing signals
    vgaController vgaCont(vgaclk, hsync, vsync, sync_b, blank_b, x, y);
    // User-defined module to determine pixel color
    videoGen videoGen(vgaclk, x, y, r, g, b);
    
endmodule

module vgaController #(parameter HACTIVE = 10'd640,
                       HFP = 10'd16,
                       HSYN = 10'd96,
                       HBP = 10'd48,
                       HMAX = HACTIVE + HFP + HSYN + HBP,
                       VBP = 10'd32,
                       VACTIVE = 10'd480,
                       VFP = 10'd11,
                       VSYN = 10'd2,
                       VMAX = VACTIVE + VFP + VSYN + VBP)
                      (input logic vgaclk,
                       output logic hsync, vsync, sync_b, blank_b,
                       output logic [9:0] x, y);

    // Contadores para las posiciones horizontales y verticales
    logic [9:0] hcnt, vcnt;

    always @(posedge vgaclk) begin
        if (hcnt == HMAX - 1) begin
            hcnt <= 0;
            if (vcnt == VMAX - 1) begin
                vcnt <= 0;
            end else begin
                vcnt <= vcnt + 1;
            end
        end else begin
            hcnt <= hcnt + 1;
        end
    end

    // Asignar las posiciones x e y de salida
    assign x = (hcnt < HACTIVE) ? hcnt : 10'd0;
    assign y = (vcnt < VACTIVE) ? vcnt : 10'd0;

    // Calcular las señales de sincronización (activo bajo)
    assign hsync = ~(hcnt >= HACTIVE + HFP && hcnt < HACTIVE + HFP + HSYN);
    assign vsync = ~(vcnt >= VACTIVE + VFP && vcnt < VACTIVE + VFP + VSYN);
    assign sync_b = hsync & vsync;

    // Forzar las salidas a negro cuando estén fuera del área de visualización legal
    assign blank_b = (hcnt < HACTIVE) && (vcnt < VACTIVE);

endmodule

module videoGen(
    input logic clk,
    input logic [9:0] x, y, 
    output logic [7:0] r, g, b
);
    logic pixel;
    logic [7:0] char;
    logic [4:0] char_index;
    logic in_text_region;
    logic wren = 1'b0;

    // Define la región en la que se mostrará el texto
    parameter H_START = 0; // Inicio horizontal (en caracteres)
    parameter V_START = 0; // Inicio vertical (en líneas)
    parameter CHAR_WIDTH = 8; // Ancho del carácter en píxeles
    parameter CHAR_HEIGHT = 8; // Altura del carácter en píxeles

    // Calcular el índice de carácter en la RAM en función de la posición x e y
    assign char_index = (x >= H_START * CHAR_WIDTH && x < (H_START + 20) * CHAR_WIDTH && y >= V_START * CHAR_HEIGHT && y < (V_START + 1) * CHAR_HEIGHT) ? 
                        (x - H_START * CHAR_WIDTH) / CHAR_WIDTH : 5'd31; // 31 es un espacio en blanco

    // Verificar si estamos en la región del texto
    assign in_text_region = (x >= H_START * CHAR_WIDTH && x < (H_START + 20) * CHAR_WIDTH && y >= V_START * CHAR_HEIGHT && y < (V_START + 1) * CHAR_HEIGHT);

    // Instancia del módulo RAM
    logic [7:0] ram_data;
    ram1 text_ram (
        .address(char_index),
        .clock(clk),
        .data(8'd0), // Datos no utilizados en este contexto
        .wren(wren),
        .q(ram_data)
    );

    assign char = ram_data;

    // Generar los píxeles del carácter
    chargenrom chargenromb(.ch(char), .xoff(x[2:0]), .yoff(y[2:0]), .pixel(pixel));

    // Asignar color a los píxeles
    assign {r, b} = (y[3] == 0 && in_text_region) ? {{8{pixel}}, 8'h00} : {8'h00, {8{pixel}}};
    assign g = 8'h00; // Se puede usar para agregar color verde si es necesario
endmodule

module chargenrom(
    input logic [7:0] ch,
    input logic [2:0] xoff, yoff,
    output logic pixel
);

    logic [5:0] charrom[2047:0]; // character generator ROM
    logic [7:0] line; // a line read from the ROM
    // Initialize ROM with characters from text file
    initial
    $readmemb("charrom.txt", charrom);
    // Index into ROM to find line of character
    assign line = charrom[yoff + {ch-65, 3'b000}]; // Subtract 65 because A
    // is entry 0
    // Reverse order of bits
    assign pixel = line[3'd7-xoff];
    
endmodule

module rectgen(
    input logic [9:0] x, y, left, top, right, bot,
    output logic inrect
);
    assign inrect = (x >= left & x < right & y >= top & y < bot);
endmodule 
