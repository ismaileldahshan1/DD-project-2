`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2024 09:28:12 AM
// Design Name: 
// Module Name: hrsmin
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


module hrsmin(input clk,en,rst,output [5:0] minutes, output [4:0] hours, output [5:0] seconds, input hr,input min, input updown); // this was [6:0]
wire clkout, rest, enhr, enmins;
assign rest = (minutes == 59 & hours == 23 & seconds == 59);
binaryCounter #(6,60) secs (clk, en, rst | rest, updown, seconds);
assign enmins = en ? seconds == 59 : min;
binaryCounter #(6,60) mins (clk, enmins,rst | rest,updown, minutes);
assign enhr = en ? (seconds == 59 &&  minutes == 59) : hr;
binaryCounter #(5,24) hrs (clk,  enhr, rst | rest,updown, hours);
endmodule




/*module hrsmin(input clk,en,rst,output [6:0] minutes, output [4:0] hours, input hrmin, input adjust, input up, input down);
wire clkout, rest;
wire [6:0] seconds;
assign rest = (minutes == 59 & hours == 23 & seconds == 59);
binaryCounter #(7,60) secs (clk,rst | rest, en, seconds, 1'b0, 1'b0, 1'b0);
binaryCounter #(7,60) mins (clk, rst | rest, (seconds == 59), minutes, (adjust && (~hrmin)),up, down);
binaryCounter #(5,24) hrs (clk, rst | rest, (seconds == 59 &&  minutes == 59), hours, (adjust && hrmin),up, down);
endmodule*/