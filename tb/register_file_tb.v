`timescale 1ns/1ps

module register_file_tb;

    reg clk;
    reg reset;
    reg reg_write;

    reg [4:0] read_addr1;
    reg [4:0] read_addr2;
    reg [4:0] write_addr;

    reg [31:0] write_data;

    wire [31:0] read_data1;
    wire [31:0] read_data2;

    register_file uut (
        .clk(clk),
        .reset(reset),
        .reg_write(reg_write),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .write_addr(write_addr),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("register_file.vcd");
        $dumpvars(0, register_file_tb);

        clk = 0;
        reset = 1;
        reg_write = 0;
        read_addr1 = 0;
        read_addr2 = 0;
        write_addr = 0;
        write_data = 0;

        #10;

        reset = 0;

        // Write 100 into x1
        reg_write = 1;
        write_addr = 5'd1;
        write_data = 32'd100;

        #10;

        // Write 200 into x2
        write_addr = 5'd2;
        write_data = 32'd200;

        #10;

        // Stop writing
        reg_write = 0;

        // Read x1 and x2
        read_addr1 = 5'd1;
        read_addr2 = 5'd2;

        #10;

        $display("x1 = %d", read_data1);
        $display("x2 = %d", read_data2);

        // Test x0
        read_addr1 = 5'd0;

        #10;

        $display("x0 = %d", read_data1);

        $finish;

    end

endmodule
