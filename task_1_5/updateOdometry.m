function updateOdometry(h)

global prev_encoders;
global actual_x;
global actual_y;
global actual_theta;


%distance between the wheels
l = 53;




%% Get distances in mm for each wheel
    encoders = kGetEncoders(h);

    delta_encoder_l = encoders(1) - prev_encoders(1);
    delta_encoder_r = encoders(2) - prev_encoders(2);
    
    
    prev_encoders = encoders;
    
    
    b_r = delta_encoder_r*0.13;
    b_l = delta_encoder_l*0.13;

    
%% Evaluation of cases
    
        
if (b_r == -1*b_l) || (b_r == ((-1*b_l)+1)) || (b_r == ((-1*b_l)-1))
      
      delta_phi = b_r/(l/2);
      
      if delta_phi ~= 0         
          actual_theta = wrapTo2Pi(actual_theta+delta_phi);
      end
      
      
      
     
elseif b_r == b_l   
        
       delta_x_ego = b_r;
       delta_y_ego = 0;
       
       x_allo = delta_x_ego*cos(actual_theta)-delta_y_ego*sin(actual_theta);
       y_allo = delta_x_ego*sin(actual_theta)+delta_y_ego*cos(actual_theta);
       actual_x = actual_x + x_allo;
       actual_y = actual_y + y_allo;
       
elseif (b_r ~= b_l) && (b_l > 0 && b_r > 0)

      delta_phi = (b_r-b_l)/l;
      actual_theta = wrapTo2Pi(actual_theta+delta_phi);
      b = abs(delta_phi*(l/2));
      r = (b*l)/(b_r-b_l);


      delta_y_ego = r*(1-cos(delta_phi));
      delta_x_ego = r*sin(delta_phi);
      
      x_allo = delta_x_ego*cos(actual_theta)-delta_y_ego*sin(actual_theta);
      y_allo = delta_x_ego*sin(actual_theta)+delta_y_ego*cos(actual_theta);
      actual_x = actual_x + x_allo;
      actual_y = actual_y + y_allo;
       
elseif (b_l ~= b_r) && (b_l < 0 && b_r < 0)
        
      if b_l < b_r
            delta_phi = (b_r -b_l)/l;
            actual_theta = wrapTo2Pi(actual_theta+delta_phi)+pi;
            b = delta_phi*(l/2);
            r = (b*l)/(b_r-b_l);


            delta_y_ego = r*(1-cos(delta_phi));
            delta_x_ego = r*sin(delta_phi);

            x_allo = delta_x_ego*cos(actual_theta)-delta_y_ego*sin(actual_theta);
            y_allo = delta_x_ego*sin(actual_theta)+delta_y_ego*cos(actual_theta);
            actual_x = actual_x + x_allo;
            actual_y = actual_y + y_allo;
            actual_theta = actual_theta - pi;
      else
            delta_phi = (b_r -b_l)/l;
            actual_theta = wrapTo2Pi(actual_theta+delta_phi);
            b = delta_phi*(l/2);
            r = (b*l)/(b_r-b_l);


            delta_y_ego = r*(1-cos(delta_phi));
            delta_x_ego = r*sin(delta_phi);

            x_allo = delta_x_ego*cos(actual_theta)-delta_y_ego*sin(actual_theta);
            y_allo = delta_x_ego*sin(actual_theta)+delta_y_ego*cos(actual_theta);
            actual_x = actual_x + x_allo;
            actual_y = actual_y + y_allo;
      end
end

grid on;
axis([-350 350 -350 350])
plot(actual_x, actual_y,'.');
drawnow;

end
