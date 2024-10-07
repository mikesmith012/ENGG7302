%% ENGG7302 Assignment 2 Part B (1-norm using linprog)
clear;

% Load in the provided data
addpath("a2data/");
load("A.mat");
load("b.mat");
load("x0.mat");

% Let the size of A
[m, n] = size(A);

% Set eps value (given in the assignment spec)
eps = 0.000008;


%% Inequality constraints for A and b

% Compute b0 as the mean of b
b0 = mean(b);

% A and b inequalities
Aineq = [A; -A];
bineq = [ 
     b0*(1 + eps) - b;
    -b0*(1 - eps) + b;
];


%% Bounds for x based on constraints

% Lower bound (x >= -x0)
lb = -x0;

% Upper bound (x <= 0.007 - x0)
ub = 0.007 - x0;


%% Set up the linprog function

% Objective function (minimise 1-norm)
f = ones(n,1);

% Set up linprog options: 
%  - Display results for each iteration
options = optimoptions('linprog', 'Display', 'iter');

% SOlve using linprog
x = linprog(f, Aineq, bineq, [], [], lb, ub, options);
spx1n_linprog = sparse(x); disp(spx1n_linprog);

% Save result
try save("a2outputs/a2b_1norm_linprog", "spx1n_linprog"); catch; end

