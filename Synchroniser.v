`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2024 09:10:04 AM
// Design Name: 
// Module Name: Synchroniser
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


module Synchroniser(input clk, input SIG, output SIG1);
reg META;
reg SIG1;
always @ (posedge clk) begin
    META <= SIG;
    SIG1 <= META;
end
endmodule
