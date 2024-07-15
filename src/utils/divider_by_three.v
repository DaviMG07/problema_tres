module divider_by_three(
    input clock,
    output clock_out
);

wire [1:0] aux;

flip_flop_T(!clock, 1, , clock_out, aux[0]);
flip_flop_T(!aux[0], 1, , clock_out, aux[1]);

and(clock_out, !aux[0], aux[1]);

endmodule
