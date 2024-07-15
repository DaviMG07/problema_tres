module decoder_dozens(
    input [1:0] dozens,
    output [7:0] segments
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

a = Q1' · Q0
b = 0
c = Q1 · Q0'
d = a
e = Q0
f = e + c
g = Q1'
dot = 0

*/

and(segments[0], !dozens[1], dozens[0]);

assign segments[1] = 0;

and(segments[2], dozens[1], !dozens[0]);

assign segments[3] = segments[0];

assign segments[4] = dozens[0];

or(segments[5], segments[4], segments[2]);

not(segments[6], dozens[1]);

assign segments[7] = 0;

endmodule
