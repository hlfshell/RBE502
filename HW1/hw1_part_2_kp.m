%% RBE502 - Fall 2020 - Homework 1 - Part 2 - Case Study I

clc; clear; close all;

m = 1;          % Mass of the block [kg]
b = 2;          % Damping coefficient [Ns/m]
k = 4;          % Spring stiffness [N/m]

t0 = 0;         % Simulation start time
tf = 10;        % Simulation finish time

y0 = 0;         % y0 = y(t0)
v0 = 0;         % v0 = dy/dt(t0)

r = 1;          % Reference (desired) input
dr = 0;         % Derivative of the reference input with respect to time


phi = @(x,kp,ki,kd) kp*(r - x(1)) + ki*x(3) + kd*(dr - x(2)); 

f = @(t, x, u)[ x(2); (u - b*x(2) - k*x(1))/m; r - x(1)];


x0 = [y0; v0; r - y0];
tspan = [t0, tf];


%% Case Study 1: Varying kp, fixed ki and kd

kp = [5, 10, 20];
ki = 0;
kd = 0;

axes; hold on; box on; grid on;

for gain = kp
    [t,x] = ode45(@(t,x)f(t,x,phi(x,gain,ki,kd)), tspan, x0);
    e = r - x(:,1);
    
    J = trapz(t,abs(e));
    
    plot(t,x(:,1),'LineWidth',1.5);
    
    
    fprintf('kp = %2d, tf = %d, e(tf) = %.4f, J = %.4f\n',...
        gain, tf, e(end,1), J);
end

plot(tspan,[r r],'k');
xlabel('t'); ylabel('y(t)');
legend('k_p = 5','k_p = 10', 'k_p = 20','r');