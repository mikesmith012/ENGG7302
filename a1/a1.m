% declare an array of symbolic variables
% "x1 -> x"
% "x2 -> y"
% "x3 -> z"
% "x4 -> lambda"
syms x [1 4];

% define constraint function
% "x + y + z = 100"
g = x1 + x2 + x3 - 100;

% find the partial differential equations for the constraint functions
gfx = combine(collect(diff(g, x1)));    % "dg/dx"
gfy = combine(collect(diff(g, x2)));    % "dg/dy"
gfz = combine(collect(diff(g, x3)));    % "dg/dz"

% define object function
% "r^2 = ((s-x)(s-y)(s-z))/s" where r is radius and s is semiperimeter
% "s = 0.5*(x + y + z)" -> semiperimeter in terms of x, y, z
s = 0.5*(x1 + x2 + x3);
f = ((s-x1)*(s-x2)*(s-x3))/s;

% find the partial differential equations for the object functions
dfx = combine(collect(diff(f, x1)));    % "df/dx"
dfy = combine(collect(diff(f, x2)));    % "df/dy"
dfz = combine(collect(diff(f, x3)));    % "df/dz"

% apply the lagrange equality "df = lambda*dg"
equ1 = dfx + x4*gfx == 0; fprintf("equ1: %s\n", equ1);      % df/dx = lambda * dg/dx 
equ2 = dfy + x4*gfy == 0; fprintf("equ2: %s\n", equ2);      % df/dy = lambda * dg/dy
equ3 = dfz + x4*gfz == 0; fprintf("equ3: %s\n", equ3);      % df/dz = lambda * dg/dz
equ4 = x1 + x2 + x3 == 100; fprintf("equ4: %s\n", equ4);    % constraint function

% equations output:
% "equ1: x4 - ...
%   (x1^2*(x2 + x3) - x1*(2*x2*x3 + x2^2 + x3^2) + x2*x3^2 + x2^2*x3 + x1^3 - x2^3 - x3^3) / ...
%   (4*x2*x3 + 2*x1^2 + 2*x2^2 + 2*x3^2 + x1*(4*x2 + 4*x3)) == 0"
% "equ2: x4 + ...
%   (x2*x3^2 - x1*(x2^2 - 2*x2*x3 + x3^2) - x2^2*x3 + x1^3 - x2^3 + x3^3 + x1^2*(x2 - x3)) / ...
%   (4*x2*x3 + 2*x1^2 + 2*x2^2 + 2*x3^2 + x1*(4*x2 + 4*x3)) == 0"
% "equ3: x4 - ...
%   (x1*(x2^2 - 2*x2*x3 + x3^2) + x2*x3^2 - x2^2*x3 - x1^3 - x2^3 + x3^3 + x1^2*(x2 - x3)) / ...
%   (4*x2*x3 + 2*x1^2 + 2*x2^2 + 2*x3^2 + x1*(4*x2 + 4*x3)) == 0"
% "equ4: x1 + x2 + x3 == 100"

% solve the system of non-linear equations
equ = @LagrangeEqu;     % initialise function that defines the set of lagrange equations
x0 = [1, 1, 1, 1];      % set initial guesses to 1 (avoids divide by 0 error)
sol = fsolve(equ, x0);  % calls "fsolve" to solve the system of equations
disp(sol);

% solutions output:
% x1 -> "x = 33.3333"
% x2 -> "y = 33.3333"
% x3 -> "z = 33.3333"
% x4 -> "lambda = -1.8519"
