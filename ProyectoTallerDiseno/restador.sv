module restador #(parameter BITS= 4) (input logic [BITS-1:0] num1, num2, output logic
Carryout, output logic [BITS-1:0] Result);
		logic [BITS-1:0] int_res;
		logic [BITS-1:0] int_resO;
		logic [BITS-1:0] int_resI;
		logic [BITS-1:0] num2C;
    // Se convierte en complemento 1 el numero negativo
    inversor #(BITS) inverter (
        .in(num2),
        .out(num2C)
    );
	 
	 sumador #(BITS) sumador1(.num1(num1), 
	 .num2(num2C),.Cin(0), .Cout(Carryout), 
	 .Resul(int_res)
	 );
	 
	 always_comb begin
		if (Carryout == 1) begin
			int_resO = 'b0;
			Result = int_res;
		end
		else begin
			int_resO = int_res;
			Result = int_resI;
			end
		end
	 inversor #(BITS) inverter2 (
			  .in(int_resO),
			  .out(int_resI)
		 );

endmodule