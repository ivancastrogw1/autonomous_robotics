clc;
clear;
close all;

h= kOpenPort();
kSetEncoders(h,0,0);
velocity = 300;
points = [230,60;230,400];

%hold on;
axis([0 9 0 9]);

navigate(h,points,velocity,(pi/2));


