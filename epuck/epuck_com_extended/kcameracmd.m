function r = kcmd(ref,cmd,multiline)
%KCMD     high-level command for communicating with Khepera
%
%kcmd(command, multiline)
%  send a single command to Khepera (command shouldn't contain
%  the cr)
%
%r = kcmd(command)
%  send a command to Khepera and set r to its reply (without cr)
%
%r = kcmd(command, multiline)
%  continue receiving until timeout if multiline

% Written by Yves Piguet, 8/98.

if nargin <= 2
	multiline = 0;
end

if multiline
	r = eval('kcamera(cmd,ref,0)');
		% use static buffer if the dynamic buffer is not supported
else
	r = eval('kcamera(cmd,ref)');
end
