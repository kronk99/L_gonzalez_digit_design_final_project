`timescale 1ns / 1ps

module ram_testbench;

    // Definir señales de prueba
    logic clk;
    logic [9:0] address;
    logic [7:0] data_in;
    logic write_enable;
    logic [7:0] data_out;

    // Instancia de la memoria RAM
    ram dut (
        .clock(clk),
        .address(address),
        .data(data_in),
        .wren(write_enable),
        .q(data_out)
    );

    // Generar el reloj
    always #5 clk = ~clk;

    // Inicializar las entradas
    initial begin
        clk = 0;
        address = 0;
        data_in = 0;
        write_enable = 0;

        // Esperar un ciclo de reloj antes de empezar
        #5;

        // Leer datos de la memoria RAM y mostrarlos
        for (int i = 0; i < 1024; i = i + 1) begin
            address = i;
            write_enable = 0;

            // Esperar un ciclo de reloj
            #10;

            // Mostrar los datos leídos
            $display("Address %d: Data %h", address, data_out);
        end

        // Terminar la simulación
        $finish;
    end

endmodule
