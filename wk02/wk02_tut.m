%%% task 1.1: matrix multiplication %%%

mat1 = [
    1,  2; 
    3,  4; 
    5,  6;
];
mat2 = [
    7,  8,  9,  10; 
    11, 12, 13, 14;
];

c1 = mat1 * mat2; disp(c1);
c2 = mult_matrix(mat1, mat2); disp(c2);


%%% task 1.2: mesh and pcolor %%%
%mesh(c2);
%pcolor(c2);


%%% task 2.1 %%%
clear all;

% original
N = 10e6;
x(1) = 1000;
tic;
for k=2:N
    x(k) = 1.05 * x(k-1);
end
T1 = toc; %disp(T1);

% optimised
x = zeros(N, 1);
x(1) = 1000;
tic;
for k = 2:N
    x(k) = 1.05 * x(k-1);
end
T1 = toc; %disp(T1);


%%% task 2.2 %%%
clear all;

% original
N = 6e3;
x = randn(N);
y = zeros(N);
tic;
for r = 1:N % Row
    for c = 1:N % Column
        if x(r, c) >= 0
            y(r,c) =x (r, c);
        end
    end
end
T2=toc; % disp(T2);


%%% task 2.3 %%%


%%% task 2.4 %%%

% original
clear all;
dx = pi/100;
nx = 1 + 2*pi/dx;
tic;
for i = 1:nx
    x(i) = (i-1)*dx;
    y(i) = sin(3*x(i));
end
T4 = toc; disp(T4);

% optimised
clear all;
dx = pi/100;
nx = 1 + 2*pi/dx;
tic;
for i = 1:nx
    x(i) = (i-1)*dx;
end
y = sin(3*x);
T4 = toc; disp(T4);




