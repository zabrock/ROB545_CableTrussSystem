close all; clear all; clc;

% Variable set up
a = 1;
b = 3;
R = 0.3;
val = load('val.mat');

for i=1:100
    theta_list = [val(1).a(i), 0, 0, 0, 0];
    o = IKSolver(theta_list,a, b, R);
end







