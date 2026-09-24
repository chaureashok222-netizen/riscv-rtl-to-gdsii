module riscv_core (
    input clk,
    input reset,
    output [31:0] debug_out
);

    // =====================================================
    // WIRES
    // =====================================================

    wire [31:0] pc;
    wire [31:0] next_pc;
    wire [31:0] instruction;

    wire [6:0] opcode;
    wire [4:0] rd;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [2:0] funct3;
    wire [6:0] funct7;

    wire reg_write;
    wire mem_read;
    wire mem_write;
    wire branch;
    wire alu_src;
    wire mem_to_reg;

    wire [31:0] immediate;

    wire [3:0] alu_ctrl;

    wire [31:0] read_data1;
    wire [31:0] read_data2;

    wire [31:0] alu_input2;
    wire [31:0] alu_result;
    wire zero;

    wire [31:0] memory_data;
    wire [31:0] write_back_data;

    // =====================================================
    // PROGRAM COUNTER
    // =====================================================

    assign next_pc = pc + 32'd4;

    program_counter PC (
        .clk(clk),
        .reset(reset),
        .pc_write(1'b1),
        .next_pc(next_pc),
        .pc(pc)
    );

    // =====================================================
    // INSTRUCTION MEMORY
    // =====================================================

    instruction_memory IMEM (
        .address(pc),
        .instruction(instruction)
    );

    // =====================================================
    // DECODER
    // =====================================================

    instruction_decoder DEC (
        .instruction(instruction),
        .opcode(opcode),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),
        .funct3(funct3),
        .funct7(funct7)
    );

    // =====================================================
    // CONTROL UNIT
    // =====================================================

    control_unit CU (
        .opcode(opcode),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg)
    );

    // =====================================================
    // IMMEDIATE GENERATOR
    // =====================================================

    immediate_generator IMM (
        .instruction(instruction),
        .opcode(opcode),
        .immediate(immediate)
    );

    // =====================================================
    // REGISTER FILE
    // =====================================================

    register_file RF (
        .clk(clk),
        .reset(reset),
        .reg_write(reg_write),
        .read_addr1(rs1),
        .read_addr2(rs2),
        .write_addr(rd),
        .write_data(write_back_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // =====================================================
    // ALU CONTROL
    // =====================================================

    alu_control ALUCTRL (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .alu_control(alu_ctrl)
    );

    // =====================================================
    // ALU INPUT MUX
    // =====================================================

    assign alu_input2 = (alu_src) ? immediate : read_data2;

    // =====================================================
    // ALU
    // =====================================================

    alu ALU (
        .a(read_data1),
        .b(alu_input2),
        .alu_control(alu_ctrl),
        .result(alu_result),
        .zero(zero)
    );

    // =====================================================
    // DATA MEMORY
    // =====================================================

    data_memory DMEM (
        .clk(clk),
        .reset(reset),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(alu_result),
        .write_data(read_data2),
        .read_data(memory_data)
    );

    // =====================================================
    // WRITE BACK MUX
    // =====================================================

    assign write_back_data =
            (mem_to_reg) ? memory_data : alu_result;

assign debug_out = pc ^ instruction ^ alu_result ^ memory_data ^ write_back_data;

endmodule
