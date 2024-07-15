module driver_display(
    input display_clock,
    input [7:0] digitA,
    input [7:0] digitB,
    input [7:0] digitC,
    input [7:0] digitD,
    output [3:0] digits,
    output [7:0] segments
);

wire [1:0] count;

counter_3_0(display_clock, , , count);

demux_1_2_4(1, count, digits);

mux_32_2_8(digitA, digitB, digitC, digitD, count, segments);

endmodule
