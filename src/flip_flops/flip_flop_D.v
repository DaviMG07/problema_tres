module flip_flop_D(
    input clock,
    input data,
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
    else begin
        Q <= data;
    end
end

endmodule
