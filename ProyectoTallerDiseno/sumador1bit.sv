module sumador1bit(input logic a, b, Cin,  output logic Cout, s);
assign Cout = (a & b)  | (a & Cin)  | (b & Cin);
assign s  = a ^ b ^ Cin; 
endmodule