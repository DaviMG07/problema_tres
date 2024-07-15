module counter_3_0(
    input clock_in,
    input end_condition,
    input [1:0] preset,
    input [1:0] reset,
    output [1:0] count
);

and(clock, clock_in, !end_condition);

flip_flop_T(clock, T[0], preset[0], reset[0], count[0]);
flip_flop_T(clock, T[1], preset[1], reset[1], count[1]);

assign T[0] = 1;
assign T[1] = !count[0];

endmodule
