module counter_9_0(
    input clock_in,
    input end_condition,
    input [3:0] preset,
    input [3:0] reset,
    output [3:0] count
);

wire clock;
wire [4:0] aux;
wire [3:0] T;

and(clock, clock_in, !end_condition);

flip_flop_T(clock, T[0], preset[0], reset[0], count[0]);
flip_flop_T(clock, T[1], preset[1], reset[1], count[1]);
flip_flop_T(clock, T[2], preset[2], reset[2], count[2]);
flip_flop_T(clock, T[3], preset[3], reset[3], count[3]);

assign T[0] = 1;

//T1 = C0' · [C' · (C3 XOR C2) + (C1 · C3')]
and(aux[0], count[1], !count[3]);
xor(aux[1], count[3], count[2]);
and(aux[2], !count[1], aux[1]);
or(aux[3], aux[2], aux[0]);
and(T[1], !count[0], aux[3]);

//T2 = C1'·C0' · (C3 XOR C2)
xor(aux[4], count[3], count[2]);
and(T[2], !count[1], !count[0], aux[4]);

//T3 = C2'·C1'·C0'
and(T[3], !count[2], !count[1], !count[0]);

endmodule
