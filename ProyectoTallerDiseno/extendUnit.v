module extendUnit(input logic [23:0] Instr,//instruccion a extender
input logic [1:0] ImmSrc, //selector de operacion  , hay 3 casos, el 00 extiende 8 bits sin signo
//si es 01 extiende 12 bits sin signo a la izquierda con 0
//si es 10 , , extiende con signoo 14 bits , con el nbit mas significativo, 1 o 0
output logic [31:0] ExtImm);
	always_comb
		case(ImmSrc)
// 8-bit unsigned immediate
			2'b00: ExtImm = {24'b0, Instr[7:0]};
// 12-bit unsigned immediate
			2'b01: ExtImm = {20'b0, Instr[11:0]};
// 24-bit two's complement shifted branch
			2'b10: ExtImm = {{6{Instr[23]}}, Instr[23:0], 2'b00};
			default: ExtImm = 32'bx; // undefined //caso donde se recibe un valor invalido 
	endcase
endmodule
//modulo de extension de bits , basicamente ll