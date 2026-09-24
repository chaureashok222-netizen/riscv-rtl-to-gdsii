`timescale 1ns/1ps

module data_memory_tb;

    reg clk;
    reg reset;

    reg mem_read;
    reg mem_write;

    reg [31:0] address;
    reg [31:0] write_data;

    wire [31:0] read_data;

    data_memory uut (
        .clk(clk),
        .reset(reset),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("data_memory.vcd");
        $dumpvars(0, data_memory_tb);

        clk = 0;
        reset = 1;

        mem_read = 0;
        mem_write = 0;

        address = 0;
        write_data = 0;

        // Reset
        #10;
        reset = 0;

        // Write 123 into address 4
        mem_write = 1;
        address = 32'd4;
        write_data = 32'd123;

        #10;

        // Stop writing
        mem_write = 0;

        // Read address 4
        mem_read = 1;
        address = 32'd4;

        #10;

        $display("Memory[4] = %d", read_data);

        // Write 456 into address 8
        mem_read = 0;
        mem_write = 1;
        address = 32'd8;
        write_data = 32'd456;

        #10;

        // Read address 8
        mem_write = 0;
        mem_read = 1;
        address = 32'd8;

        #10;

        $display("Memory[8] = %d", read_data);

        $finish;

    end

endmodule
