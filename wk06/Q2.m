%% Week 6 Tutorial Q2
clear, close all;

%% data set to fit
x = [1.2;2.3;3.0;3.8;4.7;5.9];
y = [1.1;2.1;3.1;4.0;4.9;5.9];

%% **************************************************************************
%--------------------------------LS solution-------------------------------
% it produces model a*x+b to fit the data set (x,y)
fit(x, y, 'poly1') % matlab LS routine

% from the fit function
a = 1.051;
b = -0.1433;

% from the hand calculation
% a = 0.96643;
% b = 0.15028;

figure;
plot(x, y, 'go')
hold on;
xx = [1:0.5:6];
yy = a*xx + b; 
hold on; plot(xx, yy, 'r')
