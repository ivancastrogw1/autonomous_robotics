function task_1_3(h,initial_position,initial_orientation_degrees)

%%%%%FIXED PROGRAM%%%%%
%DO NOT CHANGE ANY VARIABLES HERE
global curInterval
global timeStamp
global curCommandCode
curInterval = [];
timeStamp = [];
curCommandCode = [];
numberOfSwitches = 0;
%%%%%END FIXED PROGRAM%%%%%

x = initial_position(1);
y = initial_position(2);

theta = initial_orientation_degrees;

%distance between the wheels
l = 53;


kSetEncoders(h,0,0);

prev_encoders = kGetEncoders(h);
hold on
%%%%%FIXED PROGRAM%%%%%
%DO NOT CHANGE ANY VARIABLES HERE   
 while(numberOfSwitches<20)
   
    didSwitch = randomMovement(h);
    %move(h,-200 ,200,10);    
    encoders = kGetEncoders(h);
    
    delta_encoder_l = encoders(1) - prev_encoders(1);
    delta_encoder_r = encoders(2) - prev_encoders(2);
    
    prev_encoders = encoders;
    
    b_r = delta_encoder_r*0.13;
    b_l = delta_encoder_l*0.13;
    
    in_b_r = int16(b_r);
    in_b_l = int16(1*b_l);
        
if (in_b_r == -1*in_b_l) || (in_b_r == ((-1*in_b_l)+1)) || (in_b_r == ((-1*in_b_l)-1))
      
      delta_phi = b_r/(l/2);
      theta = wrapTo2Pi(theta+delta_phi);
      
      
     
elseif b_r == b_l         
        
       delta_x_ego = b_r;
       delta_y_ego = 0;
       x_allo = delta_x_ego*cos(theta)-delta_y_ego*sin(theta);
       y_allo = delta_x_ego*sin(theta)+delta_y_ego*cos(theta);
       x = x + x_allo;
       y = y + y_allo;
       
elseif (b_r ~= b_l) && (b_l > 0 && b_r > 0)

      delta_phi = (b_r-b_l)/l;
      theta = wrapTo2Pi(theta+delta_phi);
      b = abs(delta_phi*(l/2));
      r = (b*l)/(b_r-b_l);


      delta_y_ego = r*(1-cos(delta_phi));
      delta_x_ego = r*sin(delta_phi);
      
      x_allo = delta_x_ego*cos(theta)-delta_y_ego*sin(theta);
      y_allo = delta_x_ego*sin(theta)+delta_y_ego*cos(theta);
      x = x + x_allo;
      y = y + y_allo;
       
elseif (b_l ~= b_r) && (b_l < 0 && b_r < 0)
        
      if b_l < b_r
        delta_phi = (b_r -b_l)/l;
        theta = wrapTo2Pi(theta+delta_phi)+pi;
        b = delta_phi*(l/2);
        r = (b*l)/(b_r-b_l);


        delta_y_ego = r*(1-cos(delta_phi));
        delta_x_ego = r*sin(delta_phi);

        x_allo = delta_x_ego*cos(theta)-delta_y_ego*sin(theta);
        y_allo = delta_x_ego*sin(theta)+delta_y_ego*cos(theta);
        x = x + x_allo;
        y = y + y_allo;
        theta = theta - pi
      else
        delta_phi = (b_r -b_l)/l;
        theta = wrapTo2Pi(theta+delta_phi);
        b = delta_phi*(l/2);
        r = (b*l)/(b_r-b_l);


        delta_y_ego = r*(1-cos(delta_phi));
        delta_x_ego = r*sin(delta_phi);

        x_allo = delta_x_ego*cos(theta)-delta_y_ego*sin(theta);
        y_allo = delta_x_ego*sin(theta)+delta_y_ego*cos(theta);
        x = x + x_allo;
        y = y + y_allo;
      end

 end    
    axis([-200 200 -200 200])
    plot(x, y,'.');
    drawnow;
    
    
    numberOfSwitches = numberOfSwitches + didSwitch;
 end   
    %%%%%END FIXED PROGRAM%%%%%

kStop(h);



end
