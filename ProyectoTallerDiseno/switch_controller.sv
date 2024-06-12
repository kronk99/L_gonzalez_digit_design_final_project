module switch_controller (
    input logic clk,
    input logic [1:0] switches, // switches for data
    input logic write_enable_switch, // Additional switch for write enable
    output logic [7:0] ram_data,
    output logic ram_we,
    output logic [9:0] ram_addr
);
    assign ram_addr = 10'd562; // Fixed address 562
    assign ram_data = switches; // Data from switches
    assign ram_we = write_enable_switch; // Write enable controlled by the dedicated switch
endmodule