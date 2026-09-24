module control_unit (
    input  [6:0] opcode,

    output reg       reg_write,
    output reg       mem_read,
    output reg       mem_write,
    output reg       branch,
    output reg       alu_src,
    output reg       mem_to_reg
);

    always @(*) begin

        reg_write  = 1'b0;
        mem_read   = 1'b0;
        mem_write  = 1'b0;
        branch     = 1'b0;
        alu_src    = 1'b0;
        mem_to_reg = 1'b0;

        case (opcode)

            // R-type: ADD, SUB, AND, OR, XOR, SLT
            7'b0110011: begin
                reg_write = 1'b1;
                alu_src   = 1'b0;
                mem_to_reg = 1'b0;
            end

            // I-type: ADDI
            7'b0010011: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;
                mem_to_reg = 1'b0;
            end

            // Load Word
            7'b0000011: begin
                reg_write = 1'b1;
                mem_read  = 1'b1;
                alu_src   = 1'b1;
                mem_to_reg = 1'b1;
            end

            // Store Word
            7'b0100011: begin
                mem_write = 1'b1;
                alu_src   = 1'b1;
            end

            // Branch Equal
            7'b1100011: begin
                branch = 1'b1;
                alu_src = 1'b0;
            end

            default: begin
                reg_write  = 1'b0;
                mem_read   = 1'b0;
                mem_write  = 1'b0;
                branch     = 1'b0;
                alu_src    = 1'b0;
                mem_to_reg = 1'b0;
            end

        endcase

    end

endmodule
