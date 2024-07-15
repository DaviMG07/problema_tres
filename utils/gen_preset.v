module gen_preset(
    input pulse,
    input [1:0] state,
    input specific,
    output [5:0] preset,
    output [5:0] reset
);

/*

| pulse | state | specific | preset |
|   1   |   E   |     -    |   30   |
|   1   |   A   |     0    |   15   |
|   1   |   A   |     1    |   22   |
|   1   |   G   |     0    |   30   |
|   0   |   G   |     1    |    -   |
|   1   |   L   |     -    |    5   |

*/

// x0 = st1 · st0'
and(x[0], state[1], !state[0]);
// x1 = sp' · st1'
and(x[1], !specific, !state[1]);
// x2 = st1' · st0
and(x[2], !state[1], state[0]);

// prst0 = p · st0 · (st1 + x1)
or(aux[0], state[1], x[1]);
and(preset[0], pulse, state[0], aux[0]);

// prst1 = sp · p · x2
and(preset[1], specific, pulse, x[2]);

// prst2 = prst0
assign preset[2] = preset[0];

// prst3 = 0
assign preset[3] = 0;

// prst4 = p · [(sp · st0') + (sp' . x0) + x1]
and(aux[1], specific, !state[0]);
and(aux[2], !specific, x[0]);
or(aux[3], x[1], aux[1], aux[2]);
and(preset[4], pulse, aux[3]);

// prst5 = p · [x0 + (x2 · sp)]
and(aux[4], x[2], specific);
or(aux[5], aux[4], x[0]);
and(preset[5], pulse, aux[5]);

endmodule
