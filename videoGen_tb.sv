`timescale 1ns / 1ps

module videoGen_tb;

    // Parámetros
    parameter CHAR_WIDTH = 8;
    parameter CHAR_HEIGHT = 8;
    parameter H_START = 0;
    parameter V_START = 0;
    parameter H_MAX = 640; // Ancho de la pantalla
    parameter V_MAX = 480; // Alto de la pantalla
    
    // Definir el período de reloj
    parameter CLK_PERIOD = 10;

    // Señales de entrada
    logic clk;
    logic [9:0] x, y;

    // Señales de salida
    logic [7:0] r, g, b;

    // Instancia del módulo bajo prueba
    videoGen dut (
        .clk(clk),
        .x(x),
        .y(y),
        .r(r),
        .g(g),
        .b(b)
    );

    // Generar el reloj
    always #CLK_PERIOD clk = ~clk;

    // Inicializar las entradas
    initial begin
        clk = 0;
        x = 0;
        y = 0;

        // Esperar un ciclo de reloj antes de la primera lectura
        #CLK_PERIOD;

        // Iniciar la simulación con valores de coordenadas x e y que pasen por toda la pantalla
        for (int i = 0; i < 1000; i = i + 1) begin
            // Actualizar las coordenadas x e y
            x = i % H_MAX;
            y = i / H_MAX;

            // Esperar un ciclo de reloj
            #CLK_PERIOD;
        end

        // Terminar la simulación
        $finish;
    end

endmodule
