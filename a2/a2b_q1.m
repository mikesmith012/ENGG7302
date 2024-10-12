%% ENGG7302 Assignment 2 Part B Question 1
clear;

% Load in the provided data (A, b and x0)
addpath("a2data/");
load("A.mat");
load("b.mat");
load("x0.mat");

% Get the size of A
[m, n] = size(A);

% Given eps value (0.0008%, from the assignment spec)
eps = 0.000008;


%% Set up intermediate matrices: C, D1, D2 and bm

% Compute the mean of b
bm = mean(b);

% Intermediate vector C such that: mean(Ax) = Cx
C = sum(A, 1) / m;

% Intermediate matrices D1 and D2 used in setting up the Aineq matrix
D1 = C*(1 + eps);
D2 = C*(1 - eps);


%% Inequality constraints for A and b
% -> Condition 1: (A - D1)x <= mean(b)(eps + 1) - b
% -> Condition 2: (D2 - A)x <= mean(b)(eps - 1) + b
% -> Condition 3:  x <= s,  x - s <= 0
% -> Condition 4: -x <= s, -x - s <= 0

% Set up inequalities for 1-norm
Aineq1 = [
     A - D1, zeros(m, n);   % Condition 1 LHS: (A - D1)x + (0)s
     D2 - A, zeros(m, n);   % Condition 2 LHS: (D2 - A)x + (0)s
     eye(n), -eye(n);       % Condition 3 LHS:  x - s
    -eye(n), -eye(n);       % Condition 4 LHS: -x - s
    
];
bineq1 = [
     bm*(eps + 1) - b;  % Condition 1 RHS: mean(b)(eps + 1) - b
     bm*(eps - 1) + b;  % Condition 2 RHS: mean(b)(eps - 1) + b
     zeros(n, 1);           % Condition 3 RHS: 0
     zeros(n, 1);           % Condition 4 RHS: 0
];

% Set up inequalities for 2-norm
Aineq2 = [
     A - D1;                % Condition 1 LHS: (A - D1)x
     D2 - A;                % Condition 2 LHS: (D2 - A)x
];
bineq2 = [
     bm*(eps + 1) - b;  % Condition 1 RHS: mean(b)(eps + 1) - b
     bm*(eps - 1) + b;  % Condition 2 RHS: mean(b)(eps - 1) + b
];


%% Bounds for x and s based on constraints

% 1-norm lower bounds (x >= -x0, s >= 0)
lb1 = [-x0, zeros(n, 1)];

% 1-norm upper bounds (x <= 0.007 - x0, s <= inf)
ub1 = [0.007 - x0, inf(n, 1)];

% 2-norm lower bound (x >= -x0)
lb2 = -x0;

% 2-norm upper bound (x <= 0.007 - x0)
ub2 = 0.007 - x0;


%% Set up the linprog function for 1-norm

% Objective function: minimise 1-norm
f1 = ones(1, 2*n);

% Minimise 1-norm using linprog
[x1, fval1] = linprog(f1, Aineq1, bineq1, [], [], lb1, ub1);
fprintf("1-norm fval = %.5f\n", fval1);


%% Set up the fmincon function for 2-norm

% Objective function: minimise 2-norm
f2 = @(x) norm(x, 2);

% Minimise 2-norm using fmincon
maxFuncEvals = 1e5;
options = optimoptions('fmincon', 'MaxFunctionEvaluations', maxFuncEvals);
[x2, fval2] = fmincon(f2, x0, Aineq2, bineq2, [], [], lb2, ub2, [], options);
fprintf("2-norm fval = %.5f\n", fval2);


%% Plot the resultant x-vectors
figure;

% 1-norm result
subplot(2, 1, 1); plot(x1); xlim([0, n]);
xlabel("n"); ylabel("x1(n)");
title(sprintf("Minimised 1-norm x results (fval = %.5f)", fval1));

% 2-norm result
subplot(2, 1, 2); plot(x2); xlim([0, n]);
xlabel("n"); ylabel("x2(n)");
title(sprintf("Minimised 2-norm x results (fval = %.5f, max func evals = %d)", fval2, maxFuncEvals));

