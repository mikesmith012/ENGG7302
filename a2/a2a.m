%% ENGG7302 Assignment 2 Part A
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
disp("Number of observations"); disp(n);    % Number of observations
disp("Types of chairs"); disp(t);           % Types of chairs


%% Question 1
fprintf("\n\nQUESTION 1\n\n");

% Function vector: [x1, x2, ..., xt, s1, s2, ..., sn]
% x1, x2, ..., xt = 0 -> don't minimise/maximise prediction parameters
% s1, s2, ..., sn = 1 or -1 -> minimise or maximise respectively
f = [zeros(1, t), ones(1, n)];  % minimise s1, s2, ..., sn
disp("Function vector"); disp(f);     

% Coefficients of prediction parameters (from the observation matrix)
A = [
    -N, -eye(n);    % Positive deviation: -N - S <= -P
     N, -eye(n);    % Negative deviation:  N - S <=  P
]; disp("Coefficients of prediction parameters"); disp(A);

% Observed prices (positive and negative deviations)
b = [-p; p]; disp("Observed prices"); disp(b');

% Solve the system of linear equations
x = linprog(f, A, b); disp(x);

% Display predicted parameters
fprintf("\nPrediction Parameters:\n"); 
fprintf("a = %f\n", x(1));
fprintf("b = %f\n", x(2));
fprintf("c = %f\n", x(3));

% Display predicted prices for each observation
predicted = N * [x(1); x(2); x(3)];
fprintf("\nPredicted Prices:\n");
fprintf("%f\n", predicted);


%% Question 2
fprintf("\n\nQUESTION 2\n\n");

% Function vector: [x1, x2, ..., xt, s]
% x1, x2, ..., xt = 0 -> don't minimise/maximise prediction parameters
% s = 1 or -1 -> minimise or maximise respectively
f = [zeros(1, 3), ones(1, 1)];  % minimise s
disp("Function vector"); disp(f);

% Coefficients of prediction parameters (from the observation matrix)
A = [
    -N, -ones(n, 1);    % Positive deviation: -N - S <= -P
     N, -ones(n, 1);    % Negative deviation:  N - S <=  P
]; disp("Coefficients of prediction parameters"); disp(A);

% Observed prices (positivee and negative deviations)
b = [-p; p]; disp("Observed prices"); disp(b');

% Solve the system of linear equations
x = linprog(f, A, b); disp(x);

% Display predicted parameters
fprintf("\nPrediction Parameters:\n"); 
fprintf("a = %f\n", x(1));
fprintf("b = %f\n", x(2));
fprintf("c = %f\n", x(3));

% Display predicted prices for each observation
predicted = N * [x(1); x(2); x(3)];
fprintf("\nPredicted Prices:\n");
fprintf("%f\n", predicted);


%% Question 3
fprintf("\n\nQUESTION 3\n\n");

% Weighting matrix
W = diag([10, 1, 1, 1, 1]);

% Solve the system of linear equations
x = (N' * W * N) \ (N' * W * p);

% Display predicted parameters
fprintf("\nPrediction Parameters:\n"); 
fprintf("a = %f\n", x(1));
fprintf("b = %f\n", x(2));
fprintf("c = %f\n", x(3));

% Display predicted prices for each observation
predicted = N * [x(1); x(2); x(3)];
fprintf("\nPredicted Prices:\n");
fprintf("%f\n", predicted);

sos = 0;
for i = 1:length(p)
    if i == 1
        sos = sos + 10*(p(i) - predicted(i))^2;
    else
        sos = sos + (p(i) - predicted(i))^2;
    end
end
disp(sos);

