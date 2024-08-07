% function that defines the set of lagrange equations
function equ = LagrangeEqu(x)

    % parameter assignment
    x1 = x(1);  % x
    x2 = x(2);  % y
    x3 = x(3);  % z
    x4 = x(4);  % lambda

    % equation 1: df/dx = lambda * dg/dx
    equ(1) = x4 + 4*x1*x2^2 + 4*x1*x3^2 - 4*x1^3;
        
    % equation 2: df/dy = lambda * dg/dy
    equ(2) = x4 + 4*x1^2*x2 + 4*x2*x3^2 - 4*x2^3;
        
    % equation 3: df/dz = lambda * dg/dz
    equ(3) = x4 + 4*x1^2*x3 + 4*x2^2*x3 - 4*x3^3;
        
    % equation 4: constraint function
    equ(4) = x1 + x2 + x3 - 100;

end