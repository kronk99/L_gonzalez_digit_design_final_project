module inversor #(parameter BITS = 1) (
    input logic [N-1:0] in,
    output logic [N-1:0] out
);

    logic [N-1:0] intermediate_out;

    genvar i;
    generate
        for (i = 0; i < N; i++) begin
            nand #(2) nand_gate (
                .a(in[i]),
                .b(1'b1),
                .y(intermediate_out[i])
            );
        end
    endgenerate

    assign out = intermediate_out;

endmodule

module nand #(parameter WIDTH = 1) (
    input logic [WIDTH-1:0] a,
    input logic [WIDTH-1:0] b,
    output logic [WIDTH-1:0] y
);

    assign y = ~(a & b);

endmodule