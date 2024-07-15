module divider_by_two(
    input clock,
    output clock_out
);

flip_flop_D(clock, 1, , , clock_out);

endmodule
