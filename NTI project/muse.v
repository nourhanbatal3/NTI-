module muse(
input clk,
input rst,
input maintenance_button,
input maintenance_completed,
input camera_detect,
input motion_in_safe_zone,
input env_detect,
input authorized_activity,
input problem_resolved,

output reg timer,
output reg alarm,
output reg lockdown, //lockdown on artifact not the place 
output reg emergency,
output reg env_hazard,
output reg pre_alarm
);

localparam [2:0]

s0 = 3'b000,
s1 = 3'b001,
s2 = 3'b010,
s3 = 3'b011,
s4 = 3'b100,
s5 = 3'b101,
s6 = 3'b110,
s7 = 3'b111;

reg [2:0] present_state,next_state;
reg [3:0] counter;
reg  flag;
reg env_flag;
wire timer_expired;
assign timer_expired = (counter == 4'b0100);

// Register flip flop 
always @(posedge clk or negedge rst)
begin
    case(rst)
     1'b0 :   present_state <= s0;
     1'b1 :   present_state <= next_state;
    endcase
end
//flip flop 2
always @(posedge clk or negedge rst)
begin
    if(!rst)
        counter <= 4'b0000;

    else if(present_state == s3)
    begin
        if(counter < 4'b0100)
            counter <= counter + 1;
        else
            counter <= counter;
    end

    else
        counter <= 4'b0000;
end

// fregister 3
always @(posedge clk or negedge rst) begin 
  if(!rst) begin
    flag <=0;
    env_flag <= 0; 
    end
  else begin 
    if(camera_detect && !motion_in_safe_zone)
      flag <=1;
    if(env_detect)
      env_flag<=1;
    if(problem_resolved) begin
      flag <=0;
      env_flag<=0;
      end
  end
end


task state;
input [2:0] presentstate;
begin
    next_state = presentstate;
end
endtask

always @(*)
begin
next_state = present_state;
case(present_state)

s0:
begin
    if(maintenance_button)
        state(s1);

    else if(env_detect)
        state(s7);

    else if(camera_detect && !motion_in_safe_zone)
        state(s2);

    else
        state(s0);
end

s1:
begin
    if(maintenance_completed)
        state(s0);
    else
        state(s1);
end

s2:
begin
    state(s3);
end

s3:
begin
    if(timer_expired)
        state(s4);
    else
        state(s3);
end

s4:
begin
    if(authorized_activity)
        state(s0);
    else
        state(s5);
end

s5:
begin
    state(s6);
end

s6:
begin
    if(problem_resolved)
        state(s0);
    else
        state(s6);
end

s7:
begin
    state(s5);
end

default:
begin
    state(s0);
end

endcase

end

//output logic
always @(*)
begin

timer = 0;
alarm = 0;
lockdown = 0;
emergency = 0;
env_hazard = 0;
pre_alarm = 0;

if(flag && env_flag)
  begin
    pre_alarm = 1;
    alarm = 1;
    lockdown = 1;
    env_hazard = 1;
    emergency = 1;
  end
  
case(present_state)

s0:
begin
end

s1:
begin
end

s2:
begin
    pre_alarm = 1;
end

s3:
begin
    pre_alarm = 1;
    timer = 1;
end

s4:
begin
end

s5:
begin
    alarm = 1;
    lockdown = 1;
end

s6:
begin
    alarm = 1;
    lockdown = 1;
    emergency = 1;
end

s7:
begin
    env_hazard = 1;
end

default:
begin
    timer = 0;
    alarm = 0;
    lockdown = 0;
    emergency = 0;
    env_hazard = 0;
    pre_alarm = 0;
end
endcase
end
endmodule