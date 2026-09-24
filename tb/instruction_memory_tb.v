`timescale 1ns/1ps

module instruction_memory_tb;

    reg [31:0] address;

    wire [31:0] instruction;

    instruction_memory uut (
        .address(address),
        .instruction(instruction)
    );

    initial begin

        $dumpfile("instruction_memory.vcd");
        $dumpvars(0, instruction_memory_tb);

        // Address 0
        address = 32'd0;
        #10;
        $display("Address = %d, Instruction = %h",
                 address, instruction);

        // Address 4
        address = 32'd4;
        #10;
        $display("Address = %d, Instruction = %h",
                 address, instruction);

        // Address 8
        address = 32'd8;
        #10;
        $display("Address = %d, Instruction = %h",
                 address, instruction);

        // Address 12
        address = 32'd12;
        #10;
        $display("Address = %d, Instruction = %h",
                 address, instruction);

        // Address 16
        address = 32'd16;
        #10;
        $display("Address = %d, Instruction = %h",
                 address, instruction);

        $finish;

    end

endmodule
