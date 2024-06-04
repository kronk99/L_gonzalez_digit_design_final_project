module regfile(input logic clk,
input logic we3,//enable para escribir a registro
input logic [3:0] ra1, ra2, wa3, //valores de entrada wa3 es r3.
input logic [31:0] wd3, r15,//wd3 bebe deel mux fuera del data memory
output logic [31:0] rd1, rd2);
logic [31:0] rf[14:0];//matriz de banco de registros ,registerfile
//son 3 puertos ra1,ra2,wa3 , esto permite realizar 3 instrucciones simultaneas a la vez (pipeline)
// three ported register file
// read two ports combinationally
// write third port on rising edge of clock
// register 15 reads PC + 8 instead, esto es lo del look ahead 
	always_ff @(posedge clk)
		if (we3) rf[wa3] <= wd3;c//si we3 est activo, se escribe lo que haya em wd3
		
	assign rd1 = (ra1 == 4'b1111) ? r15 : rf[ra1]; //valores de salida
	assign rd2 = (ra2 == 4'b1111) ? r15 : rf[ra2]; //valores de salida rd , si ra1 o ra2 es 1111 , el resultado es r15 del pc+8 , si no lee los
	//
	//registros
	//R15 es el registro que guarda el numero de instruccion 
endmodule
//este es el modulo register file, es cono un banco de registros para instruccciones temporales durante tiempo de ejecucion
//rf{i} es dicho banco de registros , es una matriz de registros 