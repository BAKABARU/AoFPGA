module adder
(
    input       a, b, cin,
    output      out
);

    wire w1;
    and(w1, a, b);
    and(out, w1, cin);

    // wire w1, w2, w3, w4;
    // xor(w1, a, b);
    // xor(sum, w1, cin);

    // and(w2, a, b);


endmodule: adder

module top (
  // I/O ports
    input   logic hz100, reset,
    input   logic [20:0] pb,
    output  logic [7:0] left, right,
            ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0,
    output  logic red, green, blue,

  // UART ports
    output  logic [7:0] txdata,
    input   logic [7:0] rxdata,
    output  logic txclk, rxclk,
    input   logic txready, rxready
);
    // Example:
    adder inst(
        .a(pb[0]),
        .b(pb[1]),
        .cin(pb[2]),

        .out(green)
    );

endmodule