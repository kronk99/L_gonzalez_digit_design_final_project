`timescale 1ns / 1ps

module Alu_tb;

  parameter CLOCK_PERIOD = 10; // Clock
  parameter Nbits = 4;
  // Signals
  logic [3:0] selector;
  logic [Nbits-1:0] first;
  logic [Nbits-1:0] second;
  logic [2*Nbits-1:0] resu;
  logic [3:0] flags;

  // Module instance 
  Calculator #(4) uut (
    .op_select(selector),
    .operand1(first),
    .operand2(second),
	 .banderas(flags),
    .resultado(resu)
  );

  // Clock generation
  logic clock = 0;
  always #CLOCK_PERIOD clock = ~clock;

  // Testbench stimulus
  initial begin
  
		//ADDER tests
		 selector = 4'b0000; //ADDER
       first = 4'b0001;
		 second = 4'b0001;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		  
		 selector = 4'b0000; //ADDER
       first = 4'b0101;
		 second = 4'b0011;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu); 
		 
		//SUBSTRACTOR tests
		
		 selector = 4'b0001;
       first = 4'b0011;
		 second = 4'b0001;
       #10; // Wait for 10 time units
       $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		 
		 selector = 4'b0001;
       first = 4'b0011;
		 second = 4'b0101;
       #10; // Wait for 10 time units
       $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		 
		 //MULTIPLICATOR tests
		  
		 selector = 4'b0010;
       first = 4'b0011;
		 second = 4'b0011;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		  
		  selector = 4'b0010;
       first = 4'b1111;
		 second = 4'b0011;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		  
		  //DIVISOR tests
		  
		 selector = 4'b0011;
       first = 4'b0011;
		 second = 4'b0011;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		  
		 selector = 4'b0011;
       first = 4'b1110;
		 second = 4'b0010;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		  
		   //MODULE tests
		  
		 selector = 4'b0100;
       first = 4'b0011;
		 second = 4'b0011;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		  
		  selector = 4'b0100;
       first = 4'b1111;
		 second = 4'b0010;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		  
		  //AND tests
		  
		 selector = 4'b0101;
       first = 4'b1011;
		 second = 4'b0011;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		  
		  selector = 4'b0101;
       first = 4'b1110;
		 second = 4'b0010;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		  
		  
		  //OR tests
		  
		 selector = 4'b0110;
       first = 4'b0011;
		 second = 4'b0011;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		  
		 selector = 4'b0110;
       first = 4'b1110;
		 second = 4'b0010;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		  
		  //XOR tests
		  
		 selector = 4'b0111;
       first = 4'b0011;
		 second = 4'b0011;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		  
		 selector = 4'b0111;
       first = 4'b1110;
		 second = 4'b0010;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		  
		  //SHIFT LEFT tests
		  
		 selector = 4'b1000;
       first = 4'b0011;
		 second = 4'b0011;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		  
		  selector = 4'b1000;
       first = 4'b1110;
		 second = 4'b0010;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		  
		   //SHIFT RIGHT tests
		  
		 selector = 4'b1001;
       first = 4'b0011;
		 second = 4'b0011;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		  
		  selector = 4'b1001;
       first = 4'b1110;
		 second = 4'b0010;
        #10; // Wait for 10 time units
        $display("Selector: %b, Input1: %b, Input2: %b, Output %b", selector,first, second, resu);
		  
		  
		  
		  
        $finish;
  end

endmodule