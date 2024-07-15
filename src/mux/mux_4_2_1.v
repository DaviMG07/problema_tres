module mux_4_2_1(
    input a,
    input b,
    input c,
    input d,
    input [1:0] key,
    output x
);

wire [1:0] aux;

mux_2_1_1(a, b, key[0], aux[0]);
mux_2_1_1(c, d, key[0], aux[1]);
mux_2_1_1(aux[0], aux[1], key[1], x);

endmodule
