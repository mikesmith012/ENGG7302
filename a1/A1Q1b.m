%% MATLAB code for A1 Q1 Part B

%% Declare the 1D Opt Function and associated parameters

% For a triangle with total perimeter of 100m, a single side must be between 0m and 50m
a = 0; b = 50; tol = 0.001;

% Declare x range: from 0 to 50 
x = linspace(a, b, (b-a)/tol + 1);

% Declare 1d function to be optimised
f = 4*x.^4 - (2*x.^2 - (100 - 2*x).^2).^2;

%% Plot the 1D Opt Fuction to be optimised
plot(x, f);
title("1D Opt Function");
xlabel("Side length x (m)");
ylabel("16 x Area^2 (m^2)");

%% Golden Section Search
x0_gss = GoldenSectionSearch(f, a, b, tol);
fprintf("Golden Section Search: x = %f\n", x0_gss);

%% Newton's Method
n = 100;
x0_nm = NewtonsMethod(x, f, a, b, n, tol);
fprintf("Newton's Method (n = %d): x = %f\n", n, x0_nm);

%% Results:
% "Golden Section Search: x = 33.333976"
% "Newton's Method (n = 100): x = 33.334572"
