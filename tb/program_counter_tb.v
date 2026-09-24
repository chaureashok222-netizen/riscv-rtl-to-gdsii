`timescale 1ns/1ps

module program_counter_tb;

    reg clk;
    reg reset;
    reg pc_write;

    reg [31:0] next_pc;

    wire [31:0] pc;

    program_counter uut (
        .clk(clk),
        .reset(reset),
        .pc_write(pc_write),
        .next_pc(next_pc),
        .pc(pc)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("program_counter.vcd");
        $dumpvars(0, program_counter_tb);

        clk = 0;
        reset = 1;
        pc_write = 0;
        next_pc = 32'd0;

        // Reset
        #10;
        reset = 0;

        // PC = 4
        pc_write = 1;
        next_pc = 32'd4;
        #10;

        // PC = 8
        next_pc = 32'd8;
        #10;

        // PC = 12
        next_pc = 32'd12;
        #10;

        // PC = 16
        next_pc = 32'd16;
        #10;

        $display("Final PC = %d", pc);

        $finish;

    end

endmodule
