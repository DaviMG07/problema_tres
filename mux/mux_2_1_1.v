module mux_2_1_1(
    input a,
    input b,
    input key,
    output x
);

wire [1:0] aux;

and(aux[0], key, a);
and(aux[1], !key, b);
or(x, aux[0], aux[1]);

endmodule
