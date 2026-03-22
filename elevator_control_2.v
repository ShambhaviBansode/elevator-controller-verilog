`timescale 1ns/1ps

module elevator_control_2(
    input clk,
    input reset,
    input [3:0] floor_req,
    input emergency_stop,
    
    output reg move_up,
    output reg move_down,
    output reg motor_stop,
    output reg [1:0] current_floor
);

    parameter S_IDLE       = 2'b00;
    parameter S_MOVE_UP    = 2'b01;
    parameter S_MOVE_DOWN  = 2'b10;
    parameter S_EMERGENCY  = 2'b11;

    reg [1:0] current_state, next_state;
    reg [1:0] target_floor;

    // Priority Logic
    always @(floor_req or current_floor) begin
        target_floor = current_floor;
        if (floor_req[0])
            target_floor = 2'd0;
        else if (floor_req[1])
            target_floor = 2'd1;
        else if (floor_req[2])
            target_floor = 2'd2;
        else if (floor_req[3])
            target_floor = 2'd3;
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S_IDLE;
        else
            current_state <= next_state;
    end

    // Floor tracking
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_floor <= 2'd0;
        else if (current_state == S_MOVE_UP)
            current_floor <= current_floor + 1'b1;
        else if (current_state == S_MOVE_DOWN)
            current_floor <= current_floor - 1'b1;
    end

    // Next state logic
    always @(current_state or target_floor or current_floor or emergency_stop) begin
        next_state = current_state;

        if (emergency_stop)
            next_state = S_EMERGENCY;
        else begin
            case (current_state)

                S_IDLE: begin
                    if (target_floor > current_floor)
                        next_state = S_MOVE_UP;
                    else if (target_floor < current_floor)
                        next_state = S_MOVE_DOWN;
                end

                S_MOVE_UP: begin
                    if (current_floor == target_floor)
                        next_state = S_IDLE;
                end

                S_MOVE_DOWN: begin
                    if (current_floor == target_floor)
                        next_state = S_IDLE;
                end

                S_EMERGENCY: begin
                    if (!emergency_stop)
                        next_state = S_IDLE;
                end

                default: next_state = S_IDLE;

            endcase
        end
    end

    // Output logic
    always @(current_state) begin
        move_up    = 1'b0;
        move_down  = 1'b0;
        motor_stop = 1'b0;

        case (current_state)
            S_MOVE_UP:    move_up    = 1'b1;
            S_MOVE_DOWN:  move_down  = 1'b1;
            S_EMERGENCY:  motor_stop = 1'b1;
            S_IDLE:       motor_stop = 1'b1;
        endcase
    end

endmodule