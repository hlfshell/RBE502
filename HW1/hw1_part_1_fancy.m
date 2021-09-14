%% RBE502 - Fall 2020 - Homework 1
% The following code provides the solution to Part (1) of the assignment.
% This is a more complicated implementation in comparison to
% hw1_part_1_simple.m. However, it generates better visualizations and is
% intended to show some more advanced commands and functions in MATLAB.
% To focus on changes and have cleaner code, we have removed all comments 
% that are included in hw1_part_1_simple.m.
%
% Most of the functions used in this code have much simpler and compact
% syntax as well. Our intent to use the advanced syntax is to demonstrate
% some of the possible option. Please refer to MATLAB help document for
% detailed information on any command or function.

%% Initializations
clc; clear; close all;
m = 1;          % Mass of the block [kg]
b = 2;          % Damping coefficient [Ns/m]
k = 4;          % Spring stiffness [N/m]

t0 = 0;         % Simulation start time
tf = 10;        % Simulation finish time

y0 = 0;         % y0 = y(t0)
v0 = 0;         % v0 = dy/dt(t0)

r = 1;          % Reference (desired) input

%% System Dynamics

% Defining control as an anonymous function increases code modularity.
phi = @(x) r - x(1); 

f = @(t, x, u)[ x(2); (u - b*x(2) - k*x(1))/m];

%% Solving for The Solution
x0 = [y0; v0];
t = linspace(t0, tf, 100)';

% We can use an anonymous function to reduce the input numbers of the f
% function by fixing u as phi(x)
[~,x] = ode45(@(t,x)f(t,x,phi(x)), t, x0);

%% Display the results

ax = axes('NextPlot','add','TickLabelInterpreter','LaTeX','FontSize',20,...
    'XLim',[t(1), t(end)],'Ylim',[-0.1 r + 0.1],...
    'Xgrid','on','Ygrid','on','Box','on');

line(t,x(:,1),'color',[0, 0.447, 0.741],'LineWidth',2,...
    'Parent',ax,'DisplayName','$y(t)$');
line(t,x(:,2),'color',[0.85, 0.325, 0.098],'LineWidth',2,...
    'Parent',ax,'DisplayName','$\dot{y}(t)$');
line(t([1,end]),[r r],'color',[0 0 0],'LineWidth',2,...
    'LineStyle','--','Parent',ax,'DisplayName','$r$');


xlabel(ax,'$t$ [s]','Interpreter','LaTeX','FontSize',20);
legend(ax,'Interpreter','LaTeX','FontSize',20,...
    'Position', [0.786, 0.666, 0.098, 0.135]);

