module Multiplicador #(parameter BIT=4) (
		input logic [BIT-1:0] num1, 
		input logic [BIT-1:0] num2, 
		output logic [2*BIT-1:0] Result,
		output logic OFLOW
	);

	reg [2*BIT-2:0] Current_result [0:BIT]; //matriz de currents
	logic [2*BIT-2:0] Result_multiplic [0:BIT-1];
	reg [BIT:0] carrys;
	assign Current_result[0] = 0;
	assign carrys[0] = 1'b0;

	generate
		genvar i;

		for (i = 0; i < BIT; i++) begin : loop
			Multiplicador_1bit #(i, BIT) mimultiplicador (
				.Bit(num2[i]), 
				.Array(num1),
				.Result(Result_multiplic[i])
			);

			sumador #(2*BIT-1) misumador ( 
				.num1(Result_multiplic[i]),
				.num2(Current_result[i]),
				.Cin(carrys[i]),
				.Cout(carrys[i+1]),
				.Resul(Current_result[i+1])
			);
		end
	endgenerate

	always_comb begin
		Result = Current_result[BIT];
		OFLOW = Result > ((2**BIT)-1);
	end
endmodule