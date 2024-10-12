%% ENGG7302 Assignment 2 Part B (2-norm using fmincon)
clear;

% Load in the provided data
addpath("a2data/");
load("A.mat");
load("b.mat");
load("x0.mat");

% Get the size of A
[m, n] = size(A);

% Constants
eps = 0.000008;  % Given eps value


%% Inequality constraints for A and b

% Compute the mean of b
b_mean = mean(b);

% 
C = sum(A, 1) / m;

%
D1 = C*(1 + eps);
D2 = C*(1 - eps);

% A and b inequalities 
Aineq = [A - D1; D2 - A];
bineq = [
     b_mean*(1 + eps) - b; 
    -b_mean*(1 - eps) + b;
];


%% Bounds for x based on constraints

% Lower bound (x >= -x0)
lb = -x0;

% Upper bound (x <= 0.007 - x0)
ub = 0.007 - x0;


%% Set up the fmincon function

% Objective function (minimise 2-norm)
fun = @(x) norm(x, 2);

% Solve using fmincon
[x, fval] = fmincon(fun, x0, Aineq, bineq, [], [], lb, ub);
disp(fval);
