% Define parameters of system
m_a = 0.1;  % Mass of horizontal bar
m_b = 0.2;  % Mass of vertical bar
l_a = 0.1;    % Length of horizontal bar
l_b = 0.3;    % Length of vertical bar
b = 0.1;    % Linear friction coefficient

v = VideoWriter('dynamics_viz.mp4','MPEG-4');
open(v);

theta_init = [pi/2 + pi/3, 0, 0, 0, 0]';

theta_limit = [pi/2 + pi/6, -pi/12, -pi/12, -pi/12, -pi/12]';

truss_sys = cableTrussSystem(length(theta_init), l_a, l_b);

T = 1;
dt = 0.001;
time = 0:dt:T;

trajectory = trajectory_generator(sum(theta_init),sum(theta_limit),0,0,0,0,T);

theta_lock = zeros(size(theta_init));
tau = zeros(length(theta_init),length(time));
q = zeros(2*length(theta_init),length(time)); q(1:length(theta_init),1) = theta_init;
for i = 1:length(time)
    [qd, qdotd, qdotdotd] = trajectory(time(i));
    
    % Find which joint is going to be rotating
    I = find(theta_lock,1,'last');
    if isempty(I)
        I = 0;
    end
    I = I+1;
    
    % Get the input torque tau needed to generate the motion
    thetaddot = zeros(size(theta_init)); thetaddot(I) = qdotdotd
    thetadot = zeros(size(theta_init)); thetadot(I) = qdotd;
    tau(:,i) = cableTrussInvDynamics(q(1:length(theta_init),i),thetadot,thetaddot,theta_lock,m_a,m_b,l_b,b);
    
    if i < length(time)
        % Now integrate to see where that input torque puts us
        thetaddot_out = cableTrussFwdDynamics(q(1:length(theta_init),i),thetadot,tau(:,i),theta_lock,m_a,m_b,l_b,b);
        dq = [q(length(theta_init)+1:end,i); thetaddot_out];
        q(:,i+1) = q(:,i) + dq*dt;

        % Check to see if the links have "come in contact" with the object
        % (i.e. reached the limits)
        q(I,i+1) - theta_limit(I);
        if abs(q(I,i) - theta_limit(I)) < 0.001
            theta_lock(I) = 1
            if I < length(theta_limit)
                q(length(theta_limit)+I+1,i+1) = q(length(theta_limit)+I,i+1);
            end
            q(length(theta_limit)+I,i+1) = 0;
        end
    end
    
    axis_limits = [5*l_b*cos(theta_init(1)+pi/6),l_b,-0.2*l_b,6*l_b];
    truss_sys.drawTrussSystem(q(1:length(theta_init),i),axis_limits)
    frame = getframe(gcf);
    writeVideo(v,frame);
end

close(v);

figure();
plot(time, sum(q(1:length(theta_init),:),1),'LineWidth',2)
xlabel('Time (s)')
ylabel('End effector configuration (rad)')
set(gca,'FontSize',14)
figure();
plot(time, q(1:length(theta_init),:),'LineWidth',2)
xlabel('Time (s)')
ylabel('Unit configurations (rad)')
legend('Unit 1','Unit 2','Unit 3','Unit 4','Unit 5')
set(gca,'FontSize',14)
figure();
plot(time, tau,'LineWidth',2)
xlabel('Time (s)')
ylabel('Effective unit torque (Nm)')
legend('Unit 1','Unit 2','Unit 3','Unit 4','Unit 5')
set(gca,'FontSize',14)