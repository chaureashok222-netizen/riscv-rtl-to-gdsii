module instruction_memory (
    input  [31:0] address,
    output reg [31:0] instruction
);

    reg [31:0] memory [0:31];

    integer i;

    initial begin

        // Initialize memory with NOP
        for (i = 0; i < 32; i = i + 1)
            memory[i] = 32'h00000013;

        // ADDI x1, x0, 10
        memory[0] = 32'h00A00093;

        // ADDI x2, x0, 20
        memory[1] = 32'h01400113;

        // ADD x3, x1, x2
        memory[2] = 32'h002081B3;

        // SW x3, 0(x0)
        memory[3] = 32'h00302023;

        // LW x4, 0(x0)
        memory[4] = 32'h00002203;

    end

    always @(*) begin

        if (address[31:2] < 32)
            instruction = memory[address[31:2]];
        else
            instruction = 32'h00000013;

    end

endmodule
