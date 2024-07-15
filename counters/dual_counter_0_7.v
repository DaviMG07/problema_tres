module dual_counter_0_7(
    input clock,
    input direction,
    input [2:0] preset,
    input [2:0] reset,
    output [2:0] count
);

wire [1:0] aux;
wire [2:0] T;

flip_flop_T(clock, T[0], preset[0], reset[0], count[0]);
flip_flop_T(clock, T[1], preset[1], reset[1], count[1]);
flip_flop_T(clock, T[2], preset[2], reset[2], count[2]);

assign T[0] = 1;

mux_2_1_1(count[0], !count[0], direction, aux[0]);
mux_2_1_1(count[1], !count[1], direction, aux[1]);

and(T[1], aux[0], T[0]);
and(T[2], aux[1], T[1]);

endmodule
