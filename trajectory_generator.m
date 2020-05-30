function fun = trajectory_generator(q_init,q_final,qdot_init,qdot_final,qddot_init,qddot_final,T)
    
    a3 = 10/T^3;
    a4 = -15/T^4;
    a5 = 6/T^5;
    s = @(t) a3*t^3 + a4*t^4 + a5*t^5;
    sdot = @(t) 3*a3*t^2 + 4*a4*t^3 + 5*a5*t^4;
    sddot = @(t) 6*a3*t + 12*a4*t^2 + 20*a5*t^3;
    function [qd, qdotd, qdotdotd] = trajectory(time)
        qd = q_init + s(time)*(q_final-q_init);
        qdotd = qdot_init + sdot(time)*(q_final-q_init);
        qdotdotd = qddot_init + sddot(time)*(q_final-q_init);
    end

    fun = @trajectory;
end

