module decoder_extra(
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
b = 1
c = st1 XNOR st0
d = a
e = st1 + st0
f = a
g = 0
dot = 1

*/

// a
and(seg[0], state[1], state[0]);

// b
assign seg[1] = 1;

// c
xnor(seg[2], state[1], state[0]);

// d
assign seg[3] = seg[0];

// e
or(seg[4], state[1], state[0]);

// f
assign seg[5] = seg[0];

// g
assign seg[6] = 0;

// dot
assign seg[7] = 1;

endmodule
