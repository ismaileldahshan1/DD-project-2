`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2024 09:04:08 AM
// Design Name: 
// Module Name: counter
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


module binaryCounter#(parameter x = 0, y = 0)(input clk, en, reset,input updown, output reg [x-1:0] count);
always @ (posedge clk, posedge reset) begin
if (reset)
    count<=0;
else if (en == 1) 
    if(updown)
        if(count < y-1)
             count <= count+1;
         else
             count <= 0;
    else
        if (count == 0) 
             count <= y-1;
        else
             count <= count-1;
else
    count <= count;
end
endmodule



/*module binaryCounter#(parameter x = 0, y = 0)(input clk, reset, en, output reg [x-1:0] count, input adjust, input up, input down);
always @ (posedge clk, posedge reset) begin
if (reset == 1) 
    count <= 0;
else if (en == 0) begin
    if (adjust == 1) begin
        if (up)
            if(count < y-1)
                count <= count+1;
            else
                count <= 0;
        if (down)
            if (count == 0) 
                count <= y-1;
            else
                count <= count-1;
      end 
end
else if (en == 1 && adjust == 0) begin
    if ( count == y-1)
        count <= 0;
    else
        count<=count+1;
end
else
    count <=count;
end
endmodule*/