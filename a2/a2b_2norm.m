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


%% Bounds for x based on constraints

% Lower bound (x >= -x0)
lb = -x0;

% Upper bound (x <= 0.007 - x0)
ub = 0.007 - x0;


%% Set up the fmincon function

% Objective function (minimise 2-norm)
fun = @(x) norm(x, 2);

% Nonlinear constraint function with additional parameters
nonlcon = @(x) nonlin_constr(x, A, b, eps);

% Set up fmincon options:
%  - Display results for each iteration
%  - Specify opt algorithm
%  - Set max number of function evals
options = optimoptions('fmincon', ...
    'Display', 'iter', ...
    'Algorithm', 'sqp', ...
    'MaxFunctionEvaluations', 1e4 ...
);

% Solve using fmincon
[x_opt, fval, exitflag, output] = fmincon(fun, x0, [], [], [], [], lb, ub, nonlcon, options);
x_opt_sparse = sparse(x_opt); disp(x_opt_sparse);

% Save result
save("a2b_2norm", "x_opt_sparse");


%% Nonlinear constraint function
function [cineq, ceq] = nonlin_constr(x, A, b, eps)
    b0 = mean(b);
    bp = A * x + b;

    % Specify constraints
    cineq = [
        -b0 * (1 + eps) + bp;
         b0 * (1 - eps) - bp;
    ];
    ceq = [];
end