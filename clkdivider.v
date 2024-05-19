`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2024 09:06:09 AM
// Design Name: 
// Module Name: clkdivider
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



module clockDivider#(parameter n = 5000000) (input clk,rst, output reg clk_out);
reg [31:0] count;

always @ (posedge clk, posedge rst) begin
    if (rst == 1'b1) 
        count <= 32'b0;
    else if (count == n-1) 
        count <= 32'b0;
    else 
        count <= count + 1;
    end

always @ (posedge clk, posedge rst) begin
    if (rst) 
        clk_out <= 0;
    else if (count == n-1) 
        clk_out <= ~ clk_out;
    end
endmodule 
