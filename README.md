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
