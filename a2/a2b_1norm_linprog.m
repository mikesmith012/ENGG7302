%% ENGG7302 Assignment 2 Part B (1-norm using linprog)
clear;

% Load in the provided data
addpath("a2data/");
load("A.mat");
load("b.mat");
load("x0.mat");

% Get the size of A
[m, n] = size(A);

% Set eps value (given in the assignment spec)
eps = 0.000008;


%% Inequality constraints for A and b

% Compute the mean of b
b_mean = mean(b);

% 
C = sum(A, 1) / m;

%
D1 = C*(1 + eps);
D2 = C*(1 - eps);

% A and b inequalities 
Aineq1 = [
     A - D1, zeros(m, n);    %  Ax <=  b0*(1 + eps) - b
     D2 - A, zeros(m, n);    % -Ax <= -b0*(1 - eps) + b
     eye(n), -eye(n);        %   x <= s,  x - s <= 0
    -eye(n), -eye(n);        %  -x <= s, -x - s <= 0
    
];
bineq1 = [
     b_mean*(1 + eps) - b;   %  Ax <=  b0*(1 + eps) - b
    -b_mean*(1 - eps) + b;   % -Ax <= -b0*(1 - eps) + b
     zeros(n, 1);            %   x <= s,  x - s <= 0
     zeros(n, 1);            %  -x <= s, -x - s <= 0
];

Aineq2 = [
     A - D1; 
     D2 - A;
];
bineq2 = [
     b_mean*(1 + eps) - b; 
    -b_mean*(1 - eps) + b;
];


%% Bounds for x based on constraints

% Lower bound (x >= -x0)
lb1 = [-x0, zeros(n, 1)];

% Upper bound (x <= 0.007 - x0)
ub1 = [0.007 - x0, inf(n, 1)];

% Lower bound (x >= -x0)
lb2 = -x0;

% Upper bound (x <= 0.007 - x0)
ub2 = 0.007 - x0;


%% Set up the linprog function

% Obj function
f1 = ones(1, 2*n);

% Solve using linprog
[x1, fval1] = linprog(f1, Aineq1, bineq1, [], [], lb1, ub1);
disp(fval1);

% Objective function (minimise 2-norm)
f2 = @(x) norm(x, 2);

% Solve using fmincon
[x2, fval2] = fmincon(f2, x0, Aineq2, bineq2, [], [], lb2, ub2);
disp(fval2);
