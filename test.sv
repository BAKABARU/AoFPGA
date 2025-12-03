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
    mux inst(
        .a(pb[0]),
        .b(pb[1]),
        .sel(pb[2]),

        .out(green)
    );

endmodule

module mux
(
    output      logic f,
    input       logic a, b, sel
);

    and         g1(f1, a, n_sel),
                g2(f2, b, sel);
    or          g3(f, f1, f2);
    not         g4(n_sel, sel);

endmodule: mux

module muxSim;
    logic   a, b, sel, n_sel, f1, f2, f;

    and #2  g1 (f1, a, n_sel),
            g2 (f2, b, sel);
    or #2   g3 (f, f1, f2);
    not     g4 (n_sel, sel);

    initial begin
        $monitor ($time,
        " a=%b b=%b sel=%b n_sel=%b f1=%b f2=%b f=%b",
        a, b, sel, n_sel, f1, f2, f);
        a = 0;
        b = 0;
        sel = 0;
        #12 a = 1;
        #6 $finish;
    end
endmodule: muxSim