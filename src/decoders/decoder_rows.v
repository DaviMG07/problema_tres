module decoder_rows(
    input blink,
    input [2:0] count,
    output [6:0] rows
);

/*

| blink | count |  rows   |
|   0   |   0   | ······· |
|   1   |   0   | ······• |
|   0   |   1   | ······• |
|   1   |   1   | ·····•• |
|   0   |   2   | ·····•• |
|   1   |   2   | ····••• |
|   0   |   3   | ····••• |
|   1   |   3   | ···•••• |
|   0   |   4   | ···•••• |
|   1   |   4   | ··••••• |
|   0   |   5   | ··••••• |
|   1   |   5   | ·•••••• |
|   0   |   6   | ·•••••• |
|   1   |   6   | ••••••• |
|   0   |   7   | ••••••• |
|   1   |   7   | ••••••• |
*/

/*
x0 = q2' · q1'
x1 = q2' · q1
x2 = q2 · q1'
x3 = q2 · q1

y0 = p · x0
y1 = p · x1
y2 = p · x2
y3 = p · x3

z0 = p' · x0
z1 = p' · x1
z2 = p' · x2
z3 = p' · x3
*/
wire [3:0] x, y, z;

and(x[0], !count[2], !count[1]);
and(x[1], !count[2], count[1]);
and(x[2], count[2], !count[1]);
and(x[3], count[2], count[1]);

and(y[0], blink, x[0]);
and(y[1], blink, x[1]);
and(y[2], blink, x[2]);
and(y[3], blink, x[3]);

and(z[0], !blink, x[0]);
and(z[1], !blink, x[1]);
and(z[2], !blink, x[2]);
and(z[3], !blink, x[3]);

// l0 = y0 · q0'
and(rows[0], y[0], !count[0]);

// l1 = x0 · (p + p' · q0')
and(aux[0], !blink, !count[0]);
or(aux[1], aux[0], blink);
and(rows[1], x[0], aux[1]);

// l2 = y0 + z0 + (y1 · q0')
and(aux[2], y[1], !count[0]);
or(rows[2], aux[2], y[0], z[0]);

// l3 = z0 + (p · q2') + (z1 · q0)
and(aux[3], blink, !count[2]);
and(aux[4], z[1], count[0]);
or(rows[3], aux[4], aux[3], z[0]);

// l4 = (y2 · q0') + q2'
and(aux[5], y[2], !count[0]);
or(rows[4], aux[5], !count[2]);

// l5 = (z2 · q0) + y2 + q2'
and(aux[6], z[2], count[0]);
or(rows[5], aux[6], y[2], !count[2]);

// l6 = (y3 · q0') + y2 + z2 + q2'
and(aux[7], y[3], !count[0]);
or(rows[6], aux[7], y[2], z[2], !count[2]);

endmodule
