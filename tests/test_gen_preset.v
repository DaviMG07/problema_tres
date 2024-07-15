module test_gen_preset(
    input clock,
    input [5:0] preset,
    input button,
    output [5:0] leds
);

wire [5:0] reset, enabled_preset, enabled_reset;

not(reset[0], preset[0]);
not(reset[1], preset[1]);
not(reset[2], preset[2]);
not(reset[3], preset[3]);
not(reset[4], preset[4]);
not(reset[5], preset[5]);

and(enabled_preset[0], button, preset[0]);
and(enabled_preset[1], button, preset[1]);
and(enabled_preset[2], button, preset[2]);
and(enabled_preset[3], button, preset[3]);
and(enabled_preset[4], button, preset[4]);
and(enabled_preset[5], button, preset[5]);

and(enabled_reset[0], button, reset[0]);
and(enabled_reset[1], button, reset[1]);
and(enabled_reset[2], button, reset[2]);
and(enabled_reset[3], button, reset[3]);
and(enabled_reset[4], button, reset[4]);
and(enabled_reset[5], button, reset[5]);

counter_30_0(clock, enabled_preset, enabled_reset, leds[5:4], leds[3:0]);

endmodule
