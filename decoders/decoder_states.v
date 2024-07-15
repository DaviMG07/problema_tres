module decoder_states(
    input [1:0] state,
    output [7:0] seg
);

/*
segments[0] = a
segments[1] = b
segments[2] = c
segments[3] = d
segments[4] = e
segments[5] = f
segments[6] = g
segments[7] = dot

a = st1 · st0
b = (st1' · st0)' = st1 + st0'
c = st1 XNOR st0
d = b'
e = 0
f = 0
g = st1
dot = 0

*/

// a
and(seg[0], state[1], state[0]);

// b
or(seg[1], state[1], !state[0]);

// c
xnor(seg[2], state[1], state[0]);

// d
not(seg[3], !seg[1]);

// e
assign seg[4] = 0;

// f
assign seg[5] = 0;

// g
assign seg[6] = state[1];

// dot
assign seg[7] = 0;

endmodule
