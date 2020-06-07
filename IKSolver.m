function L1_prime = IKSolver(theta_list,a b, R)
        theta1, theta2, theta3, theta4, theta5 = theta_list;
        nx = cos(theta1 + theta2 + theta3 + theta4 + theta5);
        ny = sin(theta1 + theta2 + theta3 + theta4 + theta5);

        sx = - sin(theta1 + theta2 + theta3 + theta4 + theta5);
        sy =   cos(theta1 + theta2 + theta3 + theta4 + theta5);

        t1 = b* cos(theta1 + theta2 + theta3 + theta4 + theta5);
        t2 = b* cos(theta1 + theta2 + theta3 + theta4 );
        t3 = b* cos(theta1 + theta2 + theta3);
        t4 = b* cos(theta1 + theta2); 
        t5 = b* cos(theta1);




        Px  = t1 + t2 + t3 + t4 + t5;

        t1 = b* sin(theta1 + theta2 + theta3 + theta4 + theta5);
        t2 = b* sin(theta1 + theta2 + theta3 + theta4 );
        t3 = b* sin(theta1 + theta2 + theta3);
        t4 = b* sin(theta1 + theta2); 
        t5 = b* sin(theta1);

        Py  = t1 + t2 + t3 + t4 + t5;


        t1 = 4*sqrt((a^2)-(4*(R^2)));
        t2 = (18*pi*R) - (8*R*acos(2*R/a));
        t3 = 4*sqrt((a^2) + (b^2) -(4*(R^2)) -  (2*a*b*ny));
        t4 = sqrt((a^2) + (b^2) - (2*a*b*ny) - (R^2));

        denom1 = sqrt((a^2) + (b^2) + (2*a*b*ny));
        denom2 = sqrt((a^2) + (b^2) - (2*a*b*ny));

        t5 = - 1*R*(acos((a+(b*ny))/denom1) + acos(2*R/denom1));
        t6 = - 7*R*(acos((a - (b*ny))/denom2) + acos(2*R/denom2));

        t7 = - R*(acos((a - (b*ny))/denom2) + acos(R/denom2));


        L1_prime =  t1 + t2 + t3 + t4 + t5 + t6 + t7;

end
