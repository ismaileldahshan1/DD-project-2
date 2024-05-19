`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2024 09:25:20 AM
// Design Name: 
// Module Name: UpDown
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module UpDown #(parameter n = 4, mod = 9) (input clk, en, load, inc, dec, 
input [n-1:0] loadin, output [n-1:0] count);
reg [n-1:0] count = 0;
always @ (posedge clk) begin
    if (rst)
        count <= 0;
    else if (load)
        count <= loadin;
    else if (en) begin
        if (inc && count < mod) 
            count <= count +1;
        else if (dec && count >= 0)
            count <= count - 1;
    end
end

endmodule
