# Elevator Controller (Verilog)

## Overview
This project implements a 4-floor elevator control system using Verilog HDL.  
The design is based on a Finite State Machine (FSM) to control elevator movement, floor selection, and emergency handling.

## Features
- 4-floor elevator system
- FSM-based control logic
- Priority-based floor request handling
- Up and Down movement control
- Emergency stop functionality
- Simulation using testbench

## Design Details
The system operates in the following states:
- IDLE
- MOVE_UP
- MOVE_DOWN
- EMERGENCY

The controller selects the target floor based on input requests and moves accordingly.

## File Structure

## How to Run (Vivado)
1. Open Vivado
2. Create a new project
3. Add `elevator_control_2.v` as Design Source
4. Add `elevator_control_2_testbench.v` as Simulation Source
5. Set testbench as Top module
6. Run Behavioral Simulation

## Simulation
- Clock period: 10ns
- Test cases include:
  - Floor requests
  - Multiple requests (priority)
  - Emergency stop

## Tools Used
- Verilog HDL
- Xilinx Vivado Simulator

## Future Improvements
- Add door open/close logic
- Implement request queue system
- Display floor on 7-segment display
- FPGA hardware implementation

## Author
Your Name
