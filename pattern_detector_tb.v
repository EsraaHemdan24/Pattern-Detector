`timescale 1ns/100ps
module pattern_detector_tb;

reg clk_tb =0;
parameter clk_period = 2;
always #(clk_period/2) clk_tb = ~clk_tb;

reg [19:0] x = 20'b00011010111101011011;
integer y;

reg rst_tb , stream_in_tb ;
wire pattern_found_tb;
pattern_detector dut (
    .clk(clk_tb),
    .rst(rst_tb),
    .stream_in(stream_in_tb),
    .pattern_found(pattern_found_tb)
);

initial begin
    
    rst_tb = 0 ;

    for( y=19 ; y>-1 ; y=y-1 ) begin
        stream_in_tb = x[y];
        #(clk_period);
    end

    #(clk_period) $finish;
end

endmodule
