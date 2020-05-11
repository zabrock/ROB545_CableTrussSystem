% Create a system with 5 links where the center links are 1 unit long and
% the side links are 3 units long
numUnits = 5;
length_a = 1;
length_b = 3;
truss_sys = cableTrussSystem(numUnits, length_a, length_b);

% First link's rotation is with respect to world frame, so pi/2 is rotated
% straight up; every rotation after that is with respect to the previous
% frame
theta = [pi/2 + pi/3, -pi/12, -pi/12, -pi/12, -pi/12];

% System is drawn in a configuration theta by this function
truss_sys.drawTrussSystem(theta)