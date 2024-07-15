module decoder_units(
    input [3:0] units,
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

a = Q3'·Q1'·(Q2 XOR Q0)
b = Q3'·Q2·(Q1 XOR Q0)
c = Q3'·Q2'·Q1·Q0'
d = Q3'·[Q0·(Q2 XNOR Q1) + Q2·Q1'·Q0']
e = Q3'·(Q2·Q1' + Q1·Q0) + Q2'·Q1'·Q0
f = Q3'·[Q1·Q0 + Q2'·(Q1 XOR Q0)]
g = Q3'·[Q2'·Q1' + Q2·Q1·Q0]
dot = 0

*/

// a
xor(aux[0], units[2], units[0]);
and(segments[0], !units[3], !units[1], aux[0]);

// b
xor(aux[1], units[1], units[0]);
and(segments[1], !units[3], units[2], aux[1]);

// c
and(segments[2], !units[3], !units[2], units[1], !units[0]);

// d
xnor(aux[2], units[2], units[1]);
and(aux[3], units[0], aux[2]);
and(aux[4], units[2], !units[1], !units[0]);
or(aux[5], aux[3], aux[4]);
and(segments[3], !units[3], aux[5]);

// e
and(aux[6], units[2], !units[1]);
and(aux[7], units[1], units[0]);
or(aux[8], aux[6], aux[7]);
and(aux[9], !units[3], aux[8]);
and(aux[10], !units[2], !units[1], units[0]);
or(segments[4], aux[9], aux[10]);

// f
and(aux[11], !units[2], aux[1]);
and(aux[12], units[1], units[0]);
or(aux[13], aux[11], aux[12]);
and(segments[5], !units[3], aux[13]);

//g
and(aux[14], !units[2], !units[1]);
and(aux[15], units[2], units[1], units[0]);
or(aux[16], aux[14], aux[15]);
and(segments[6], !units[3], aux[16]);

assign segments[7] = 0;

endmodule
