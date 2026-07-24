`timescale 1ns/1ps

module muse_tb;

reg clk;
reg rst;
reg maintenance_button;
reg maintenance_completed;
reg camera_detect;
reg motion_in_safe_zone;
reg env_detect;
reg authorized_activity;
reg problem_resolved;

wire timer;
wire alarm;
wire lockdown;
wire emergency;
wire env_hazard;
wire pre_alarm;

muse dut(
.clk(clk),
.rst(rst),
.maintenance_button(maintenance_button),
.maintenance_completed(maintenance_completed),
.camera_detect(camera_detect),
.motion_in_safe_zone(motion_in_safe_zone),
.env_detect(env_detect),
.authorized_activity(authorized_activity),
.problem_resolved(problem_resolved),
.timer(timer),
.alarm(alarm),
.lockdown(lockdown),
.emergency(emergency),
.env_hazard(env_hazard),
.pre_alarm(pre_alarm)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;

    rst = 0;
    maintenance_button = 0;
    maintenance_completed = 0;
    camera_detect = 0;
    motion_in_safe_zone = 1;
    env_detect = 0;
    authorized_activity = 0;
    problem_resolved = 0;

    #10 rst = 1;

    #10;
    $display("Time=%0t PS=%b NS=%b",
              $time,dut.present_state,dut.next_state);

    // S1 

    maintenance_button = 1;
    #10;
    maintenance_button = 0;

    #10;
    $display("Time=%0t PS=%b NS=%b",
              $time,dut.present_state,dut.next_state);

    maintenance_completed = 1;
    #10;
    maintenance_completed = 0;

    #10;
    $display("Time=%0t PS=%b NS=%b",
              $time,dut.present_state,dut.next_state);

    //  Authorized 

    camera_detect = 1;
    motion_in_safe_zone = 0;

    #10;
    camera_detect = 0;

    #50;

    authorized_activity = 1;

    #10;
    authorized_activity = 0;

    #10;

    $display("PS=%b NS=%b Alarm=%b Lock=%b Emergency=%b Timer=%b",
    dut.present_state,
    dut.next_state,
    alarm,
    lockdown,
    emergency,
    timer);

    //   Unauthorized 


    camera_detect = 1;
    motion_in_safe_zone = 0;

    #10;
    camera_detect = 0;

    #50;

    authorized_activity = 0;

    #20;

    $display("PS=%b NS=%b Alarm=%b Lock=%b Emergency=%b",
    dut.present_state,
    dut.next_state,
    alarm,
    lockdown,
    emergency);

    problem_resolved = 1;

    #10;

    problem_resolved = 0;

    //         Environmental 


    #10;

    env_detect = 1;

    #10;

    env_detect = 0;

    #20;

    $display("PS=%b NS=%b Hazard=%b Emergency=%b",
    dut.present_state,
    dut.next_state,
    env_hazard,
    emergency);

    problem_resolved = 1;

    #10;

    problem_resolved = 0;

    //Both 

  

    #10;

    camera_detect = 1;
    motion_in_safe_zone = 0;
    env_detect = 1;

    #20;

    camera_detect = 0;
    env_detect = 0;

    #20;

    $display("PS=%b NS=%b Alarm=%b Lock=%b Emergency=%b Hazard=%b",
    dut.present_state,
    dut.next_state,
    alarm,
    lockdown,
    emergency,
    env_hazard);

    problem_resolved = 1;

    #10;

    problem_resolved = 0;

    #20;

  

    $stop;

end

endmodule