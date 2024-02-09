`include "UART_rx.sv"
`include "UART_tx.sv"

module uart_top
#(
parameter clk_freq = 1000000,
parameter baud_rate = 9600
)
(
  input clk,rst, 
  input rx,
  input [7:0] dintx,
  input send,
  output tx, 
  output [7:0] doutrx,
  output donetx,
  output donerx
    );
    
UART_tx 
#(clk_freq, baud_rate) 
utx   
(.clk(clk), .rst(rst), .send(send), .tx_data(dintx), .tx(tx), .donetx(donetx));   

UART_rx 
#(clk_freq, baud_rate)
rtx
(.clk(clk), .rst(rst), .rx(rx), .done(donerx), .rxdata(doutrx));    
    
    
endmodule