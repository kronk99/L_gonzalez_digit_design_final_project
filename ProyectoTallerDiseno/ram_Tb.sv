module ram_Tb(); //testbench con forceo de señales, como en el tutorial del
//profe, con el fin de verificar que la informacion si se guarda
logic clk ,rst ,wren1,wren2;
logic [7:0] dataA,dataB,outA,outB;
logic [10:0] dirA,dirB;
RAMtree ram(dirA,dirB,clk,dataA,dataB,wren1,wren2,outA,outB);
endmodule