`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2024 09:14:13 AM
// Design Name: 
// Module Name: ButtonDetector
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


module ButtonDetector(input clk, input rst, input A, output B);
wire clkout;
wire [1:0] outs;

debouncer D(clk, rst, A, outs[0]);
Synchroniser S(clk,outs[0], outs[1]);
RisingEdgeDetector R(clk, rst, outs[1], B);
endmodule
