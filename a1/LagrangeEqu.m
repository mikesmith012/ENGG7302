%% Function that defines the set of Lagrange Equations
%
% Params:
%  -> x: array of variable to be solved
%
% Returns:
%  -> equ: system of equations defined in the function
%
function equ = LagrangeEqu(x)

    % parameter assignment
    x1 = x(1);  % x
    x2 = x(2);  % y
    x3 = x(3);  % z
    x4 = x(4);  % lambda

    % equation 1: df/dx = lambda * dg/dx
    equ(1) = x3 + x4 - x2*(x3/50 - 1) - 50;
        
    % equation 2: df/dy = lambda * dg/dy
    equ(2) = x3 + x4 - x1*(x3/50 - 1) - 50;
        
    % equation 3: df/dz = lambda * dg/dz
    equ(3) = x2 + x4 - x1*(x2/50 - 1) - 50;
        
    % equation 4: constraint function
    equ(4) = x1 + x2 + x3 - 100;

end