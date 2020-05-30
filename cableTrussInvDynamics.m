function tau = cableTrussInvDynamics(theta,thetadot,thetaddot,theta_lock,m_a,m_b,l_b,b)
    % Find which unit in the truss is going to be moving
    I = find(theta_lock,1,'last');
    if isempty(I)
        I = 0;
    end
    I = I + 1;
    
    % Get the value of the mass coefficients for the torque calculation
    c_a = sum((1:6-I).^2);
    c_b = 2*(6-I)^3/3;
    
    % Get the value of the friction torque
    friction = (6-I+1)*2*b*thetadot(I); % Simple friction model, two joints
                                        % per unit plus the two root units
    
    tau = zeros(length(theta),1)';
    tau(I) = (c_a*m_a + c_b*m_b)*l_b^2*thetaddot(I) + friction;
end