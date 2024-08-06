syms x [1 4];

%%% constraint function
g = x1 + x2 + x3 - 100;

% constraint function pde's
gfx = combine(collect(diff(g, x1)));
gfy = combine(collect(diff(g, x2)));
gfz = combine(collect(diff(g, x3)));

%%% object function
s = 0.5*(x1 + x2 + x3);
f = ((s-x1)*(s-x2)*(s-x3))/s;

% object function pde's
dfx = combine(collect(diff(f, x1)));
dfy = combine(collect(diff(f, x2)));
dfz = combine(collect(diff(f, x3)));

%%% lagrange equ
equ1 = dfx + x4*gfx == 0; disp(equ1);
equ2 = dfy + x4*gfy == 0; disp(equ2);
equ3 = dfz + x4*gfz == 0; disp(equ3);
equ4 = x1 + x2 + x3 == 100; disp(equ4);

%%% solve simultaneous non-linear equations
equ = @LagrangeEqu;
x0 = [1, 1, 1, 1];
sol = fsolve(equ, x0);
disp(sol);
