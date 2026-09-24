`timescale 1ns/1ps

module riscv_core_tb;

    reg clk;
    reg reset;

    // Instantiate RISC-V Core
    riscv_core uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock
    always #5 clk = ~clk;

    initial begin

        $dumpfile("riscv_core.vcd");
        $dumpvars(0, riscv_core_tb);

        // Initial values
        clk = 0;
        reset = 1;

        // Keep processor in reset
        #12;

        reset = 0;

        // Let processor execute instructions
        #60;

        // Display register values
        $display("--------------------------------");
        $display("RISC-V PROCESSOR RESULTS");
        $display("--------------------------------");

        $display("x1 = %d", uut.RF.registers[1]);
        $display("x2 = %d", uut.RF.registers[2]);
        $display("x3 = %d", uut.RF.registers[3]);
        $display("x4 = %d", uut.RF.registers[4]);

        $display("Memory[0] = %d", uut.DMEM.memory[0]);

        $display("--------------------------------");

        // Check results

        if (uut.RF.registers[1] == 10)
            $display("x1 TEST PASS");
        else
            $display("x1 TEST FAIL");

        if (uut.RF.registers[2] == 20)
            $display("x2 TEST PASS");
        else
            $display("x2 TEST FAIL");

        if (uut.RF.registers[3] == 30)
            $display("x3 TEST PASS");
        else
            $display("x3 TEST FAIL");

        if (uut.DMEM.memory[0] == 30)
            $display("STORE TEST PASS");
        else
            $display("STORE TEST FAIL");

        if (uut.RF.registers[4] == 30)
            $display("LOAD TEST PASS");
        else
            $display("LOAD TEST FAIL");

        $display("--------------------------------");

        $finish;

    end

endmodule
