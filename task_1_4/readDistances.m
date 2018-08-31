function [ distances ] = readDistances(h)

sensors = kProximity(h);
    for i = 1:8       
            
           v = (sensors(i)-30)/(3970);
           if v <= 0
            sensor_value = 8% (-0.96*log(0.01)-0.1);
           else
            sensor_value = (-0.96*log(v)-0.1);
           end
           sensor_value
           distances(i) = abs(sensor_value);                
    end
end