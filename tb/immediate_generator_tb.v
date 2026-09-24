`timescale 1ns/1ps

module immediate_generator_tb;

    reg [31:0] instruction;
    reg [6:0] opcode;

    wire [31:0] immediate;

    immediate_generator uut (
        .instruction(instruction),
        .opcode(opcode),
        .immediate(immediate)
    );

    initial begin

        $dumpfile("immediate_generator.vcd");
        $dumpvars(0, immediate_generator_tb);

        // I-type example
        // ADDI x1, x0, 10
        instruction = 32'h00A00093;
        opcode = 7'b0010011;

        #10;

        $display("I-TYPE Immediate = %d (0x%h)",
                 immediate, immediate);

        // S-type example
        // SW
        instruction = 32'h0020A023;
        opcode = 7'b0100011;

        #10;

        $display("S-TYPE Immediate = %d (0x%h)",
                 immediate, immediate);

        // B-type example
        // BEQ
        instruction = 32'h00208463;
        opcode = 7'b1100011;

        #10;

        $display("B-TYPE Immediate = %d (0x%h)",
                 immediate, immediate);

        $finish;

    end

endmodule
