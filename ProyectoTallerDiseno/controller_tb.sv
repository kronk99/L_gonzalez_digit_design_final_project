module controller_tb();

    // Señales de entrada
    logic clk;
    logic reset;
    logic [31:0] Instr;

    logic [3:0] ALUFlags;

    // Señales de salida
    logic [1:0] RegSrc;
    logic RegWrite;
    logic [1:0] ImmSrc;
    logic ALUSrc;
    logic [1:0] ALUControl;
    logic MemWrite;
    logic MemtoReg;
    logic PCSrc;

    // Instancia del controllador
    controller controller_inst (
        .clk(clk),
        .reset(reset),
        .Instr(Instr[31:12]),
        .ALUFlags(ALUFlags),
        .RegSrc(RegSrc),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .ALUControl(ALUControl),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .PCSrc(PCSrc)
    );

    // Generación de estímulos
    initial begin
        // Simulación por 100 ciclos de reloj
        clk = 0;
        reset = 1;
        Instr = 32'b0;
        ALUFlags = 4'b0;
        #10 reset = 0; // desactivar el reset después de 10 unidades de tiempo
        #10;
		  //operacion de suma ADD R5 ,R6,R7
		  
		  Instr = 32'b11100000100001100101000000000111;
		  //numeros
		  //Instr = 32'b11100000000010100110000100000111;
		  //esta instrucicon deberia de tiramre pcscr 1, memtoreg 0 ,
		  //memwrite 0 , alucontrol (valor de suma) 
		  //aluscr = 0 ,inmscr = 0 , regWrite = 1
		  

        // Simular un ciclo de reloj
        #10 clk = 1;
        #10 clk = 0;

        // Finalizar la simulación después de 100 unidades de tiempo
        #90 $finish;
    end
endmodule
