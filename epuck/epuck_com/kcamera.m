%Communicates with the epuck camera.  Returns an empty string if the answer
%timed out.
%
%answer = kcamera(cmd,handle[,multiline])
%
%    cmd:       Commandstring to be sent to the robot.  Must include 'lf'
%
%    handle:    Handle obtained from kopen
%
%    multiline: Not implemented and ignored.  Always reads a single line.
%
%    answer:  response from the robot, excluding cr and lf
%
%    NOTE: For speed reasons ksend uses a fixed intermediate buffer.
%          It should be big enough for almost all cases.  If for
%          whatever reason it is too small change kcamera.c and recompile
%

