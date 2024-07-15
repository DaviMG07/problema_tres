module test_counter_30_0(
    input clock,
    output [5:0] leds
);

counter_30_0(clock, , , leds[5:4], leds[3:0]);

endmodule
