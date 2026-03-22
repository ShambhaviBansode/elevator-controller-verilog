`timescale 1ns/1ps

module elevator_control_2_testbench();

    reg clk;
    reg reset;
    reg [3:0] floor_req;
    reg emergency_stop;

    wire move_up;
    wire move_down;
    wire motor_stop;
    wire [1:0] current_floor;

    elevator_control_2 dut (
        .clk(clk),
        .reset(reset),
        .floor_req(floor_req),
        .emergency_stop(emergency_stop),
        .move_up(move_up),
        .move_down(move_down),
        .motor_stop(motor_stop),
        .current_floor(current_floor)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        floor_req = 0;
        emergency_stop = 0;

        #20 reset = 0;

        #10 floor_req = 4'b0100;
        #40 floor_req = 0;

        #20 floor_req = 4'b0001;
        #40 floor_req = 0;

        #20 floor_req = 4'b1010;
        #40 floor_req = 0;

        #20 emergency_stop = 1;
        #30 emergency_stop = 0;

        #50 $finish;
    end

    initial begin
        $monitor("Time=%0t Floor=%0d Req=%b Up=%b Down=%b Stop=%b EMG=%b",
                 $time, current_floor, floor_req,
                 move_up, move_down, motor_stop, emergency_stop);
    end

endmodule