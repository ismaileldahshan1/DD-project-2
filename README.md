# DD-project-2
FPGA Clock/Alarm System README
This repository contains the implementation of a clock/alarm system using the BASYS3 FPGA board. The system includes functionalities such as displaying time on a 7-Segment display, adjusting time and alarm settings, blinking LEDs, and generating an alarm sound. Below is a guide to understanding and using the system components.

System Overview
The clock/alarm system consists of several components:

7-Segment Display Driver: Responsible for converting digital signals to the appropriate format for displaying time on the 7-Segment display.
Counter Module: Tracks seconds, minutes, and hours to keep track of time.
Control Unit (CU): Controls the overall behavior of the system, including mode switching between clock/alarm and adjust modes, and handling button inputs.
Display Processor (DP): Manages the display of time on the 7-Segment display and the blinking of the second decimal point.
LEDs (LD0, LD12, LD13, LD14, LD15): Indicate system status, such as mode selection and alarm activation.
Block Diagram

ASM Chart

Implementation Details
7-Segment Display Driver
The 7-Segment display driver module is responsible for converting binary-coded decimal (BCD) signals representing hours and minutes into signals that can be displayed on the 7-Segment display.

Counter Module
The counter module is a synchronous up-counter that counts seconds, minutes, and hours. It is designed to reset when reaching the maximum count for each time unit.

Control Unit (CU)
The control unit manages the system's operation modes: clock/alarm mode and adjust mode. It also handles button inputs for mode switching and parameter adjustment.

Display Processor (DP)
The display processor module controls the display of time on the 7-Segment display and manages the blinking of the second decimal point to indicate system activity.

LEDs
LEDs LD0, LD12, LD13, LD14, and LD15 are used to indicate various system states, such as mode selection, parameter adjustment, and alarm activation.

Usage
Clone this repository.
Open the project in Logisim Evolution and load the provided circuit files.
Simulate the circuit to verify functionality.
Program the FPGA board with the synthesized design.
Test the clock/alarm system on the FPGA board.
Report
Refer to the provided report file for detailed documentation of the system design, implementation, and testing.

Bonus Feature (10% Bonus)
To implement the alarming sound feature using a buzzer, follow these steps:

Connect a buzzer to the FPGA board.
Implement a module to generate the alarming sound when the alarm is activated.
Test the buzzer functionality along with the rest of the system components.
