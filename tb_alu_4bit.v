`timescale 1ns / 1ps

module alu_4bit (

    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire [2:0] alu_sel,

    output reg  [3:0] alu_out,

    output wire zero,
    output wire negative,
    output wire overflow

);


always @(*) begin

    case(alu_sel)

        // Addition
        3'b000:
            alu_out = a + b;


        // Subtraction
        3'b001:
            alu_out = a - b;


        // AND
        3'b010:
            alu_out = a & b;


        // OR
        3'b011:
            alu_out = a | b;


        // XOR
        3'b100:
            alu_out = a ^ b;


        // Shift left
        3'b101:
            alu_out = a << 1;


        // Shift right
        3'b110:
            alu_out = a >> 1;


        // Comparison
        3'b111:
            alu_out = (a < b) ? 4'b0001 : 4'b0000;


        default:
            alu_out = 4'b0000;

    endcase

end



// Status flags

assign zero = (alu_out == 4'b0000);


assign negative = alu_out[3];


// Overflow for signed addition/subtraction
assign overflow =
       ((alu_sel == 3'b000) &&
       (a[3] == b[3]) &&
       (alu_out[3] != a[3]))

       ||

       ((alu_sel == 3'b001) &&
       (a[3] != b[3]) &&
       (alu_out[3] != a[3]));



endmodule