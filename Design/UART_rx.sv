module UART_rx #(parameter clk_freq = 1000000, baud_rate = 9600) (
    input clk, rst, rx,
    output reg done,
    output reg [7:0] rxdata 
);

localparam clkcount = clk_freq / baud_rate;
integer count  = 0;
integer counts = 0;
reg slowclk = 0;

// Define states
localparam idle = 2'b00, start = 2'b01;
reg [1:0] state = idle; 

always @(posedge clk) begin
    if (rst) begin
        count <= 0;
        slowclk <= 0;
    end else if (count < clkcount/2 - 1) begin
        count <= count + 1;
    end else begin 
        count <= 0;
        slowclk <= ~slowclk;
    end
end

always @(posedge slowclk or posedge rst) begin
    if (rst) begin
        rxdata <= 8'b0;
        counts <= 0;
        done <= 1'b0;
        state <= idle;
    end else case(state)
        idle: begin 
            rxdata <= 8'b0;
            counts <= 0;
            done <= 1'b0;
            if(rx == 1'b0) state <= start;
        end
        start: begin
            if(counts < 8) begin
                rxdata <= {rx, rxdata[7:1]};
                counts <= counts + 1;
            end else begin
                done <= 1'b1;
                state <= idle;
                counts <= 0;
            end
        end
        default: state <= idle;
    endcase
end
    
endmodule
