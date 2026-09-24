module alu_control (
    input  [6:0] opcode,
    input  [2:0] funct3,
    input  [6:0] funct7,

    output reg [3:0] alu_control
);

    always @(*) begin

        alu_control = 4'b0000;

        case (opcode)

            // R-type
            7'b0110011: begin

                case (funct3)

                    3'b000: begin
                        if (funct7 == 7'b0100000)
                            alu_control = 4'b0001; // SUB
                        else
                            alu_control = 4'b0000; // ADD
                    end

                    3'b111:
                        alu_control = 4'b0010; // AND

                    3'b110:
                        alu_control = 4'b0011; // OR

                    3'b100:
                        alu_control = 4'b0100; // XOR

                    3'b010:
                        alu_control = 4'b0101; // SLT

                    3'b001:
                        alu_control = 4'b0110; // SLL

                    3'b101:
                        alu_control = 4'b0111; // SRL

                    default:
                        alu_control = 4'b0000;

                endcase

            end

            // ADDI
            7'b0010011: begin

                case (funct3)

                    3'b000:
                        alu_control = 4'b0000; // ADDI

                    default:
                        alu_control = 4'b0000;

                endcase

            end

            // LW / SW
            7'b0000011,
            7'b0100011:
                alu_control = 4'b0000;

            // BEQ
            7'b1100011:
                alu_control = 4'b0001;

            default:
                alu_control = 4'b0000;

        endcase

    end

endmodule
