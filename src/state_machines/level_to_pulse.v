module level_to_pulse(
    input clock,
    input level,
    output pulse
);

wire data, state;

flip_flop_D(clock, data, , , state);

and(data, level, !state);
and(pulse, level, state);

endmodule
