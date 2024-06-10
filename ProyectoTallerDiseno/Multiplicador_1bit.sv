module Multiplicador_1bit #(parameter SHIFT=2, parameter TAMANO=2) 
(
	input logic Bit, 
	input logic [TAMANO-1:0] Array,
	output logic [2*TAMANO-2:0] Result
);
		
		
		int i;
		generate //el codigo de abajo va a hacer la multiplicacion a pata
			always@*
			for (i = 0; i < (2*TAMANO-1); i++) begin : loop
				
				if((i < SHIFT) || (i >= (TAMANO + SHIFT))) begin
					
					Result[i] = 1'b0; //le pone ceros en la posicion menos significativa para hacer el "shift
					//left
				end else begin
					Result[i] = Bit && Array[i-SHIFT]; //crea los pares de multiplicacion bit por bit
				end 
			end
		endgenerate
endmodule