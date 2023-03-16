module pattern_detector (
    input clk , rst , stream_in , 
    output reg pattern_found   
);

localparam state_reg_width = 3;
localparam [state_reg_width-1 : 0] s0 = 3'b000,
                                  s1 = 3'b001,
                                  s2 = 3'b010,
                                  s3 = 3'b011,
                                  s4 = 3'b100;

reg [state_reg_width-1 : 0] curr_state , next_state ;

always @(posedge clk ) begin
    if (rst) begin
        curr_state <= s0 ;
    end
    else begin
        curr_state <= next_state ;
    end
end

always @(*) begin

    //default vals
    pattern_found = 0;

    case (curr_state)

    s0 : begin
        next_state = (stream_in==1)? s1 : s0;
    end

    s1 : begin
        next_state = (stream_in==1)? s2 : s0;
    end

    s2 : begin
        next_state = (stream_in==1)? s2 : s3;
    end

    s3 : begin
        next_state = (stream_in==1)? s4 : s0;
    end

    s4 : begin
        next_state = (stream_in==1)? s2 : s0;
        if (stream_in==0) begin
            pattern_found = 1;
        end
        else begin
            pattern_found = 0;
        end
    end
    default : begin 
        next_state = s0;
        pattern_found = 0;
    end 

    endcase
end

endmodule //pattern_detector
