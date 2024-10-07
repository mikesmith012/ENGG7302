%% ENGG7302 Assignment 2 Part B (testing 2-norm using quadprog)
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


%% Set up the quadprog function

% Objective function (minimize 2-norm)
H = 2*eye(n);  % Quadratic coefficient matrix
f = zeros(n,1); % Linear coefficient vector

% Set up quadprog options: 
%  - Display results for each iteration
options = optimoptions('quadprog', 'Display', 'iter');

% Solve using quadprog
x = quadprog(H, f, Aineq, bineq, [], [], lb, ub, [], options);
spx2n_quadprog = sparse(x); disp(spx2n_quadprog);

% Save result
try save("a2outputs/a2b_2norm_quadprog", "spx2n_quadprog"); catch; end

