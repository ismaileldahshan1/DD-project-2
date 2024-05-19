


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2024 10:08:38 AM
// Design Name: 
// Module Name: display
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

module display(input clk, en, rst, output reg [6:0] segs, output reg [3:0] anodeactive, input [4:0] x, output reg dp, output reg [3:0] LEDS, output reg buzz, output reg blink);
wire clkout,clkout2,cntrl,go_up,go_down,go_left,go_right;
reg dp;
wire [1:0] anodes;
reg [3:0] out;
wire [5:0] minutes; // this was 6:0
wire  [4:0] hours;
wire  [5:0] seconds;
wire [5:0] alarmminutes; // this was 6:0
wire  [4:0] alarmhours;
reg alarmhrs;
reg alarmmins;
reg clk2;
reg enable;
reg updown;
reg min;
reg hr;
reg alarm;
reg alarming = 1'b0;
reg buzz;
reg blink = 0;
clockDivider #(250000) C(clk, rst, clkout);
clockDivider #(50000000) C2(clk, rst, clkout2);
binaryCounter #(2,4) dispcounter(clkout, 1, rst,1, anodes);
ButtonDetector centre (clkout,rst,x[0],cntrl);
ButtonDetector left (clkout,rst,x[1],go_left);
ButtonDetector right (clkout,rst,x[2],go_right);
ButtonDetector up (clkout,rst,x[3],go_up);
ButtonDetector down (clkout,rst,x[4],go_down);
hrsmin clock (clk2, enable, rst, minutes, hours, seconds, hr,min,updown);
alarm alarms (clkout, alarm, rst, alarmminutes, alarmhours, alarmhrs, alarmmins, updown);

always @ (*) begin
    if (anodeactive == 4'b1011 && clkout2 && (state == clockkk || state == final))
        dp = 0;
    else
        dp = 1;
end

reg [5:0] state, nextstate;
parameter [5:0] clockkk = 5'b00000, timehr = 5'b00001, timemin = 5'b00010, alarmhr = 5'b00100, alarmmin = 5'b01000, final = 5'b10000;
always @ (state) begin
    case (state) 
        clockkk :begin     
        if (alarmhours == hours && alarmminutes == minutes && seconds == 0) begin
                    clk2 = clkout2;
                    nextstate = final;
                    LEDS = 4'b0000; 
                    enable = 1'b1;
                    alarm = 1'b0;
                    alarmhrs = 1'b0;
                    alarmmins = 1'b0;  
                    hr = 1'b0;
                    min = 1'b0;
                    updown = 1'b1;
                    buzz = clkout2;
                    blink = clkout2;
        end
        else if (cntrl) begin
                    clk2 = clkout;
                    nextstate = timehr;
                    LEDS = 4'b0001; 
                    enable = 1'b0;
                    alarm = 1'b0;
                    alarmhrs = 1'b0;
                    alarmmins = 1'b0;  
                    hr = 1'b0;
                    min = 1'b0;
                    updown = 1'bx;
                    buzz = 1'b0;
                    blink = 1'b1;
                 end else begin
                    clk2 = clkout2;
                    nextstate = clockkk;
                    LEDS = 4'b0000; 
                    enable = 1'b1;
                    alarm = 1'b0;
                    alarmhrs = 1'b0;
                    alarmmins = 1'b0;  
                    hr = 1'b0;
                    min = 1'b0;
                    updown = 1'b1;
                    buzz = 1'b0;
                    blink = 1'b0;
                 end
        end
        timehr :begin if (cntrl) begin
                    clk2 = clkout2; 
                    nextstate = clockkk;
                    LEDS = 4'b0000; 
                    enable = 1'b1;
                    alarm = 1'b0;
                    alarmhrs = 1'b0;
                    alarmmins = 1'b0;  
                    hr = 1'b0;
                    min = 1'b0;
                    updown = 1'b1;
                    buzz = 1'b0;
                    blink = 1'b0;
                end
                else if (go_left) begin
                    clk2 = clkout; 
                    nextstate = alarmmin;
                    LEDS = 4'b1000; 
                    enable = 1'b0;
                    alarm = 1'b1;
                    alarmhrs = 1'b0;
                    alarmmins = 1'b0;  
                    hr = 1'b0;
                    min = 1'b0;
                    updown = 1'bx;
                    buzz = 1'b0;
                    blink = 1'b1;
                end else if (go_right) begin
                    clk2 = clkout; 
                    nextstate = timemin;
                    LEDS = 4'b0010; 
                    enable = 1'b0;
                    alarm = 1'b0;
                    alarmhrs = 1'b0;
                    alarmmins = 1'b0;  
                    hr = 1'b0;
                    min = 1'b0;
                    updown = 1'bx;
                    buzz = 1'b0;
                    blink = 1'b1;
                end else if (go_up) begin
                    clk2 = clkout;
                    nextstate = timehr;
                    LEDS = 4'b0001; 
                    enable = 1'b0;
                    alarm = 1'b0;
                    alarmhrs = 1'b0;
                    alarmmins = 1'b0;  
                    hr = 1'b1;
                    min = 1'b0;
                    updown = 1'b1;
                    buzz = 1'b0;
                    blink = 1'b1;
                end else if (go_down) begin
                    clk2 = clkout;
                    nextstate = timehr;
                    LEDS = 4'b0001; 
                    enable = 1'b0;
                    alarm = 1'b0;
                    alarmhrs = 1'b0;
                    alarmmins = 1'b0;  
                    hr = 1'b1;
                    min = 1'b0;
                    updown = 1'b0;
                    buzz = 1'b0;
                    blink = 1'b1;
               end else begin
                   nextstate = timehr;
                   clk2 = clkout;
                    nextstate = timehr;
                    LEDS = 4'b0001; 
                    enable = 1'b0;
                    alarm = 1'b0;
                    alarmhrs = 1'b0;
                    alarmmins = 1'b0;  
                    hr = 1'b0;
                    min = 1'b0;
                    updown = 1'bx;
                    buzz = 1'b0;
                    blink = 1'b1;
               end
           end
           timemin: begin if (cntrl) begin
                        clk2 = clkout2;
                        nextstate = clockkk;
                        LEDS = 4'b0000; 
                        enable = 1'b1;
                        alarm = 1'b0;
                        alarmhrs = 1'b0;
                        alarmmins = 1'b0;  
                        hr = 1'b0;
                        min = 1'b0;
                        updown = 1'b1;
                        buzz = 1'b0;
                        blink = 1'b0;
                    end
                    else if (go_left) begin
                     clk2 = clkout;
                        nextstate = timehr;
                        LEDS = 4'b0001; 
                        enable = 1'b0;
                        alarm = 1'b0;
                        alarmhrs = 1'b0;
                        alarmmins = 1'b0;  
                        hr = 1'b0;
                        min = 1'b0;
                        updown = 1'bx;
                        buzz = 1'b0;
                        blink = 1'b1;
                    end else if (go_right) begin
                    clk2 = clkout;
                        nextstate = alarmhr;
                        LEDS = 4'b0100; 
                        enable = 1'b0;
                        alarm = 1'b1;
                        alarmhrs = 1'b0;
                        alarmmins = 1'b0;  
                        hr = 1'b0;
                        min = 1'b0;
                        updown = 1'bx;
                        buzz = 1'b0;
                        blink = 1'b1;
                    end else if (go_up) begin
                    clk2 = clkout;
                        nextstate = timemin;
                        LEDS = 4'b0010; 
                        enable = 1'b0;
                        alarm = 1'b0;
                        alarmhrs = 1'b0;
                        alarmmins = 1'b0;  
                        hr = 1'b0;
                        min = 1'b1;
                        updown = 1'b1;
                        buzz = 1'b0;
                        blink = 1'b1;
                    end else if (go_down) begin
                    clk2 = clkout;
                        nextstate = timemin;
                        LEDS = 4'b0010; 
                        enable = 1'b0;
                        alarm = 1'b0;
                        alarmhrs = 1'b0;
                        alarmmins = 1'b0;  
                        hr = 1'b0;
                        min = 1'b1;
                        updown = 1'b0;
                        buzz = 1'b0;
                        blink = 1'b1;
                    end else begin
                    clk2 = clkout;
                        nextstate = timemin;
                        LEDS = 4'b0010; 
                        enable = 1'b0;
                        alarm = 1'b0;
                        alarmhrs = 1'b0;
                        alarmmins = 1'b0;  
                        hr = 1'b0;
                        min = 1'b0;
                        updown = 1'b0;
                        buzz = 1'b0;
                        blink = 1'b1;
                    end
               end
               alarmhr: begin  if (cntrl) begin
               clk2 = clkout2; 
                            nextstate = clockkk;
                            LEDS = 4'b0000; 
                            enable = 1'b1;
                            alarm = 1'b0;
                            alarmhrs = 1'b0;
                            alarmmins = 1'b0;  
                            hr = 1'b0;
                            min = 1'b0;
                            updown = 1'b1;
                            buzz = 1'b0;
                            blink = 1'b0;
                        end else if (go_left) begin
                        clk2 = clkout; 
                            nextstate = timemin;
                            LEDS = 4'b0010; 
                            enable = 1'b0;
                            alarm = 1'b0;
                            alarmhrs = 1'b0;
                            alarmmins = 1'b0;  
                            hr = 1'b0;
                            min = 1'b0;
                            updown = 1'bx;
                            buzz = 1'b0;
                            blink = 1'b1;
                        end else if (go_right) begin
                         clk2 = clkout; 
                            nextstate = alarmmin;
                            LEDS = 4'b1000; 
                            enable = 1'b0;
                            alarm = 1'b1;
                            alarmhrs = 1'b0;
                            alarmmins = 1'b0;  
                            hr = 1'b0;
                            min = 1'b0;
                            updown = 1'bx;
                            buzz = 1'b0;
                            blink = 1'b1;
                        end else if (go_up) begin
                        clk2 = clkout;
                            nextstate = alarmhr;
                            LEDS = 4'b0100; 
                            enable = 1'b0;
                            alarm = 1'b1;
                            alarmhrs = 1'b1;
                            alarmmins = 1'b0;  
                            hr = 1'b0;
                            min = 1'b0;
                            updown = 1'b1;
                            buzz = 1'b0;
                            blink = 1'b1;
                        end else if (go_down) begin
                        clk2 = clkout;
                            nextstate = alarmhr;
                            LEDS = 4'b0100; 
                            enable = 1'b0;
                            alarm = 1'b1;
                            alarmhrs = 1'b1;
                            alarmmins = 1'b0;  
                            hr = 1'b0;
                            min = 1'b0;
                            updown = 1'b0;
                            buzz = 1'b0;
                            blink = 1'b1;
                        end else begin
                        clk2 = clkout;
                            nextstate = alarmhr;
                            LEDS = 4'b0100; 
                            enable = 1'b0;
                            alarm = 1'b1;
                            alarmhrs = 1'b0;
                            alarmmins = 1'b0;  
                            hr = 1'b0;
                            min = 1'b0;
                            updown = 1'bx;
                            buzz = 1'b0;
                            blink = 1'b1;
                        end
                 end 
                alarmmin: begin  if (cntrl) begin
                            clk2 = clkout2; 
                            nextstate = clockkk;
                            LEDS = 4'b0000; 
                            enable = 1'b1;
                            alarm = 1'b0;
                            alarmhrs = 1'b0;
                            alarmmins = 1'b0;  
                            hr = 1'b0;
                            min = 1'b0;
                            updown = 1'b1;
                            buzz = 1'b0;
                            blink = 1'b0;
                        end else if (go_left) begin
                         clk2 = clkout;
                            nextstate = alarmhr;
                            LEDS = 4'b0100; 
                            enable = 1'b0;
                            alarm = 1'b1;
                            alarmhrs = 1'b0;
                            alarmmins = 1'b0;  
                            hr = 1'b0;
                            min = 1'b0;
                            updown = 1'bx;
                            buzz = 1'b0;
                            blink = 1'b1;
                        end else if (go_right) begin
                        clk2 = clkout;
                            nextstate = timehr;
                            LEDS = 4'b0001; 
                            enable = 1'b0;
                            alarm = 1'b0;
                            alarmhrs = 1'b0;
                            alarmmins = 1'b0;  
                            hr = 1'b0;
                            min = 1'b0;
                            updown = 1'bx;
                            buzz = 1'b0;
                            blink = 1'b1;
                        end else if (go_up) begin
                        clk2 = clkout;
                            nextstate = alarmmin;
                            LEDS = 4'b1000; 
                            enable = 1'b0;
                            alarm = 1'b1;
                            alarmhrs = 1'b0;
                            alarmmins = 1'b1;  
                            hr = 1'b0;
                            min = 1'b0;
                            updown = 1'b1;
                            buzz = 1'b0;
                            blink = 1'b1;
                        end else if (go_down) begin
                        clk2 = clkout;
                            nextstate = alarmmin;
                            LEDS = 4'b1000;  
                            enable = 1'b0;
                            alarm = 1'b1;
                            alarmhrs = 1'b0;
                            alarmmins = 1'b1;  
                            hr = 1'b0;
                            min = 1'b0;
                            updown = 1'b0;
                            buzz = 1'b0;
                            blink = 1'b1;
                       end else begin
                        clk2 = clkout;
                            nextstate = alarmmin;
                            LEDS = 4'b1000;  
                            enable = 1'b0;
                            alarm = 1'b1;
                            alarmhrs = 1'b0;
                            alarmmins = 1'b0;  
                            hr = 1'b0;
                            min = 1'b0;
                            updown = 1'bx;
                            buzz = 1'b0;
                            blink = 1'b1;
                       end
                     
                   end
             final : begin
                if (cntrl || go_up || go_down || go_left || go_right) begin
                    clk2 = clkout2;
                    nextstate = clockkk;
                    LEDS = 4'b0000; 
                    enable = 1'b1;
                    alarm = 1'b0;
                    alarmhrs = 1'b0;
                    alarmmins = 1'b0;  
                    hr = 1'b0;
                    min = 1'b0;
                    updown = 1'b1;
                    buzz = 1'b0;
                    blink = 1'b0;
                 end
                 else begin
                    clk2 = clkout2;
                    nextstate = final;
                    LEDS = 4'b0000; 
                    enable = 1'b1;
                    alarm = 1'b0;
                    alarmhrs = 1'b0;
                    alarmmins = 1'b0;  
                    hr = 1'b0;
                    min = 1'b0;
                    updown = 1'b1;
                    buzz =  clkout2;
                    blink = clkout2;
                 end
             end
             endcase
end
always @(posedge clkout, posedge rst) begin
    if(rst==1) begin
        state <= clockkk;
    end
    else
        state <= nextstate;
end
always @ (posedge clkout, posedge rst) begin
    if (rst) begin
        anodeactive = 4'b0000;
        out = 4'd0;
    end
    case (anodes)
        2'b00 : begin 
            anodeactive = 4'b1110;
            out = (alarm) ? alarmminutes % 10 : minutes % 10;
        end
        2'b01 : begin 
            anodeactive = 4'b1101;
            out = (alarm) ? alarmminutes / 10 : minutes / 10;
        end
        2'b10 : begin 
            anodeactive = 4'b1011;
            out = (alarm) ? alarmhours % 10 : hours % 10;
        end
        2'b11 : begin 
            anodeactive = 4'b0111;
            out = (alarm) ? alarmhours / 10 : hours / 10;
        end
    endcase  
end

always @ (out) begin
case(out)
0: segs = 7'b1000000;
1: segs = 7'b1111001;
2: segs = 7'b0100100;
3: segs = 7'b0110000;
4: segs = 7'b0011001;
5: segs = 7'b0010010;
6: segs = 7'b0000010;
7: segs = 7'b1111000;
8: segs = 7'b0000000;
9: segs = 7'b0010000;
default: segs = 7'b0001001;
endcase
end

endmodule