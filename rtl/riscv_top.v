module riscv_top (
    input clk,
    input reset,
    output [31:0] debug_out
);

    riscv_core core (
        .clk(clk),
        .reset(reset),
        .debug_out(debug_out)
    );

endmodule
