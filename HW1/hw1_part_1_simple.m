%% RBE502 - Fall 2020 - Homework 1 - Part 1
% The following code provides the solution to Part (1) of the assignment.

%% Initializations
clc;        % Clear Command Window
clear;      % Delete all the Workspace variables
close all;  % Close all figure objects

%% System Parameters
m = 1;          % Mass of the block [kg]
b = 2;          % Damping coefficient [Ns/m]
k = 4;          % Spring stiffness [N/m]

%% Initial Condition
t0 = 0;         % Simulation start time
tf = 10;        % Simulation finish time

y0 = 0;         % y0 = y(t0)
v0 = 0;         % v0 = dy/dt(t0)

%% Reference (Desired) Input
r = 1;

%% System Dynamics
f = @(t, x)[ x(2); (r - x(1) - b*x(2) - k*x(1))/m];


%% Solving for The Solution
x0 = [y0; v0];
tspan = [t0, tf];

[t,x] = ode45(f, tspan, x0);

%% Display the results

plot(t,x(:,1));     % x = [x1, x2] => y = x(:,1) and dy/dt = x(:,2)
xlabel('time in [s]');
ylabel('y(t) in [m]');