module divider_by_five(
    input clock,
    output clock_out
);

wire [2:0] aux;

flip_flop_T(!clock, 1, , clock_out, aux[0]);
flip_flop_T(!aux[0], 1, , clock_out, aux[1]);
flip_flop_T(!aux[1], 1, , clock_out, aux[2]);

and(clock_out, aux[0], !aux[1], aux[2]);

endmodule
