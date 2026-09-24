`timescale 1ns/1ps

module control_unit_tb;

    reg [6:0] opcode;

    wire reg_write;
    wire mem_read;
    wire mem_write;
    wire branch;
    wire alu_src;
    wire mem_to_reg;

    control_unit uut (
        .opcode(opcode),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg)
    );

    initial begin

        $dumpfile("control_unit.vcd");
        $dumpvars(0, control_unit_tb);

        // R-type
        opcode = 7'b0110011;
        #10;
        $display("R-TYPE: RegWrite=%b MemRead=%b MemWrite=%b Branch=%b ALUSrc=%b MemToReg=%b",
                 reg_write, mem_read, mem_write, branch, alu_src, mem_to_reg);

        // LW
        opcode = 7'b0000011;
        #10;
        $display("LW:     RegWrite=%b MemRead=%b MemWrite=%b Branch=%b ALUSrc=%b MemToReg=%b",
                 reg_write, mem_read, mem_write, branch, alu_src, mem_to_reg);

        // SW
        opcode = 7'b0100011;
        #10;
        $display("SW:     RegWrite=%b MemRead=%b MemWrite=%b Branch=%b ALUSrc=%b MemToReg=%b",
                 reg_write, mem_read, mem_write, branch, alu_src, mem_to_reg);

        // BEQ
        opcode = 7'b1100011;
        #10;
        $display("BEQ:    RegWrite=%b MemRead=%b MemWrite=%b Branch=%b ALUSrc=%b MemToReg=%b",
                 reg_write, mem_read, mem_write, branch, alu_src, mem_to_reg);

        $finish;

    end

endmodule
