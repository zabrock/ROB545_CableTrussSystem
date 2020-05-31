close all; clear all; clc;

% Variable set up
a = 1;
b = 3;
R1 = 0.3;
R2 = 0.3;
R3 = 0.3;
R4 = 0.3;
R5 = 0.3;
theta1 = 5*pi/6;
theta2 = -pi/12;
theta3 = -pi/12;
theta4 = -pi/12;
theta5 = -pi/12;


d11_sqrd = (a^2) + (b^2) - (2*a*b*sin(theta1));
d12_sqrd = (a^2) + (b^2) + (2*a*b*sin(theta1));

%not a necessary calc, but verifies theta given the lengths
theta1 = asin(((a^2)+(b^2)-d11_sqrd)/(2*a*b)); %only good for -pi/2 to pi/2

l11 = sqrt(d11_sqrd-((R1+R1)^2));
l12 = sqrt(d12_sqrd-((R1+R1)^2));

alpha12 = rad2deg((2*pi) - acos((2*R1)/a)-acos(((a^2)+d11_sqrd-(b^2))/...
    (2*a*sqrt(d11_sqrd)))-acos((R1+R1)/sqrt(d11_sqrd)));
beta12 = rad2deg((2*pi) - acos((2*R1)/a)-acos(((a^2)+d12_sqrd-(b^2))/...
    (2*a*sqrt(d12_sqrd)))-acos((R1+R1)/sqrt(d12_sqrd)));

%Total cable length 
L10 = sqrt((a^2)-(4*(R2^2)))+sqrt((a^2)-(4*(R3^2)))+sqrt((a^2)-(4*(R4^2)))+...
    sqrt((a^2)-(4*(R5^2)))+(2*pi*(R1+(2*R2)+(2*R3)+(2*R4)+(2*R5)))-...
    (2*R2*acos((2*R2)/a))-(2*R3*acos((2*R3)/a))-(2*R4*acos((2*R4)/a))-(2*R5*acos((2*R5)/a));

L11= sqrt((a^2)+(b^2)-((R1+R2)^2)-(2*a*b*sin(theta1)))+...
    sqrt((a^2)+(b^2)-((R2+R3)^2)-(2*a*b*sin(theta1+theta2)))+...
    sqrt((a^2)+(b^2)-((R3+R4)^2)-(2*a*b*sin(theta1+theta2+theta3)))+...
    sqrt((a^2)+(b^2)-((R4+R5)^2)-(2*a*b*sin(theta1+theta2+theta3+theta4)))+...
    sqrt((a^2)+(b^2)-(R5^2)-(2*a*b*sin(theta1+theta2+theta3+theta4+theta5)));

pos_denom1 = sqrt((a^2)+(b^2)+(2*a*b*sin(theta1)));
neg_denom1 = sqrt((a^2)+(b^2)-(2*a*b*sin(theta1)));
neg_denom2 = sqrt((a^2)+(b^2)-(2*a*b*sin(theta1+theta2)));
neg_denom3 = sqrt((a^2)+(b^2)-(2*a*b*sin(theta1+theta2+theta3)));
neg_denom4 = sqrt((a^2)+(b^2)-(2*a*b*sin(theta1+theta2+theta3+theta4)));
neg_denom5 = sqrt((a^2)+(b^2)-(2*a*b*sin(theta1+theta2+theta3+theta4+theta5)));

L12 = R1*(-acos((a+(b*sin(theta1)))/pos_denom1)-acos((R1+R2)/pos_denom1));
L13 = R2*(-acos((a+(b*sin(theta1)))/neg_denom1)-acos((R1+R2)/neg_denom1));
L14 = -(R2+R3)*acos((a-(b*sin(theta1+theta2)))/neg_denom2)-(R2+R3)*...
    acos((R2+R3)/neg_denom2);
L15 = -(R3+R4)*acos((a-(b*sin(theta1+theta2+theta3))/...
    neg_denom3)-(R3+R4)*acos((R3+R4)/neg_denom3));
L16 = -(R4+R5)*acos((a-(b*sin(theta1+theta2+theta3+theta4))/...
    neg_denom4)-(R4+R5)*acos((R4+R5)/neg_denom4));
L17 = -(R5)*acos((a-(b*sin(theta1+theta2+theta3+theta4+theta5))/...
    neg_denom5)-(R5)*acos((R5)/neg_denom5));
L_array = [L10, L11, L12, L13, L14, L15, L16, L17];

L1 = sum(L_array)
