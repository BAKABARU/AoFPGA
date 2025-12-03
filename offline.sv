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
    reg read_start;
    reg read_done;
    reg solve_start;
    reg solve_done;
    reg write_start;
    reg write_done;

    // Solution input
    reg [31:0] myInts [3:0];

    // Solution output
    reg [31:0] myOuts [3:0];

    read reader(
        .start(read_start),
        .complete(read_done),

        .clk(hz100),
        .rxdata(rxdata),

        .myInts(myInts),

        .rxclk(rxclk)
    );
    
    offline solver(

    );

    initial
    begin
        read_start <= 1;
    end

    always @(posedge hz100)
    begin
        if (read_done) begin
            solve_start <= 1;
        end else if (solve_done) begin
            write_start <= 1;
        end
    end


endmodule: top

module read
(
    input       start
    output      complete,

    input       logic clk,
    input       logic [7:0] rxdata,

    output      reg [31:0] myInts [3:0],
    
    output      logic rxclk
)
    reg [31:0] bytesRead;
    reg [31:0] currInt;
    reg [31:0] i;

    assign rxclk = clk;

    always @(posedge clk)
    begin
        if (complete || !start) continue;

        currInt[bytesRead * 8 + 7 : bytesRead * 8] <= rxdata;
        bytesRead <= bytesRead + 1;
        if (bytesRead >= 4) begin
            myInts[i] <= currInt;
            i <= i + 1;
            bytesRead = 0;

            if (i >= 4) complete <= 1;
        end
    end
endmodule: read

module offline
(
    input       start,
    output      complete,

    input       logic clk,

    input       reg [31:0] myInts [3:0],
    output      reg [31:0] myOuts [3:0],
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
endmodule: offline

module write
(
    input       start;
    output      complete;

    input       logic clk;

    input       reg [31:0] myOuts [3:0],

    output      logic txclk,
    output      logic [7:0] txdata
);
    reg [31:0] bytesWritten;
    reg [31:0] i;

    assign txclk = clk;

    always @(posedge clk)
    begin
        if (complete || !start) continue;

        // TODO
    end

endmodule