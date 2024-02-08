module UART_rx #(parametre clk_freq = 1000000, baud_rate = 9600) (
    input clk, rst, rx,
    output reg done,
    output reg [7:0] rxdata 
);

localparam clkcount = (clk_freq / baud_rate);

integer count  = 0;
integer counts = 0;

reg slowclk = 0;

enum bit[1:0] {idle = 2'b00, start = 2'b01} state; 

always @(posedge clk) begin

    if (count < clkcount/2)
        count <= count+1;
    else begin 
        count <= 0;
        slowclk <= ~slowclk;
    end

end
    
endmodule