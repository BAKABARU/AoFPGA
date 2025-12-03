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
    iotest inst(
        .clk(hz100),
        .txc(txclk),
        .txd(txdata)
    );

endmodule

module iotest
(
    input       logic clk,

    output      logic txc,
    output      logic [7:0] txd
);
    reg [7:0] offset;

    // initial
    // begin
    //     offset <= 0;
    // end

    assign txc = clk;

    always @(posedge clk) begin
        txd <= 65 + offset;
        offset <= (offset + 1) % 26;
    end
endmodule: iotest