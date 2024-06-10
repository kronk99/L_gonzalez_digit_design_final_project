`timescale 1ns / 1ps

module regfile_tb();

    // Parámetros
    parameter CLK_PERIOD = 10; // Periodo del reloj en ns
    
    // Señales
    logic clk;
    logic we3;
    logic [3:0] ra1, ra2, wa3;
    logic [31:0] wd3, r15;
    logic [31:0] rd1, rd2;
    
    // Instancia del módulo regfile
    regfile dut (
        .clk(clk),
        .we3(we3),
        .ra1(ra1),
        .ra2(ra2),
        .wa3(wa3),
        .wd3(wd3),
        .r15(r15),
        .rd1(rd1),
        .rd2(rd2)
    );
    
    // Estímulo
    initial begin
        // Inicialización de señales
        clk = 0;
        we3 = 0;
        ra1 = 0;
        ra2 = 0;
        wa3 = 0;
        wd3 = 0;
        r15 = 0;
        
        // Ciclo de reloj
        forever #((CLK_PERIOD)/2) clk = ~clk;
    end
    
    // Test case
    initial begin
        // Esperar un ciclo de reloj para que el módulo se inicialice
        #10;
        
        // Establecer valores para las entradas
        we3 = 1;
        wa3 = 3;
        wd3 = 32'h12345678;
        
        // Esperar un ciclo de reloj para que la escritura se complete
        #10;
        
        // Leer registros
        ra1 = 3;
        ra2 = 0;
        
        // Esperar un ciclo de reloj para que la lectura se complete
        #10;
        
        // Mostrar los valores leídos
        $display("rd1 = %h, rd2 = %h", rd1, rd2);
        
        // Finalizar simulación
        $finish;
    end

endmodule
