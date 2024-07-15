/*
module all_states(
    input clock,
    input [1:0] irrigation_type,
    input time_over,
    output [1:0] state
);

flip_flop_D(clock, D[0], , , state[0]);
flip_flop_D(clock, D[1], , , state[1]);

// St1* = R0' · [R1 · St1' + R1 · (St1 XOR St0)]
xor(aux[0], state[1], state[0]);
and(aux[1], !irrigation_type[0], !irrigation_type[1], aux[0]);
and(aux[2], !state[1], !state[0], irrigation_type[0]);
or(aux[6], aux[2], aux[1]);
and(D[0], aux[6], time_over);

// St0* = St1' · St0' · R0 + R1' · R0' (St1 XOR St0)
and(aux[3], irrigation_type[1], aux[0]);
and(aux[4], irrigation_type[1], !state[1]);
or(aux[5], aux[3], aux[4]);
and(D[1], !irrigation_type[0], aux[5], time_over);

endmodule
*/
/*
module all_states(
    input clock,
    input [1:0] R,
    input time_over,
    output [1:0] state
);



| state | irrigation | time_over | state* |
|   E   |     A      |     1     |    A   |
|   E   |     G      |     1     |    G   |
|   E   |     S      |     1     |    A   |
|   E   |     N      |     1     |    E   |
|   A   |     S      |     1     |    G   |
|   A   |     -      |     1     |    L   |
|   G   |     -      |     1     |    L   |
|   L   |     -      |     1     |    E   |



wire [5:0] aux;

flip_flop_D(clock, D[0], , , state[0]);
flip_flop_D(clock, D[1], , , state[1]);

// St1 XOR St0
xor(aux[0], state[0], state[1]);
// St1 XOR T
xor(aux[1], state[1], time_over);
// G · St0 · (St1 XOR T)
and(aux[2], !R[0], R[1], aux[1]);
// T · (St1 XOR St0)
and(aux[3], time_over, aux[0]);
// G · St0 · (St1 XOR T) + T · (St0 XOR St1)
or(D[1], aux[2], aux[3]);

// E{enchimento} · R0
and(aux[4], !state[0], !state[1], R[0]);
// E{enchimento} · R0 + (St1 XOR St0)
or(aux[5], aux[4], aux[0]);
// T[E{enchimento} · R0 + (St1 XOR St0)]
and(D[0], aux[5], time_over);

endmodule
*/

/*
| time_over | st0 | st1 | sprinkler | _drip | _specific | s1* | s0* |
|     1     |  0  |  0  |     0     |   0   |     -     |  0  |  0  |
|     1     |  0  |  0  |     1     |   -   |     0     |  0  |  1  |
|     1     |  0  |  0  |     1     |   -   |     1     |  0  |  1  |
|     1     |  0  |  0  |     -     |   1   |     -     |  1  |  0  |
|     1     |  0  |  1  |     -     |   -   |     1     |  1  |  0  |
|     1     |  0  |  1  |     -     |   -   |     -     |  1  |  1  |
|     1     |  1  |  0  |     -     |   -   |     -     |  1  |  1  |
|     1     |  1  |  1  |     -     |   -   |     -     |  0  |  0  |
*/

module all_states(
    input clock,
    input sprinkler,
    input drip,
    input specific,
    input time_over,
    output [1:0] state
);

wire [9:0] aux;
wire [1:0] D;

flip_flop_D(clock, D[0], , , state[0]);
flip_flop_D(clock, D[1], , , state[1]);

and(aux[0], state[1], !state[0]);

// D0 = T · [s1' · (s0' · A + s0 · sp') + s1 · s0']
and(aux[1], !state[0], sprinkler);
and(aux[2], state[0], !specific);
or(aux[3], aux[1], aux[2]);
and(aux[4], !state[1], aux[3]);
or(aux[5], aux[0], aux[4]);
and(D[0], time_over, aux[5]);

// D1 = T · [s1' · (s0' · sp' · G + s0) + s1 · s0']
and(aux[6], !state[0], !specific, drip);
or(aux[7], aux[6], state[0]);
and(aux[8], aux[7], !state[1]);
or(aux[9], aux[8], aux[0]);
and(D[1], time_over, aux[9]);

endmodule
