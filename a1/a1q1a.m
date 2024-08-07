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
fprintf("\nConstraint Function PDE's:\n");
gfx = diff(g, x1);  fprintf("dg/dx: %s\n", gfx);    % "dg/dx"
gfy = diff(g, x2);  fprintf("dg/dx: %s\n", gfy);    % "dg/dy"
gfz = diff(g, x3);  fprintf("dg/dx: %s\n", gfz);    % "dg/dz"

% define object function
% "16*A^2 = 4*(x^2)*(y^2) - (x^2 + y^2 - z^2)^2" where A is area
f = 4*(x1^2)*(x2^2) - (x1^2 + x2^2 - x3^2)^2;
f = expand(f);

% find the partial differential equations for the object functions
fprintf("\nObject Function PDE's:\n");
dfx = diff(f, x1);  fprintf("df/dx: %s\n", dfx);    % "df/dx"
dfy = diff(f, x2);  fprintf("df/dy: %s\n", dfy);    % "df/dy"
dfz = diff(f, x3);  fprintf("df/dz: %s\n", dfz);    % "df/dz"

% apply the lagrange equality "df = lambda*dg"
fprintf("\nLagrange Equations:\n");
equ1 = dfx + x4*gfx == 0;   fprintf("equ1: %s\n", equ1);    % df/dx = lambda * dg/dx 
equ2 = dfy + x4*gfy == 0;   fprintf("equ2: %s\n", equ2);    % df/dy = lambda * dg/dy
equ3 = dfz + x4*gfz == 0;   fprintf("equ3: %s\n", equ3);    % df/dz = lambda * dg/dz
equ4 = x1 + x2 + x3 == 100; fprintf("equ4: %s\n", equ4);    % constraint function

% equations output:
% "equ1: x4 + 4*x1*x2^2 + 4*x1*x3^2 - 4*x1^3 == 0"
% "equ2: x4 + 4*x1^2*x2 + 4*x2*x3^2 - 4*x2^3 == 0"
% "equ3: x4 + 4*x1^2*x3 + 4*x2^2*x3 - 4*x3^3 == 0"
% "equ4: x1 + x2 + x3 == 100"

% solve the system of non-linear equations
equ = @LagrangeEqu;     % initialise function that defines the set of lagrange equations
x0 = [1, 1, 1, 1];      % set initial guesses to 1 (avoids divide by 0 error)
options = optimoptions('fmincon', "MaxIterations", 1000);
sol = fsolve(equ, x0, options);  % calls "fsolve" to solve the system of equations
fprintf("\nResults:\n");
fprintf("%s\n", sol);

% solutions:
% x1 -> "x = 33.3333"
% x2 -> "y = 33.3333"
% x3 -> "z = 33.3333"
