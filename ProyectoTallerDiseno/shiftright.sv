module shiftright #(parameter N = 8)
    (
     input logic [N-1:0] a,
     input logic [N-1:0] b,
     output logic [N-1:0] result
    );

    // For intermediate results
    logic [N-1:0] temp_result;

    always_comb begin
        temp_result = a >> 1'b1;
    end

    // Assign result
    assign result = temp_result;

endmodule