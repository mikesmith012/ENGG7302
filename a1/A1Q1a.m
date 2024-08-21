%% MATLAB code for A1 Q1 Part A
%  -> Used for checking the handwritten solutions for Part A


%% Declare an array of symbolic variables
% "x1 -> x"
% "x2 -> y"
% "x3 -> z"
% "x4 -> lambda"
syms x [1 4];


%% The Constraint Function

% Define the constraint function
fprintf("\nConstraint Function:\n");

% Constraint function: "x + y + z = 100"
g = x1 + x2 + x3 - 100;
fprintf("g = %s\n", g);

% Find the PDEs for the constraint functions
fprintf("\nConstraint Function PDE's:\n");
gfx = diff(g, x1); fprintf("dg/dx = %s\n", gfx); % "dg/dx"
gfy = diff(g, x2); fprintf("dg/dx = %s\n", gfy); % "dg/dy"
gfz = diff(g, x3); fprintf("dg/dx = %s\n", gfz); % "dg/dz"


%% The Object Function

% Define object function
fprintf("\nObject Function:\n");

% Semiperimeter: "s = 0.5(x + y + z) = 0.5 x 100 = 50"
s = 50;

% Object function: "f = r^2 = (s - x)(s - y)(s - y)/s"
f = (s - x1)*(s - x2)*(s - x3)/s; 
fprintf("f = %s\n", f);

% Find the PDEs for the object functions
fprintf("\nObject Function PDE's:\n");
dfx = combine(collect(diff(f, x1))); fprintf("df/dx = %s\n", dfx); % "df/dx"
dfy = combine(collect(diff(f, x2))); fprintf("df/dy = %s\n", dfy); % "df/dy"
dfz = combine(collect(diff(f, x3))); fprintf("df/dz = %s\n", dfz); % "df/dz"


%% Apply the Lagrange Equality "df = lambda*dg"
fprintf("\nLagrange Equations:\n");
equ1 = dfx + x4*gfx == 0; fprintf("equ1: %s\n", equ1); % df/dx = lambda * dg/dx 
equ2 = dfy + x4*gfy == 0; fprintf("equ2: %s\n", equ2); % df/dy = lambda * dg/dy
equ3 = dfz + x4*gfz == 0; fprintf("equ3: %s\n", equ3); % df/dz = lambda * dg/dz
equ4 = x1 + x2 + x3 == 100; fprintf("equ4: %s\n", equ4); % constraint function

% equations output:
% "equ1: x3 + x4 - x2*(x3/50 - 1) - 50 == 0"
% "equ2: x3 + x4 - x1*(x3/50 - 1) - 50 == 0"
% "equ3: x2 + x4 - x1*(x2/50 - 1) - 50 == 0"
% "equ4: x1 + x2 + x3 == 100"


%% Solve the system of non-linear equations
equ = @LagrangeEqu;     % initialise function that defines the set of lagrange equations
x0 = [1, 1, 1, 1];      % set initial guesses to 1 (avoids divide by 0 error)
options = optimoptions('fmincon', "MaxIterations", 1000);
sol = fsolve(equ, x0, options);  % calls "fsolve" to solve the system of equations
fprintf("\nResults:\n");
fprintf("x = %f\n", sol(1));
fprintf("y = %f\n", sol(2));
fprintf("z = %f\n", sol(3));

% solutions:
% x1 -> "x = 33.333333"
% x2 -> "y = 33.333333"
% x3 -> "z = 33.333333"
