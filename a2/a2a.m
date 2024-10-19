%% ENGG7302 Assignment 2 - Part A 
%  Mike Smith - 46408789
clear;

% Number of chairs for type A, B and C respectively
N = [
     90,  10,  80;
    100,  80, 140;
    170,  30, 160;
    169,  31, 155;
    100,  90,  90;
];

% Observed price of wood
p = [50; 20; 90; 100; 40];

% Define constants
[n, t] = size(N);


%% Question 1
fprintf("\n\nQUESTION 1\n");

% Function vector: [x1, x2, ..., xt, s1, s2, ..., sn]
% x1, x2, ..., xt = 0 -> don't minimise/maximise prediction parameters
% s1, s2, ..., sn = 1 or -1 -> minimise or maximise respectively
f1 = [zeros(1, t), ones(1, n)];  % minimise s1, s2, ..., sn    

% Coefficients of prediction parameters (from the observation matrix)
A1 = [
    -N, -eye(n);    % Positive deviation: -N - S <= -P
     N, -eye(n);    % Negative deviation:  N - S <=  P
];

% Observed prices (positive and negative deviations)
b1 = [-p; p];

% Solve the system of linear equations
[x1, fval1] = linprog(f1, A1, b1); disp(x1); 

% Display predicted parameters
fprintf("Prediction Parameters:\n"); 
fprintf("a = %f\n", x1(1));
fprintf("b = %f\n", x1(2));
fprintf("c = %f\n", x1(3));

% Display predicted prices for each observation
predicted1 = N * [x1(1); x1(2); x1(3)];
fprintf("\nPredicted Prices:\n");
fprintf("%f\n", predicted1);

% Display fval
fprintf("\nfval = %.5f\n", fval1);


%% Question 2
fprintf("\n\nQUESTION 2\n");

% Function vector: [x1, x2, ..., xt, s]
% x1, x2, ..., xt = 0 -> don't minimise/maximise prediction parameters
% s = 1 or -1 -> minimise or maximise respectively
f2 = [zeros(1, 3), ones(1, 1)];  % minimise s

% Coefficients of prediction parameters (from the observation matrix)
A2 = [
    -N, -ones(n, 1);    % Positive deviation: -N - S <= -P
     N, -ones(n, 1);    % Negative deviation:  N - S <=  P
];

% Observed prices (positivee and negative deviations)
b2 = [-p; p];

% Solve the system of linear equations
[x2, fval2] = linprog(f2, A2, b2); disp(x2);

% Display predicted parameters
fprintf("Prediction Parameters:\n"); 
fprintf("a = %f\n", x2(1));
fprintf("b = %f\n", x2(2));
fprintf("c = %f\n", x2(3));

% Display predicted prices for each observation
predicted2 = N * [x2(1); x2(2); x2(3)];
fprintf("\nPredicted Prices:\n");
fprintf("%f\n", predicted2);

% Display fval
fprintf("\nfval = %.5f\n", fval2);


%% Question 3
fprintf("\n\nQUESTION 3\n");

% Weighting matrix
w = [10, 1, 1, 1, 1];
W = diag(w);

% Solve the system of linear equations
x3 = (N' * W * N) \ (N' * W * p);

% Display predicted parameters
fprintf("\nPrediction Parameters:\n"); 
fprintf("a = %f\n", x3(1));
fprintf("b = %f\n", x3(2));
fprintf("c = %f\n", x3(3));

% Display predicted prices for each observation
predicted3 = N * [x3(1); x3(2); x3(3)];
fprintf("\nPredicted Prices:\n");
fprintf("%f\n", predicted3);

% Calculate and display sum of square deviations
sos = sum(w' .* (p - predicted3).^2);
fprintf("\nsos = %.5f\n", sos);

