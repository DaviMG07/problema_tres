module flip_flop_T(
    input clock,
    input toggle,
    input preset,
    input reset,
    output reg Q
);

always @(posedge clock or posedge preset or posedge reset) begin
    if (reset) begin
        Q <= 0;
    end
    else if (preset) begin
        Q <= 1;
    end
    else if (toggle) begin
        Q <= ~Q;
    end
end

endmodule
