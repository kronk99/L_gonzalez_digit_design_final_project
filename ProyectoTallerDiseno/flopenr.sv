module flopenr #(parameter WIDTH = 8)
(input logic clk, reset, EN,
input logic [WIDTH-1:0] D,
output logic [WIDTH-1:0] Q);
always_ff @(posedge clk, posedge reset)
	if (reset) Q <= 0;
	else if (EN) Q <= D;
endmodule