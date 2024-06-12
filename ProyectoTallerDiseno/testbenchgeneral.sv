`timescale 1ns / 1ps

module testbenchgeneral;

    // Parámetros
    logic reset;
    logic [31:0] WriteData;
    logic MemWrite;
    logic [31:0] DataAdr;
    logic salida;

    // Instanciación del módulo bajo prueba
    
    // Clock generation
    parameter CLOCK_PERIOD = 10; // Clock
    logic clk = 0;
    always #CLOCK_PERIOD clk = ~clk;
    top dut (
        .clk(clk),
        .reset(reset),
        .WriteData(WriteData),
        .MemWrite(MemWrite),
        .DataAdr(DataAdr),
        .salida(salida)
    );


    // Generación de clock
    initial begin
        // Inicialización de señales
        reset = 1;
        
        // Esperar un poco antes de liberar el reset
        #100;
        
        // Cambiar reset después de esperar
        reset = 0;

        // Generar señal de reloj
    end

endmodule
