module sumador#(parameter BITS= 4)(input logic [BITS-1:0]num1,num2 output logic
[BITS-1:0]Resul,Cout); //pag 218 del libro sale el ejemplo en system verilog para parametrizar
//en los testbench  
logic a,b,Cin,Cout,s;
sumador1bit misumador(.a(a),.b(b),.Cin(Cin),.Cout(Cout),.s(s));
for(i=0;i<BITS-1;i=i+1)begin: forloop
assign a= num1[i];
assign b= num2[i];

//buscar el generate para crear n sumadores de 1 bit
endmodule 