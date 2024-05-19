`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2024 02:51:35 AM
// Design Name: 
// Module Name: alarm
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


module alarm(input clk,en,rst,output [5:0] minutes, output [4:0] hours, input hr,input min, input updown); // min was 6:0
    binaryCounter #(6,60) mins (clk, min,rst,updown, minutes); // this was 7,60
    binaryCounter #(5,24) hrs (clk, hr, rst,updown, hours);
endmodule
