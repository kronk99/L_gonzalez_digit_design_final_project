module unidadCondicional(
    input logic clk, reset,
    input logic [3:0] Cond,
    input logic [3:0] ALUFlags,
    input logic [1:0] FlagW,
    input logic PCS, RegW, MemW,
    output logic PCSrc, RegWrite, MemWrite
);

    logic [1:0] FlagWrite;
    logic [3:0] Flags;
    logic CondEx;

    flopenr #(2) flagreg1 (
        .clk(clk),
        .reset(reset),
        .D(FlagWrite[1]),
        .EN(FlagW),
        .Q(Flags[3:2])
    );

    flopenr #(2) flagreg0 (
        .clk(clk),
        .reset(reset),
        .D(FlagWrite[0]),
        .EN(FlagW),
        .Q(Flags[1:0])
    );

    // write controls are conditional
    condcheck cc(
        .Cond(Cond),
        .Flags(Flags),
        .CondEx(CondEx)
    );

    assign FlagWrite = FlagW & {2{CondEx}};
    assign RegWrite = RegW & CondEx;
    assign MemWrite = MemW & CondEx;
    assign PCSrc = PCS & CondEx;

endmodule

